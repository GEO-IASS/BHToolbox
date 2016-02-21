function [KL, varargout] = GmmKL(gmmModels1, gmmModels2, varargin)

[selfKL, oneDir, plotFlag] = process_options(varargin, ...
    'selfKL', 0, 'oneDir', 0, 'plot', 0);

if selfKL == 1
    KL = zeros(length(gmmModels1));
    for i = 1:length(gmmModels1)
        for j = 1:length(gmmModels1)
            [KL(i,j),~] = gaussmixk(gmmModels1(i).means',gmmModels1(i).covars',(gmmModels1(i).priors/sum(gmmModels1(i).priors))',...
                gmmModels1(j).means',gmmModels1(j).covars',(gmmModels1(j).priors/sum(gmmModels1(j).priors))');
        end
    end
else
    KL = zeros(length(gmmModels1), length(gmmModels2));
    for i = 1:length(gmmModels1)
        for j = 1:length(gmmModels2)
            [KL(i,j),~] = gaussmixk(gmmModels1(i).means',gmmModels1(i).covars',(gmmModels1(i).priors/sum(gmmModels1(i).priors))',...
                gmmModels2(j).means',gmmModels2(j).covars',(gmmModels2(j).priors/sum(gmmModels2(j).priors))');
        end
    end
end

if oneDir == 1
    for i = 1:length(gmmModels1)
        for j = 1:i
            if i ~= j
                KL(i,j) = (KL(i,j)+KL(j,i))/2;
                KL(j,i) = 0;
            end
        end
    end
end

if plotFlag == 1
    figure;
    %clims = [0,8];
    imagesc(KL);colorbar;
    varargout{1} = gca;
    %varargout{2} = im;
    if oneDir == 1
        for i = 1:length(gmmModels1)
            for j = 1:i-1
                text(j-0.3,i,num2str(KL(i,j)),'fontsize',15);
            end
        end
    end
end

end