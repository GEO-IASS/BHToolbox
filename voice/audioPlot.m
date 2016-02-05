function ax = audioPlot(audio, varargin)

[titleStr, plotName] = process_options(varargin, ...
    'title', strcat('audio file: ', audio.name), 'plotName', 'amplitude');

%size(audio.frames,2)/(1000/audio.HopTime)

if strcmp(plotName, 'amplitude')
    if ~isfield(audio, 'amplitude')
        error('audio must have amplitude to plot');
    end
    dat = audio.y;
    x = (1:length(audio.y))/(audio.f);
elseif strcmp(plotName, 'energy')
    if ~isfield(audio, 'e')
        error('audio must have energy to plot');
    end
    dat = audio.e;
    x = (1:size(audio.frames, 2))/1000*(audio.HopTime);
elseif strcmp(plotName, 'zcr')
    if ~isfield(audio, 'z')
        error('audio must have zcr to plot');
    end
    dat = audio.z;
    x = (1:size(audio.frames, 2))/1000*(audio.HopTime);
end

plot(x, dat);
ax = gca;
title(titleStr);
xlabel('time:s');ylabel(plotName);

end