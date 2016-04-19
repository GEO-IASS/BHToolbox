% setGroundTruth -  set ground truth (or label) of the audio file
% 
% Usage: audio = setGroundTruth(audio, truthMat, varargin)
%
% Arguments:
%   audio:          audio structure
%   truthMat:       matrix of the truth of label to set, should have the
%                   same num of columns as audio.frames
%   vargin:         
%       'name':   	name of the truth or label
% Returns:
%   audio:          audio structure

function audio = setGroundTruth(audio, truthMat, varargin)

[truthName] = process_options(varargin, ...
    'name', 'SPEECH');

timeDur = audio.HopTime;

if isfield(audio, 'truth')
    audio.truth.name = [audio.truth.name, cellstr(truthName)];
    audio.truth.data = [audio.truth.data; zeros(1, max(size(audio.frames, 2),...
        size(audio.truth.data,2)))];
    audio.truth.num = audio.truth.num + 1;
else
    audio.truth.name = cellstr(truthName);
    audio.truth.data = zeros(1, size(audio.frames, 2));
    audio.truth.num = 1;
end

for j = 1:size(truthMat, 1)
    if sum(isnan(truthMat(j,:))) == 0
        for k = max(round(truthMat(j,1)*1000/timeDur), 1):round(truthMat(j,2)*1000/timeDur)
            audio.truth.data(audio.truth.num, k) = 1;
        end
    end
end
audio.truth.data = audio.truth.data(:,1:size(audio.frames,2));

end