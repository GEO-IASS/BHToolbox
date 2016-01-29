function audio = audioInit(audioFile)
    
[audio.path, audio.name, audio.format] = fileparts(audioFile);
[y,Fs] = audioread(audioFile);
audio.y = y';
audio.f = Fs;
audio.dur = length(y)/Fs;

end