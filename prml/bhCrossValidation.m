function [pf, pd] = bhCrossValidation(H0, H1, numFolds, k)

[keys0, keys1] = generateKey(H0, ...
    H1, numFolds);
targetsTrain = [zeros(length(H0)/numFolds*(numFolds-1),1);...
    ones(length(H1)/numFolds*(numFolds-1), 1)];
targetsTest = [zeros(length(H0)/numFolds,1);...
    ones(length(H1)/numFolds,1)];
decStat = zeros(numFolds, size(targetsTest,1));
for thisFold = 1:numFolds
    featuresTrain = [H0(keys0 ~= thisFold,:);H1(keys1 ~= thisFold,:)];
    classifier = trainClassifier(featuresTrain', targetsTrain', 'type', 'knn');
    featuresTest = [H0(keys0 == thisFold,:);H1(keys1 == thisFold,:)];
    [decStat(thisFold,:),~] = runClassifier(featuresTest',classifier,'type','knn','k',k);
%     [pf(thisFold,:), pd(thisFold,:)] = bhroc(decStat(thisFold, 1:size(targetsTest,1)/2), ...
%         decStat(thisFold, (size(targetsTest,1)/2+1):end));
end
% pf = sum(pf,1)/numFolds; pd = sum(pd,1)/numFolds;
Class0 = decStat(:,1:size(targetsTest,1)/2); Class0 = Class0(:);
Class1 = decStat(:,(size(targetsTest,1)/2+1):end); Class1 = Class1(:);
[pf,pd] = bhroc(Class0,Class1);

end