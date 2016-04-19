function classifier = trainSVM(features, targets, varargin)

[kernel] = process_options(varargin, 'kernel', 'linear');

classifier = svmtrain(features, targets, 'kernel_function', kernel);

classifier.type = 'svm';
classifier.kernel = kernel;

classifier.feature = features;
classifier.targets = targets;

end