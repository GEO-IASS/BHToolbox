function audio = setGroundTruth(audio, truthMat, varargin)

[truthName] = process_options(varargin, ...
    'name', 'SPEECH');

timeDur = audio.HopTime;

if isfield(audio, 'truth')
    audio.truth.name = [audio.truth.name, cellstr(truthName)];
    audio.truth.data = [audio.truth.data; zeros(1, size(audio.frames, 2))];
    audio.truth.num = audio.truth.num + 1;
else
    audio.truth.name = cellstr(truthName);
    audio.truth.data = zeros(1, size(audio.frames, 2));
    audio.truth.num = 1;
end

for j = 1:size(truthMat, 1)
    for k = max(round(truthMat(j,1)*1000/timeDur), 1):round(truthMat(j,2)*1000/timeDur)
        audio.truth.data(audio.truth.num, k) = 1;
    end
end

end