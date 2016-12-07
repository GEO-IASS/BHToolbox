function A = bhsum1normalise(A)
% Make the entries of a (multidimensional) array sum to 1
%

z = sum(A(:));
A = A./z;
    
end