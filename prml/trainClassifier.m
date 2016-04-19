function classifier = trainClassifier(features, targets, varargin)

[type, k, option, b, iterNum, th, output, kernel] = process_options(varargin, 'type', 'knn', 'k', 1, ...
    'covar', 'diagonal', 'boundary', [], 'iterNum', 500, 'thresh', 1e-2, 'output', 0, 'kernel', 'linear');

if strcmp(type, 'knn')
    classifier = trainKNN(features, targets);
elseif strcmp(type, 'bayes')
    classifier = trainBayes(features, targets, 'covar', option);
elseif strcmp(type, 'fld')
    classifier = trainFld(features, targets);
elseif strcmp(type, 'dlrt')
    classifier = trainDlrt(features, targets, 'k', k);
elseif strcmp(type, 'ld')
    classifier = trainLR(features, targets, 'iterNum', iterNum, 'thresh', th, 'output', output);
elseif strcmp(type, 'svm')
    classifier = trainSVM(features, targets, 'kernel', kernel);
elseif strcmp(type, 'rvm')
    classifier = trainRVM(features, targets, 'kernel', kernel);
elseif strcmp(type, 'rf')
    classifier = trainRF(features, targets, b);
end

end