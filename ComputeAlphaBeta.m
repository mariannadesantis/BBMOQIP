function [alpha,beta]=ComputeAlphaBeta(xstar,p)

x1star=zeros(p,1);
for i=1:p
    x1star(i)=xstar{i}(1);
end

alpha = min(x1star);
alpha = floor(alpha);

beta = max(x1star);
beta = ceil(beta);