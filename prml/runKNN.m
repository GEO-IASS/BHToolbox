% runKNN - run KNN algorithm to input features
% 
% Usage: decStat = runKNN(features, classifier)
%
% Arguments:
%   features:       K*N matrix, K is the number of features for each test  
%                   data
%                   N is the number of test data
%   classifier:     input classifier struct, should has at least features
%                   and targets two fields
% Returns:
%   decStat:        N vector contains of decStat for each test data

function [decStat,classifier] = runKNN(features, classifier, varargin)

if ~isfield(classifier, 'feature') && ~isfield(classifier, 'targets')
    error('classifier should has features and targets\n');
end

[k] = process_options(varargin, 'k', 1);
classifier.k = k;

testNum = size(features, 2);
decStat = zeros(1, testNum);

for i = 1:testNum
    dist = eucDist(features(:,i), classifier.feature);
    [~, sortIndex] = sort(dist);
    decStat(i) = sum(classifier.targets(sortIndex(1:k)))/k;
end

end