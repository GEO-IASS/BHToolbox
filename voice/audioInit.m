% audioInit - Init an audio structure
% 
% Usage: audio = audioInit(fullfile(audioPath, audioName))
%
% Arguments:
%   audioFile:      absolute path of audio file
% Returns:
%   audio:          an audio structure

function audio = audioInit(audioFile)
    
[audio.path, audio.name, audio.format] = fileparts(audioFile);
if strcmp(audio.format, '.wav')
    [y,Fs] = audioread(audioFile);
elseif strcmp(audio.format, '.sph')
    [y,Fs,~,~,~] = readsph(audioFile);
end
audio.y = y';
audio.f = Fs;
audio.dur = length(y)/Fs;

end