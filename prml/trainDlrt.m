function classifier = trainDlrt(features, targets, varargin)

[k] = process_options(varargin, 'k', 1);

classifier.type = 'dlrt';

classifier.k = k;

classifier.feature = features;
classifier.targets = targets;

end