function classifier = trainBayes(features, targets, varargin)

[option] = process_options(varargin, 'covar', 'diagonal');

classifier.type = 'bayes';
classifier.option = option;

classifier.feature = features;
classifier.targets = targets;

classifier.mu0 = mean(features(targets == 0,:),1);
classifier.mu1 = mean(features(targets == 1,:),1);
if strcmp(option, 'diagonal')
    classifier.sigma0 = [var(features(targets == 0,1)),0;0,var(features(targets == 0,2))];
    classifier.sigma1 = [var(features(targets == 1,1)),0;0,var(features(targets == 1,2))];
else
    classifier.sigma0 = cov(features(targets == 0,:),1);
    classifier.sigma1 = cov(features(targets == 1,:),1);
end
classifier.w1 = sum(targets)/length(targets);
classifier.w0 = 1 - classifier.w1;

end