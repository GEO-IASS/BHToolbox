function boundaries = findBoundary(feature, target, num, varargin)

[type] = process_options(varargin, 'type', 'common');


sortF = sort(feature);
sortF = unique(sortF);

if strcmp(type, 'common')
    if num == 1
        impurity = zeros(1,length(sortF)-2);
        cnt = 0;
        for b = 2:length(sortF)-1
            cnt = cnt + 1;
            ip1 = entropy(sum(target(feature<sortF(b)))/length(target(feature<sortF(b))));
            ip2 = entropy(sum(target(feature>=sortF(b)))/length(target(feature>=sortF(b))));
            ip3 = 1-entropy(length(target(feature>=sortF(b)))/length(feature));
            impurity(cnt) = ip1+ip2+ip3;
        end
        [~,index] = min(impurity);
        boundaries = sortF(index+1);
    elseif num == 2
        impurity = zeros(3,(length(sortF)-3)^2);
        cnt = 0;
        for b1 = 2:length(sortF)-2
            for b2 = (b1+1):(length(sortF)-2)
                cnt = cnt + 1;
                ip1 = entropy(sum(target(feature<sortF(b1)))/length(target(feature<sortF(b1))));
                ip2 = entropy(sum(target(feature>=sortF(b1) & feature<sortF(b2)))/...
                    length(target(feature>=sortF(b1) & feature<sortF(b2))));
                ip3 = entropy(sum(target(feature>=sortF(b2)))/length(target(feature>=sortF(b2))));
                ip4 = log2(3) - entropy([length(target(feature<sortF(b1)))/length(feature),...
                    length(target(feature>= sortF(b1) & feature<sortF(b2)))/length(feature),...
                    length(target(feature>sortF(b2)))/length(feature)]);
                impurity(:,cnt) = [ip1+ip2+ip3+2*ip4;b1;b2];
            end
        end
        [~,index] = min(impurity(1,1:cnt));
        boundaries = [sortF(impurity(2,index)),sortF(impurity(3,index))];
    end
elseif strcmp(type, 'limited')
    
end

end