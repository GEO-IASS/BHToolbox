% energy -          Compute energy for each frame
% 
% Usage: e = energy(frames)
%
% Arguments:
%   frames:         audio data frames, M*N matrix
% Returns:
%   e:              energy of each frame, 1*N vector
function e = energy(frames)

e = zeros(1, size(frames, 2));
for i = 1:size(frames, 2)
    e(i) = sum(frames(:,i).^2);
end

end