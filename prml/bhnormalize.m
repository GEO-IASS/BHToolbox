function normaled = bhnormalize(mat, varargin)

[type] = process_options(varargin, ...
    'type', 'zmuv');

normaled = zeros(size(mat,1), size(mat,2));

if strcmp(type, 'zmuv')
    for i = 1:size(mat, 2)
        normaled(:,i) = (mat(:,i)-mean(mat(:,i)))/std(mat(:,i));
    end
end

end