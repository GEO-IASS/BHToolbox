function [metric, featureSet] = featureSelection(H0, H1, numFolds, varargin)

[verb, metricType, method, type, k, tree, included] = process_options(varargin, ...
    'verbose', 1,...
    'metric','AUC',...
    'method','scalar',...
    'type','knn',...
    'k',1,...
    'tree',500,...
    'include', 0);

featureNum = size(H0,2);

if strcmp(method,'scalar')
    basic = zeros(1,featureNum);
    metric = zeros(1,featureNum);
    featureSet = cell(1,featureNum);
    if strcmp(metricType,'AUC')
        for thisFeature = 1:featureNum
            [decSatH0, decStatH1] = bhCrossValidation(H0(:,thisFeature), H1(:,thisFeature), numFolds, 'type', type, 'k', k, 'tree', tree);
            [pf, pd] = bhroc(decSatH0,decStatH1,'plot',0);
            basic(thisFeature) = AUC([0,sort(pf),1], [0,sort(pd),1]);
            if verb
                fprintf(1,'Scalar, feature set: ');
                fprintf(1,'%d ', thisFeature);
                fprintf(1,'metric = %2.2f\n', basic(thisFeature));
            end
        end
        [~, I] = sort(basic,'descend');
        for cnt = 1:featureNum
            [decSatH0, decStatH1] = bhCrossValidation(H0(:,I(1:cnt)), H1(:,I(1:cnt)), numFolds, 'type', type, 'k', k, 'tree', tree);
            [pf, pd] = bhroc(decSatH0,decStatH1,'plot',0);
            metric(cnt) = AUC([0,sort(pf),1], [0,sort(pd),1]);
            featureSet(cnt) = cellstr(num2str(sort(I(1:cnt))));
            if verb
                fprintf(1,'Scalar, feature set: ');
                fprintf(1,'%d ', I(1:cnt));
                fprintf(1,'metric = %2.2f\n', metric(cnt));
            end
        end
    end
elseif strcmp(method,'exhaustive')
    metric = zeros(1,featureNum^2-1);
    featureSet = cell(1,featureNum^2-1);
    featureLabel = 1:featureNum;
    for cnt = 1:featureNum^2-1
        index = de2bi(cnt,featureNum);
        index = index == 1;
        [decSatH0, decStatH1] = bhCrossValidation(H0(:,index), H1(:,index), numFolds, 'type', type, 'k', k, 'tree', tree);
        [pf, pd] = bhroc(decSatH0,decStatH1,'plot',0);
        metric(cnt) = AUC([0,sort(pf),1], [0,sort(pd),1]);
        featureSet(cnt) = cellstr(num2str(featureLabel(index)));
        if verb
            fprintf(1,'exhuastive, feature set: ');
            fprintf(1,'%d ', index);
            fprintf(1,'metric = %2.2f\n', metric(cnt));
        end
    end
elseif strcmp(method,'sequential')
    metric = zeros(1,featureNum);
    featureSet = cell(1,featureNum);
    featureLabel = zeros(1,featureNum);
    basic = zeros(1,featureNum);
    for i = 1:featureNum
        if included == 0
            [decSatH0, decStatH1] = bhCrossValidation(H0(:,featureNum), H1(:,featureNum), numFolds, 'type', type, 'k', k, 'tree', tree);
        else
            [decSatH0, decStatH1] = bhCrossValidation(H0(:,[included,featureNum]), H1(:,[included,featureNum]), numFolds, 'type', type, 'k', k, 'tree', tree);
        end
        [pf, pd] = bhroc(decSatH0,decStatH1,'plot',0);
        basic(featureNum) = AUC([0,sort(pf),1], [0,sort(pd),1]);
        [metric(1),featureLabel(1)] = max(basic);
        featureSet(1) = cellstr(num2str(featureLabel(1)));
        if verb
            fprintf(1,'Sequential, feature set: ');
            fprintf(1,'%d ', i);
            fprintf(1,'metric = %2.2f\n', basic(featureNum));
        end
    end
    for i = 2:featureNum
        basic = zeros(1,featureNum);
        for j = 1:featureNum
            if sum(featureLabel==j) == 0
                if included == 0
                    [decStatH0, decStatH1] = bhCrossValidation(H0(:,[featureLabel(featureLabel~=0),j]), ...
                        H1(:,[featureLabel(featureLabel~=0),j]), numFolds, 'type', type, 'k', k, 'tree', tree);
                else
                    [decStatH0, decStatH1] = bhCrossValidation(H0(:,[included,featureLabel(featureLabel~=0),j]), ...
                        H1(:,[included,featureLabel(featureLabel~=0),j]), numFolds, 'type', type, 'k', k, 'tree', tree);
                end
                [pf, pd] = bhroc(decStatH0, decStatH1, 'plot', 0);
                basic(j) = AUC([0,sort(pf),1], [0,sort(pd),1]);
            end
        end
        [metric(i),featureLabel(i)] = max(basic);
        featureSet(i) = cellstr(num2str(sort(featureLabel(1:i))));
        if verb
            fprintf(1,'Sequential, feature set: ');
            fprintf(1,'%d ', featureLabel);
            fprintf(1,'metric = %2.2f\n', metric(i));
        end
    end
end

end