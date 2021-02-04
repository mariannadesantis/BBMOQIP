function [Q,c,Qinv]=PreProcessing(p,QM,cv,n)

for i=1:p
    for j=1:n
        Q{i,j}=QM{i}(j:n,j:n);
        Qinv{i,j}= inv(Q{i,j});
        c{i,j}=cv{i}(j:n);
    end
end
