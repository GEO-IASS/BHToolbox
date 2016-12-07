function [Seg, audio] = getFirstSeg(time, audio, truthNum)

%Seg = zeros(1, time*1000/audio.HopTime);
len = time*1000/audio.HopTime;
available = [];
for i = 1:size(audio.frames, 2)
    if audio.truth.data(truthNum, i) == 1 && audio.testIndex(i) == 1 ...
            %&& audio.testIndex(i) ~= 3 && audio.testIndex(i) ~= 2
        %cnt = cnt + 1;
        %audio.testIndex(i) = 2;
        %Seg(cnt) = i;
        available = [available,i];
    end
%     if cnt == time*1000/audio.HopTime;
%         break;
%     end
end

key = 1:length(available);
key = key(randperm(length(key)));
Seg = available(key <= len);
audio.testIndex(Seg) = 2;

end