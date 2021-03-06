function classifier = trainKNN(features, targets, varargin)

[k] = process_options(varargin, 'k', 1);

classifier.type = 'knn';

classifier.k = k;

classifier.feature = features;
classifier.targets = targets;

end