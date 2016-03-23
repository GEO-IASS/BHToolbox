function plotClassifier(classifier, varargin)
    
[titleStr, className, plotData] = process_options(varargin, ...
    'title', 'Decision Surface ', 'className', {'H0','H1'}, 'plotData', 1);

x1range = max(classifier.feature(1,:)) - min(classifier.feature(1,:));
x2range = max(classifier.feature(2,:)) - min(classifier.feature(2,:));
x1 = linspace(min(classifier.feature(1,:))-0.1*x1range, max(classifier.feature(1,:))+0.1*x1range, 251);
x2 = linspace(min(classifier.feature(2,:))-0.1*x2range, max(classifier.feature(2,:))+0.1*x2range, 251);

% create grid of test data points
[xTest1, xTest2] = meshgrid(x1, x2);
xTest = [xTest1(:), xTest2(:)];

% run classifier with all data in space
if strcmp(classifier.type, 'knn')
    dsTest = runClassifier(xTest, classifier, 'k', classifier.k);
else
    dsTest = runClassifier(xTest, classifier, 'type', classifier.type);
end
dsTest = reshape(dsTest, length(x1), length(x2));

if strcmp(classifier.type,'knn')
colorLabel = cell(1, classifier.k+1);
for i = 1:classifier.k+1
    colorLabel(i) = cellstr(strcat(num2str(i-1),'/',num2str(classifier.k)));
end
end

imagesc(x1([1 end]), x2([2 end]), dsTest);
if strcmp(classifier.type,'knn')
    title(strcat(titleStr, '(k=', num2str(classifier.k), ')'));
else
    title(titleStr);
end
if strcmp(classifier.type,'knn')
colormap(summer(classifier.k+1));
colorbar('Ticks', linspace(0,1,classifier.k+1), 'TickLabels', colorLabel);
end
set(gca,'YDir','normal')

if plotData ~= 0
    hold on;
    plot(classifier.feature(classifier.targets==0,1), classifier.feature(classifier.targets==0,2), ...
        'bs');
    plot(classifier.feature(classifier.targets==1,1), classifier.feature(classifier.targets==1,2), ...
        'rs');
    hold off;
    legend(className);
end

xlabel('feature 1');ylabel('feature 2');

end