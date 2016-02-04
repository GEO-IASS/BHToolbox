function decStat = runClassifier(features, classifier, varargin)

[type] = process_options(varargin, 'type', 'knn');

if strcmp(type, 'knn')
    decStat = trainKNN(features, classifier);
end

end