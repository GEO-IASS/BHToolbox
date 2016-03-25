function classifier = trainFld(features, targets, varargin)

classifier.type = 'fld';

classifier.feature = features;
classifier.targets = targets;

classifier.mu0 = mean(features(targets == 0,:),1);
classifier.mu1 = mean(features(targets == 1,:),1);

% nums0 = numel(classifier.targets(classifier.targets == 0));
% nums1 = numel(classifier.targets(classifier.targets == 1));
% s0 = (features(targets==0,:)-repmat(classifier.mu0,nums0,1))*...
%     transpose(features(targets==0,:)-repmat(classifier.mu0,nums0,1));

H0 = features(classifier.targets==0,:);
H1 = features(classifier.targets==1,:);
s0 = zeros(2,2,size(H0,1));
s1 = zeros(2,2,size(H1,1));
for i = 1:size(H0,1)
    s0(:,:,i) = transpose(H0(i,:)-classifier.mu0)*(H0(i,:)-classifier.mu0);
end
for i = 1:size(H1,1)
    s1(:,:,i) = transpose(H1(i,:)-classifier.mu1)*(H1(i,:)-classifier.mu1);
end

classifier.sw = sum(s0,3) + sum(s1,3);

end