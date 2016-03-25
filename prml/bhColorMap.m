function [newColorMap] = bhColorMap(n)

if mod(n,2) == 0
    r = [ones(n/2+1,1);transpose(linspace(1,0,n/2+1))];
    g = [transpose(linspace(0,1,n/2+1));transpose(linspace(1,0,n/2+1))];
    b = [transpose(linspace(0,1,n/2+1));ones(n/2+1,1)];
    r = [r(1:n/2);r(n/2+3:end)];
    g = [g(1:n/2);g(n/2+3:end)];
    b = [b(1:n/2);b(n/2+3:end)];
else
    n = n - 1;
    r = [ones(n/2+1,1);transpose(linspace(1,0,n/2+1))];
    g = [transpose(linspace(0,1,n/2+1));transpose(linspace(1,0,n/2+1))];
    b = [transpose(linspace(0,1,n/2+1));ones(n/2+1,1)];
    r = [r(1:n/2);1;r(n/2+3:end)];
    g = [g(1:n/2);1;g(n/2+3:end)];
    b = [b(1:n/2);1;b(n/2+3:end)];
end

newColorMap = [r, g, b];

end