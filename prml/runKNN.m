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

function decStat = runKNN(features, classifier, varargin)

if ~isfield(classifier, 'feature') && ~isfield(classifier, 'targets')
    error('classifier should has features and targets\n');
end

[k] = process_options(varargin, 'k', 1);

testNum = size(features, 2);
decStat = zeros(1, testNum);

for i = 1:testNum
    
end

end