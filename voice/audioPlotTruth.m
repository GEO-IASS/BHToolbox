% audioPlotTruth -  Use imagesc to plot the ground truth or orther labels
%                   of the audio file
% 
% Usage: axis = audioPlotTruth(audio, varargin)
%
% Arguments:
%   audio:          audio structure
%   vargin:         
%       'title':    title for plot
%       'truthNum': the rows in audio.truth.data to plot
% Returns:
%   ax:             handle of the axis

function ax = audioPlotTruth(audio, varargin)

[titleStr, truthNum] = process_options(varargin, ...
    'title', 'Transcribed Truth', 'truthNum', 1:audio.truth.num);

x = (1:size(audio.truth.data,2))/1000*audio.HopTime;
imagesc(x, 1:length(truthNum), audio.truth.data(truthNum,:));
ax = gca; 
ax.YTick = 1:1:length(truthNum);
ax.YTickLabel = audio.truth.name(truthNum);
xlabel('time:s', 'fontsize', 14);
ylabel('Speaker', 'fontsize', 14);
title(titleStr, 'fontsize', 14);
colormap(flipud(gray(256)));

end