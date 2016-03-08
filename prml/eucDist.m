% eucDist - compute euclidian distance between reference data points and
% datas
% 
% Usage: dist = eucDist(ref, datas)
%
% Arguments:
%   refs:           K*N matrix, K is dimensions for each data point and N 
%                   is the number of data
%   datas:          K*M matrix, K is dimensions for each data point and N 
%                   is the number of data
% Returns:
%   dist:           N*M vector contains distance between each point in ref
%                   and each point in datas

function dist = eucDist(refs, datas)

N = size(refs, 2);
M = size(datas, 2);

dist = zeros(N, M);

for i = 1:N
    for j = 1:M
%         if sum(isnan(refs(:,i))) == 0
             dist(i,j) = sqrt(sum((refs(~isnan(refs(:,i)),i)-datas(~isnan(refs(:,i)),j)).^2));
%         else
%             dist(i,j) = sqrt(sum((refs(~isnan(refs(:,i)),i)-datas(~isnan(refs(:,i),j))).^2));
%         end
    end
end

end