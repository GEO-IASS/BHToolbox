function classifier = trainLR(features, targets, varargin)

[iterNum,thresh,output] = process_options(varargin, 'iterNum', 500, 'thresh', 1e-2, 'output', 0);

classifier.type = 'ld';
classifier.feature = features;
classifier.targets = targets;

featureNum = size(features,1);
featureDim = size(features,2);
Y = targets;
X = [ones(featureNum,1),features];

% initialize beta with all ones
beta = ones(featureDim+1,1);
beta_new = beta;

cnt = 0;
th = inf;
while cnt < iterNum && th > thresh
    cnt = cnt + 1;
    if output==1
        fprintf(1,'%dth iteration, th=%f\n',cnt, th);
    end
    beta = beta_new;
    
    % calculate P
    P = zeros(featureNum,1);
    for i = 1:length(P)
        %P(i) = Y(i)*(beta'*transpose(X(i,:)))-log(1+exp(beta'*transpose(X(i,:))));
        P(i) = 1/(1+exp(-beta'*transpose(X(i,:))));
    end
    % calculate W
    W = diag(P.*(1-P));
    % calculate Z
    Z = X*beta + pinv(W)*(Y-P);
    % calculate new beta
    beta_new = pinv(X'*W*X)*X'*W*Z;
    th = sum((beta_new-beta).^2);
end

classifier.beta = beta_new;

end