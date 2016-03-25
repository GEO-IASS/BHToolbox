function classifier = trainClassifier(features, targets, varargin)

[type, k] = process_options(varargin, 'type', 'knn', 'k', 1);

if strcmp(type, 'knn')
    classifier = trainKNN(features, targets);
elseif strcmp(type, 'bayes')
    classifier = trainBayes(features, targets);
elseif strcmp(type, 'fld')
    classifier = trainFld(features, targets);
elseif strcmp(type, 'dlrt')
    classifier = trainDlrt(features, targets, 'k', k);
end

end