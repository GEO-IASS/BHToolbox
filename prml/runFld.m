function [decStat,classifier] = runFld(features, classifier)

decStat = zeros(size(features,1),1);
w = pinv(classifier.sw)*transpose(classifier.mu1-classifier.mu0);
for cnt = 1:size(features,1)
    decStat(cnt) = w'*transpose(features(cnt,:));
end

end