function [testmfcc] = getTestMFCC(time, HopTime, MFCC)

len = time*1000/HopTime;

key = 1:length(MFCC);
key = key(randperm(length(key)));
testmfcc = MFCC(:,key <= len);

end