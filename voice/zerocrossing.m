function z = zerocrossing(segments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute ZCR for each frame
% Can either be ZCR or EZR
% input:
%   segments:   audio data frames, M*N matrix
% output:
%   z:          zero crossing rate of each frame, 1*N vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

z = zeros(1, size(segments, 2));
    
for i = 1:size(segments, 2)
    N = length(segments(:,i));
    zc = (segments(:,i) >= 0) - (segments(:,i) < 0);
    z(i) = sum((zc(1:N-1) - zc(2:N)) ~= 0)/N;
end
    
end