% runDlrt - run DLRT algorithm to input features
% 
% Usage: decStat = runKNN(features, classifier)
%
% Arguments:
%   features:       N*K matrix, K is the number of features for each test  
%                   data
%                   N is the number of test data
%   classifier:     input classifier struct, should has at least features
%                   and targets two fields
% Returns:
%   decStat:        N vector contains of decStat for each test data

function [decStat,classifier] = runDlrt(features, classifier, varargin)

if ~isfield(classifier, 'feature') && ~isfield(classifier, 'targets')
    error('classifier should has features and targets\n');
end

[k] = process_options(varargin, 'k', classifier.k);
classifier.k = k;

testNum = size(features, 1);
decStat = zeros(testNum, 1);

for i = 1:testNum
    dist = eucDist(features(i,:), classifier.feature);
    %[~, I] = sort(dist);
    %decStat(i) = sum(classifier.targets(sortIndex(1:k)))/k;
    n0 = size(classifier.feature(classifier.targets == 0,:),1);
    n1 = size(classifier.feature(classifier.targets == 1,:),1);
    D = size(features, 2);
    distk0 = sort(dist(classifier.targets == 0)); deltak0 = distk0(k);
    distk1 = sort(dist(classifier.targets == 1)); deltak1 = distk1(k);
    decStat(i) = log(n0/n1) + D*(log(deltak0)-log(deltak1));
end

end