% audioSegment -    segment audio files into frames with specific window
%                   length and overlap length
% 
% Usage: audio = audioSegment(audio, windowLen, overlap)
%
% Arguments:
%   audio:          audio structure
%   windowLen:      window duration, in miliseconds
%   overlap:        overlap duration, in miliseconds
% Returns:
%   audio:          audio structure

function audio = audioSegment(audio, windowLen, overlap)

audio.winTime = windowLen;
audio.HopTime = windowLen - overlap;

% windowLen and overlap is in miliseconds
dataNum = windowLen*audio.f/1000;
stepNum = (windowLen-overlap)*audio.f/1000;
frameNum = ceil(length(audio.y)/stepNum);

frames = zeros(1, stepNum*frameNum+dataNum);
frames(1:length(audio.y)) = audio.y;

audio.frames = zeros(dataNum, frameNum);

col = 1;
for i = 1:stepNum:stepNum*frameNum
    audio.frames(:,col) = frames(i:(i+dataNum-1));
    col = col+1;
end

% discard last few frames to make it matches the result of Dan Ellis' mfcc
% program
%audio.frames = audio.frames(:,1:end-ceil(audio.winTime/audio.HopTime));
    
end