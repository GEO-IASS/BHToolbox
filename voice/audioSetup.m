% audioSetup -      set up audio structure with specific features
%                   audio should already be segmented
% 
% Usage: audio = audioSetup(audio, varargin)
%
% Arguments:
%   audio:          audio structure
%   vargin:         
%       'energy':   set up energy (default 0)
%       'zcr':      set up zero crossing rate(default 0)
%       'MFCC': 	set up MFCC(default 0)
%       'amplitude':set up amplitude for each frame(default 0)
% Returns:
%   audio:          audio structure

function audio = audioSetup(audio, varargin)

[eIns, zIns, MFCCIns, ampIns, testIndex, PLPIns] = process_options(varargin, ...
    'energy', 0, 'zcr', 0, 'MFCC', 0, 'amplitude', 0, ...
    'testIndex', zeros(1,size(audio.frames,2)), 'plp', 0);

if eIns ~= 0
    audio.e = energy(audio.frames);
    if eIns == 2
        audio.e = (audio.e-mean(audio.e))/var(audio.e);
    end
end

if zIns ~= 0
    audio.z = zerocrossing(audio.frames);
    if zIns == 2
        audio.z = (audio.z-mean(audio.z))/var(audio.z);
    end
end

if MFCCIns == 19
    mfccFrames = melfcc(audio.y, audio.f, 'lifterexp', -22, 'nbands', 26, ...
        'maxfreq', 8000, 'sumpower', 0, 'fbtype', 'htkmel', 'dcttype', 3, ...
        'numcep', 20, 'wintime', audio.winTime/1000, 'hoptime', audio.HopTime/1000);
    audio.mfcc = mfccFrames(2:20,:);
    audio = audioTruncate(audio);

elseif MFCCIns == 36
    % get mfcc
    [mfcc, ~, ~] = melfcc(audio.frames, audio.f, 'lifterexp', -22, 'nbands', 20, ...
        'maxfreq', 8000, 'sumpower', 0, 'fbtype', 'htkmel', 'dcttype', 3, ...
        'numcep', 13, 'wintime', audio.winTime/1000, 'hoptime', audio.HopTime/1000);
    frameNum = size(mfcc,2);
    mfccFrames = zeros(36, frameNum);
    N = 2;

    mfccFrames(1:12,:) = mfcc(2:13,:);
    mfcc = [mfcc(2:13,1),mfcc(2:13,1),mfcc(2:13,:),mfcc(2:13,end),mfcc(2:13,end)];

    % get 1st derivatives
    const = 2*sum((1:N).^2);
    for i = 3:(frameNum+2)
        s = zeros(12, 1);
        for n = 1:N
            s = s + n.*(mfcc(:,i+n)-mfcc(:,i-n));
        end
        mfccFrames(13:24,i-2) = s./const;
    end

    mfcc = [mfccFrames(13:24,1),mfccFrames(13:24,1),mfccFrames(13:24,:),mfccFrames(13:24,end),mfccFrames(13:24,end)];

    %get 2nd derivatives
    for i = 3:(frameNum+2)
        s = zeros(12, 1);
        for n = 1:N
            s = s + n.*(mfcc(:,i+n)-mfcc(:,i-n));
        end
        mfccFrames(25:36,i-2) = s./const;
    end
    audio.mfcc = mfccFrames;
    audio = audioTruncate(audio);
end

if ampIns ~= 0
    audio.amplitude = audio.frames(floor(size(audio.frames, 1)/2),:);
end

if PLPIns ~= 0
%     [cepstra,~,~] = melfcc(audio.y,audio.f,'preemph',0,'modelorder',PLPIns,'numcep',PLPIns+1,'dcttype',1,'dither',1,'nbands',...
%         ceil(hz2bark(audio.f/2))+1,'fbtype','bark','usecmp',1);
    [cepstra, ~, ~, ~, ~, ~] = rastaplp(audio.y, audio.f, 1, PLPIns);
    %audio.mfcc = [cepstra;diff(cepstra);diff(diff(cepstra))];
    mfccFrames = melfcc(audio.y, audio.f, 'lifterexp', -22, 'nbands', 26, ...
        'maxfreq', 8000, 'sumpower', 0, 'fbtype', 'htkmel', 'dcttype', 3, ...
        'numcep', 20, 'wintime', audio.winTime/1000, 'hoptime', audio.HopTime/1000);
    audio.mfcc = [mfccFrames(2:20,:);cepstra(2:end,:)];
    audio = audioTruncate(audio);
end

audio.testIndex = testIndex;

end