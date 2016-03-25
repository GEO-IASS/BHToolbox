function [decStat, classifier] = runClassifier(features, classifier, varargin)

[type, k, addFlag] = process_options(varargin, 'type', 'knn', 'k', 1, 'keepDat', 0);

if strcmp(type, 'knn')
    [decStat,classifier] = runKNN(features, classifier, 'k', k);
elseif strcmp(type, 'bayes')
    [decStat,classifier] = runBayes(features, classifier);
elseif strcmp(type, 'fld')
    [decStat,classifier] = runFld(features, classifier);
elseif strcmp(type, 'dlrt')
    [decStat,classifier] = runDlrt(features, classifier, 'k', classifier.k);
end

if addFlag
    classifier.test = features;
    classifier.decStat = decStat;
end

end