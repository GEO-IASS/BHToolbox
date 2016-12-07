function maxIndex = maxCnt(cntVec, datVec)

cnt = zeros(1, length(cntVec));

for i = 1:length(cntVec)
    cnt(i) = sum(datVec == cntVec(i));
end

[~, maxIndex] = max(cnt);
maxIndex = cntVec(maxIndex);

end