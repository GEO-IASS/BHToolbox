% zerocrossing -    compute zero crossing rate for each frame
% 
% Usage: z = zerocrossing(frames)
%
% Arguments:
%   frames:         audio frames data, M*N matrix
% Returns:
%   z:              zero crossing rate of each frame, 1*N vector

function z = zerocrossing(frames)

z = zeros(1, size(frames, 2));
    
for i = 1:size(frames, 2)
    N = length(frames(:,i));
    zc = (frames(:,i) >= 0) - (frames(:,i) < 0);
    z(i) = sum((zc(1:N-1) - zc(2:N)) ~= 0)/N;
end
    
end