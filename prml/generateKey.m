function [keys0, keys1] = generateKey(H0, H1, numFolds)
    keys0 = rem((1:length(H0))-1,numFolds)+1;
    keys0 = keys0(randperm(length(keys0)));
    keys1 = rem((1:length(H1))-1,numFolds)+1;
    keys1 = keys1(randperm(length(keys1)));
end