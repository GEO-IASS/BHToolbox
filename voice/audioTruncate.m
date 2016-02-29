function audio = audioTruncate(audio)

if isfield(audio, 'e')
    audio.e = audio.e(1:size(audio.mfcc,2));
end
if isfield(audio, 'z')
    audio.z = audio.z(1:size(audio.mfcc,2));
end
if isfield(audio, 'amplitude')
    audio.amplitude = audio.amplitude(1:size(audio.mfcc,2));
end
if isfield(audio, 'testIndex')
    audio.testIndex = audio.testIndex(1:size(audio.mfcc,2));
end
audio.frames = audio.frames(:,1:size(audio.mfcc,2));

end