% eucDist - compute euclidian distance between reference data points and
% datas
% 
% Usage: dist = eucDist(ref, datas)
%
% Arguments:
%   refs:           N*K matrix, K is dimensions for each data point and N 
%                   is the number of data
%   datas:          M*K matrix, K is dimensions for each data point and M 
%                   is the number of data
% Returns:
%   dist:           N*M vector contains distance between each point in ref
%                   and each point in datas

function dist = eucDist(refs, datas)

N = size(refs, 1);
M = size(datas, 1);

dist = zeros(N, M);

for i = 1:N
    for j = 1:M
        dist(i,j) = sqrt(sum((refs(i,:)-datas(j,:)).^2));
%         if sum(isnan(refs(:,i))) == 0
             %dist(i,j) = sqrt(sum((refs(~isnan(refs(i,:)),i)-datas(~isnan(refs(i,:)),j)).^2));
%         else
%             dist(i,j) = sqrt(sum((refs(~isnan(refs(:,i)),i)-datas(~isnan(refs(:,i),j))).^2));
%         end
    end
end

end