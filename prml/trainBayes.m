function classifier = trainBayes(features, targets, varargin)

classifier.type = 'bayes';

classifier.feature = features;
classifier.targets = targets;

classifier.mu0 = mean(features(targets == 0,:),1);
classifier.mu1 = mean(features(targets == 1,:),1);
classifier.sigma0 = cov(features(targets == 0,:),1);
classifier.sigma1 = cov(features(targets == 1,:),1);
classifier.w1 = sum(targets)/length(targets);
classifier.w0 = 1 - classifier.w1;

end