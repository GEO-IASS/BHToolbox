function [norPd, norPf, ax] = nornorROC(pf, pd)

norPf = norminv([-inf, pf], 0, 1);
%norPf = norPf(~isnan(norPf) & isfinite(norPf));
norPd = norminv([-inf, pd], 0, 1);
%norPd = norPd(~isnan(norPd) & isfinite(norPd));

plot(norPf, norPd, 'linewidth', 2);
xlabel('normal P_F');ylabel('normal P_D');
title('normal-normal ROC');
ax = gca;

% xtick = unique(pf);ytick = unique(pd);
% lenx = length(xtick);leny = length(ytick);
% if lenx > 10
% xtick = [xtick(round(lenx*0.1)),xtick(round(lenx*0.2)),xtick(round(lenx*0.3)),...
%     xtick(round(lenx*0.4)),xtick(round(lenx*0.5)),xtick(round(lenx*0.6)),xtick(round(lenx*0.7)),...
%     xtick(round(lenx*0.8)),xtick(round(lenx))];
% end
% if leny > 10
% ytick = [ytick(round(leny*0.1)),ytick(round(leny*0.2)),ytick(round(leny*0.3)),...
%     ytick(round(leny*0.4)),ytick(round(leny*0.5)),ytick(round(leny*0.6)),ytick(round(leny*0.7)),...
%     ytick(round(leny*0.8)),ytick(round(leny))];
% end
% ax.XTick = sort(xtick);ax.YTick = sort(ytick);


end