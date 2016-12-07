function [loglik, index] = findHighestSeconds(logdif, target, targetNum, time, threshold)

% loglik = logdif.*(target == targetNum);
% [loglik, index] = sort(loglik, 'descend');
% loglik = loglik(1:time*100);
% index = index(1:time*100);
% 
% % remove extra frames
% index = index(loglik > 0);
% loglik = loglik(loglik > 0);
% index = index(loglik > threshold);
% loglik = loglik(loglik > threshold);

indexReturn = 1:length(logdif);
loglik = logdif(target == targetNum);
indexReturn = indexReturn(target == targetNum);
[loglik, index] = sort(loglik, 'descend');
loglik = loglik(1:min(time*100,length(loglik)));
index = index(1:min(time*100,length(loglik)));
index = index(loglik > threshold);
index = indexReturn(index);
loglik = loglik(loglik > threshold);

end