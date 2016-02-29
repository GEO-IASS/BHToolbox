function [pf, pd] = bhroc(H0, H1, varargin)

[plotFlag, titleStr, intFlag, axs] = process_options(varargin, ...
    'plot', 0, 'title', 'ROC', 'integral', 0, 'ax', 0);

H0 = sort(H0);H0 = reshape(H0, 1, []);
H1 = sort(H1);H1 = reshape(H1, 1, []);
len = length(H0);

pf = zeros(1,len);pd = zeros(1, len);

if intFlag == 0
    for i = 1:len
        pf(i) = sum(H0 > H0(i))/length(H0);
        pd(i) = sum(H1 > H0(i))/length(H1);
    end

else
    [f0,xi0] = ksdensity(H0, min([H0,H1]):0.01:max([H0,H1]));
    [f1,xi1] = ksdensity(H1, min([H0,H1]):0.01:max([H0,H1]));
    for i = 1:length(xi0)-1
        pf(i) = trapz(xi0(i:length(xi0)), f0(i:length(xi0)));
        pd(i) = trapz(xi1(i:length(xi0)), f1(i:length(xi0)));
    end
end

if plotFlag ~= 0
    axs = gca;
    if max(pf) < 1
        pf = [0, pf, 1];
        pd = [0, pd, 1];
    end
    [pf, index] = sort(pf);
    pd = pd(index);
    plot(axs, pf, pd, 'linewidth', 2);
    title(titleStr);
    xlabel('P_F_A');ylabel('P_D');
    hold on;
    if plotFlag == 2
        plot(axs, 0:0.1:1, 0:0.1:1, '--k');
    end;
    hold off;
    axis([0 1 0 1])
end

end