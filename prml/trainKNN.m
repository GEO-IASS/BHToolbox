function classifier = trainKNN(features, targets, varargin)

classifier.type = 'knn';

classifier.feature = features;
classifier.targets = targets;

end