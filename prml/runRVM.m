function [decStat,classifier] = runRVM(classifier,features, varargin)

decStat = zeros(size(features,1),1);

BASIS	= classifier.kernel(features,classifier.feature(classifier.parameter.Relevant,:));

for i = 1:size(features,1)
    decStat(i) = BASIS(i,:)*classifier.parameter.Value;
end

end