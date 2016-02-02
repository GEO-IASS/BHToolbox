function e = energy(frames)
%--------------------------------------------------------------------------
% Compute energy for each frame
% input:
%   frames:   audio data frames, M*N matrix
% output:
%   e:        energy of each frame, 1*N vector
%--------------------------------------------------------------------------

e = zeros(1, size(frames, 2));
for i = 1:size(frames, 2)
    e(i) = sum(frames(:,i).^2);
end

end