function [trainFeatures, trainTargets] = bhbagging(feature, target, numFolds)

trainFeatures = zeros(size(feature,1),size(feature,2),numFolds);
trainTargets = zeros(size(feature,1),1,numFolds);

for fold = 1:numFolds
    featureNum = randi(size(feature,1),1,size(feature,1));
    trainFeatures(:,:,fold) = feature(featureNum,:);
    trainTargets(:,:,fold) = target(featureNum);
end

end