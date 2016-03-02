function [metric, featureSet] = featureSelection(H0, H1, numFolds, varargin)

[metricType, method, k] = process_options(varargin, 'metric', 'AUC', 'method', 'scalar', 'k', 1);

featureNum = size(H0,2);

if strcmp(method,'scalar')
    basic = zeros(1,featureNum);
    metric = zeros(1,featureNum);
    featureSet = cell(1,featureNum);
    if strcmp(metricType,'AUC')
        for thisFeature = 1:featureNum
            [pf, pd] = bhCrossValidation(H0(:,thisFeature), H1(:,thisFeature), numFolds, k);
            basic(thisFeature) = AUC([0,sort(pf),1], [0,sort(pd),1]);
        end
        [~, I] = sort(basic,'descend');
        for cnt = 1:featureNum
            [pf, pd] = bhCrossValidation(H0(:,I(1:cnt)), H1(:,I(1:cnt)), numFolds, k);
            metric(cnt) = AUC([0,sort(pf),1], [0,sort(pd),1]);
            featureSet(cnt) = cellstr(num2str(sort(I(1:cnt))));
        end
    end
elseif strcmp(method,'exhaustive')
    metric = zeros(1,featureNum^2-1);
    featureSet = cell(1,featureNum^2-1);
    featureLabel = 1:featureNum;
    for cnt = 1:featureNum^2-1
        index = de2bi(cnt,featureNum);
        index = index == 1;
        [pf, pd] = bhCrossValidation(H0(:,index), H1(:,index), numFolds, k);
        metric(cnt) = AUC([0,sort(pf),1], [0,sort(pd),1]);
        featureSet(cnt) = cellstr(num2str(featureLabel(index)));
    end
elseif strcmp(method,'sequential')
    metric = zeros(1,featureNum);
    featureSet = cell(1,featureNum);
    featureLabel = zeros(1,featureNum);
    basic = zeros(1,featureNum);
    for i = 1:featureNum
        [pf, pd] = bhCrossValidation(H0(:,featureNum), H1(:,featureNum), numFolds, k);
        basic(featureNum) = AUC([0,sort(pf),1], [0,sort(pd),1]);
        [metric(1),featureLabel(1)] = max(basic);
        featureSet(1) = cellstr(num2str(featureLabel(1)));
    end
    for i = 2:featureNum
        basic = zeros(1,featureNum);
        for j = 1:featureNum
            if sum(featureLabel==j) == 0
                [pf, pd] = bhCrossValidation(H0(:,[featureLabel(featureLabel~=0),j]), ...
                    H1(:,[featureLabel(featureLabel~=0),j]), numFolds, k);
                basic(j) = AUC([0,sort(pf),1], [0,sort(pd),1]);
            end
        end
        [metric(i),featureLabel(i)] = max(basic);
        featureSet(i) = cellstr(num2str(sort(featureLabel(1:i))));
    end
end

end