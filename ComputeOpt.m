function [xstar,fstar]=ComputeOpt(Q,Qinv,c,a,n,p,d,xfix) 

for i=1:p
xstar{i} = zeros(n-d,1);
end
fstar = zeros(p,1);

if(d>0)
    %Compute c and a considering the fixings:
    for j=1:p
        for i=d+1:n
            app(i-d)= 0;
            appa = 0;
            for k=1:d
                app(i-d) = app(i-d) + Q{j,1}(k,i)*xfix(k);
                for h=1:d
                    appa = appa + Q{j,1}(k,h)*xfix(k)*xfix(h);
                end
            end
            
        end
        cup{j}= c{j,d+1} + 2*app';
        aup{j} = a{j} + c{j,1}(1:d)'*xfix +appa;
    end
    
    
    for i=1:p
        xstar{i}=-0.5*Qinv{i,d+1}*cup{i};
        fstar(i)=aup{i} - 0.25*cup{i}'*Qinv{i,d+1}*cup{i};
    end
    
else%root node
    for i=1:p
        xstar{i}=-0.5*Qinv{i,1}*c{i,1};
        fstar(i)=a{i} - 0.25*c{i,1}'*Qinv{i,1}*c{i,1};
    end
end

