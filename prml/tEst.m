clc; clear; dbstop if error;

%% generate random test dataset
dataNum = 50;
mu0 = [0,0]'; sigma0 = [1,0;0,1];
mu1 = [2,3]'; sigma1 = [2,0;0,2];
H0 = mvnrnd(mu0, sigma0, dataNum);
H1 = mvnrnd(mu1, sigma1, dataNum);
% H0 = bhnormalize(H0, 'type', 'zmuv');
% H1 = bhnormalize(H1, 'type', 'zmuv');

k = [1,3,5,7,11,15,19];

%% train
knnClassifier = trainClassifier([H0;H1]', [zeros(50,1);ones(50,1)]', 'type', 'knn');
auc = zeros(2, length(k));

for i = 1:length(k)
    % run
    [decStat, knnClassifier] = runClassifier([H0; H1]', knnClassifier, 'k', k(i), 'keepDat', 1);

    % visualize
    figure(1);
    subplot(2,4,i);
    plotClassifier(knnClassifier);
    
    subplot(2,4,8);
    %figure(2);
    hold on;
    [pf, pd] = bhroc(decStat(1:50), decStat(51:100), 'plot', 1, 'title', 'ROC of KNN');
    auc(1,i) = AUC(pf, pd);
end


%legend('k=1','k=3','k=5','k=7','k=11','k=15','k=19','k=25','k=30');
legend('k=1','k=3','k=5','k=7','k=11','k=15','k=19');
hold off;

%% train on seperate data
H0_test = mvnrnd(mu0, sigma0, dataNum);
H1_test = mvnrnd(mu1, sigma1, dataNum);

knnClassifier = trainClassifier([H0;H1]', [zeros(50,1);ones(50,1)]', 'type', 'knn');

for i = 1:length(k)
    % run
    [decStat, knnClassifier] = runClassifier([H0_test; H1_test]', knnClassifier, 'k', k(i), 'keepDat', 1);

    % visualize
    figure(3);
    subplot(2,4,i);
    plotClassifier(knnClassifier, 'plotData', 1);
    hold on;
    plot(H0_test(:,1), H0_test(:,2), 'b*', 'linewidth', 2);
    plot(H1_test(:,1), H1_test(:,2), 'r*', 'linewidth', 2);
    hold off;
    
    %subplot(2,4,8);
    figure(4);
    hold on;
    [pf, pd] = bhroc(decStat(1:50), decStat(51:100), 'plot', 1, 'title', 'ROC of KNN');
    auc(2,i) = AUC(pf, pd);
end


legend('k=1','k=3','k=5','k=7','k=11','k=15','k=19');
hold off;

%%
figure(5);
plot(1:length(k), auc(1,:), 'b', 'linewidth', 2);hold on;
plot(1:length(k), auc(2,:), 'r', 'linewidth', 2);hold off;
xlabel('k');ylabel('AUC');
ax = gca;
ax.XTick = 1:length(k);ax.XTickLabel = {'k=1','k=3','k=5','k=7','k=11','k=15','k=19'};
legend('training data', 'testing data');

%% blind test
load('C:\Users\Huang\Study\ECE681\HW01knnBlindTestFeatures');
[decStat] = runClassifier(knnBlindFeatures', knnClassifier, 'k', 15);
save('C:\Users\Huang\Study\ECE681\decStat.m','decStat');