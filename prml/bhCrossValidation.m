function [Class0, Class1, varargout] = bhCrossValidation(H0, H1, numFolds, varargin)

[type, k, option, treeNum, iterNum, th, output, kernel] = process_options(varargin, 'type', 'knn', 'k', 1, ...
    'covar', 'diagonal', 'tree', 100, 'iterNum', 500, 'thresh', 1e-2, 'output', 0, 'kernel', 'linear');

[keys0, keys1] = generateKey(H0, H1, numFolds);
targetsTrain = [zeros(length(H0)/numFolds*(numFolds-1),1);...
    ones(length(H1)/numFolds*(numFolds-1), 1)];
targetsTest = [zeros(length(H0)/numFolds,1);...
    ones(length(H1)/numFolds,1)];
decStat = zeros(numFolds, size(targetsTest,1));
for thisFold = 1:numFolds
    featuresTrain = [H0(keys0 ~= thisFold,:);H1(keys1 ~= thisFold,:)];
    featuresTest = [H0(keys0 == thisFold,:);H1(keys1 == thisFold,:)];
    if strcmp(type,'knn')
        classifier = trainClassifier(featuresTrain, targetsTrain, 'type', type, 'k', k);
        [decStat(thisFold,:),~] = runClassifier(featuresTest,classifier,'type','knn','k',k);
    elseif strcmp(type, 'dlrt')
        classifier = trainClassifier(featuresTrain, targetsTrain, 'type', type, 'k', k);
        [decStat(thisFold,:),~] = runClassifier(featuresTest,classifier,'type','dlrt','k',k);
    elseif strcmp(type, 'ld')
        classifier = trainClassifier(featuresTrain, targetsTrain, 'type', type, 'iterNum', iterNum, 'thresh', th, 'output', output);
        [decStat(thisFold,:),~] = runClassifier(featuresTest,classifier,'type','ld');
    elseif strcmp(type, 'rf')
        classifier = TreeBagger(treeNum,featuresTrain,targetsTrain, 'Method','classification');
        decStat(thisFold,:) = str2num(cell2mat(predict(classifier,featuresTest)));
    elseif strcmp(type, 'svm')
        classifier = trainSVM(featuresTrain, targetsTrain, 'kernel', kernel);
        [decStat(thisFold,:),~] = runClassifier(featuresTest,classifier,'type','svm');
    elseif strcmp(type, 'rvm')
        classifier = trainRVM(featuresTrain, targetsTrain, 'kernel', kernel);
        [decStat(thisFold,:),~] = runClassifier(featuresTest,classifier,'type','rvm');
    else
        classifier = trainClassifier(featuresTrain, targetsTrain, 'type', type, 'covar', option);
        [decStat(thisFold,:),~] = runClassifier(featuresTest,classifier,'type', type);
    end
%     [pf(thisFold,:), pd(thisFold,:)] = bhroc(decStat(thisFold, 1:size(targetsTest,1)/2), ...
%         decStat(thisFold, (size(targetsTest,1)/2+1):end));
end
% pf = sum(pf,1)/numFolds; pd = sum(pd,1)/numFolds;
Class0 = decStat(:,1:size(H0,1)/numFolds); Class0 = Class0(:);
Class1 = decStat(:,(size(H0,1)/numFolds+1):end); Class1 = Class1(:);
%[pf,pd] = bhroc(Class0,Class1);

varargout{1} = keys0;
varargout{2} = keys1;

end