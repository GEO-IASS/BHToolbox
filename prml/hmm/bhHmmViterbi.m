function [mostLikSeq,logProb] = bhHmmViterbi(frameLogProb,startLogProb,transLogProb)
%BHHMMVITERBI calculate most probable state path and framewise log prob
%   frameLogProb: M*N matrix of log probability P(O|model), M is the length
%   of sequence and N is the number of states
%   startLogProb: N*1 array, log initial probability
%   transLogProb: N*N matrix of log transition probability

nStates = length(startLogProb);
nSeq = size(frameLogProb,1);
logProb = zeros(nSeq,nStates);
mostLikSeq = zeros(1,nSeq);
backTrace = zeros(nSeq,nStates);

% this is for making backtrace just record the maxim path from single app
% on
%appOnStates = 1:length(startLogProb);
appOnStates = [0 1 2 3 6 9 18 27 54 81 162 243 496 729 1458] + 1;

%% initial
logProb(1,:) = startLogProb'+frameLogProb(1,:);

%% forward
for seq = 2:nSeq
    for state = 1:nStates
        [logProb(seq,state),backTrace(seq-1,state)] = max(logProb(seq-1,appOnStates)+transLogProb(appOnStates,state)'+frameLogProb(seq,state));
    end
end

%% backward
[~,mostLikSeq(nSeq)] = max(logProb(nSeq,:));
for seq = nSeq-1:-1:1
    mostLikSeq(seq) = backTrace(seq,mostLikSeq(seq+1));
end

end