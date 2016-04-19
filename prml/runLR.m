function [decStat,classifier] = runLR(features, classifier)

decStat = zeros(size(features,1),1);
for i = 1:length(decStat)
    temp = classifier.beta'*transpose([1,features(i,:)]);
    decStat(i) = 1./(1+exp(-temp));
end

end