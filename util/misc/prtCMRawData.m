function prtCMRawData(ax, confMat)

confMat = confMat'; confMat = confMat(:);
fontIndex = [6:9,11:14,16:19,22:2:28];

cnt = 0;
for i = fontIndex
    cnt = cnt + 1;
    ax.Children(i).String = [num2str(confMat(17-cnt)/100),'s'];
    ax.Children(i).FontSize = 22;
end

end