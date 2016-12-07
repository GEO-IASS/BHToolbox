function plotDec(t,d,varargin)

[titleStr, frameLen, yLabel, axRange] = process_options(varargin, ...
    'title', 'Decision and Target Compare', 'frameLen', 10, 'yLabel', 'class', ...
    'axRange', [-inf inf -inf inf]);

figure;
plot((1:length(t))/(1000/frameLen), d, 'linewidth', 2);
hold on;
plot((1:length(t))/(1000/frameLen), t, 'linewidth', 5);
hold off;
ax = gca;
ax.YTick = min(d):1:max(d);
ax.YTickLabel = yLabel;
title(titleStr);
xlabel('time:s');ylabel('Speaker Id');
axis(axRange);
legend('decision', 'truth');

end