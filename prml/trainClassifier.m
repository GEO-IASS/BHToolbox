function classifier = trainClassifier(features, targets, varargin)

[type] = process_options(varargin, 'type', 'knn');

if strcmp(type, 'knn')
    classifier = trainKNN(features, targets);
elseif strcmp(type, 'bayes')
    classifier = trainBayes(features, targets);
end

end