function [Eff,LPNS,nnodes]=BB_MOIQP(p,QM,cv,av,n,timelimit)
global func

%We fix the variable order to 1,...,n
%In the preprocessing phase we compute Q, Qinv and c for every level d, 
% dropping the first d entries:
tic;
Q = cell(p,n); c = cell(p,n); Qinv=cell(p,n);
[Q,c,Qinv]=PreProcessing(p,QM,cv,n);


%Initialization
cardeffset = 0;
cardLPNS = 0;
alpha = -10^5*ones(n,1);%consider bounds on the variables?!
beta = 10^5*ones(n,1);
r=alpha;
x=zeros(n,1);
d=0;
nnodes=0;

%Compute a first feasible solution and update the 
%efficient set and the set of potentially nondominated solutions
%N.B. as first feasible solution we simply choose 0
xfeas = zeros(n,1);
Eff{cardeffset+1} = xfeas;
LPNS{cardLPNS+1} = f(xfeas,func,p);

cardeffset = cardeffset+1;
cardLPNS = cardLPNS+1;



while (d>=0)
    t1 = toc;
    if(t1>timelimit)
        break
    end
    nnodes = nnodes+1;
    if(d<=n-1)
        %Set the fixings
        if (d>0)
            xfix = x(1:d);
        else
            xfix = x;
        end
        %Compute the unconstrained minimizer of the reduced problem (ideal point)
        [xstar,fstar] = ComputeOpt(Q,Qinv,c,av,n,p,d,xfix);
        %Set the LowerBound as the ideal point
        LB = fstar;
        %Compute alpha(d+1) and beta(d+1)
        [alpha(d+1),beta(d+1)] = ComputeAlphaBeta(xstar,p);
        %Evaluate condition (Cond)
        dom = CondEval(LB,LPNS,cardLPNS,p);
    else
        dom = 0;
    end
    %Check if we can prune all the left siblings
    if(dom)&&(r(d)<alpha(d))
        d=d-1;
        if(d>0)
            [r(d),x(d)]=Updaterd(r(d),alpha(d));
        else
            break
        end
    else
        if(dom)&&(r(d)>=alpha(d))
            if(r(d)>=beta(d))
                %Prune all the right siblings
                if(d>0)
                    x(d) = alpha(d)-1;
                    r(d) = x(d);
                else
                    break
                end
            else
                x(d)=r(d)+1;
                r(d)=x(d);
            end
        else
            if(d==n)
                %Update the sets of nondominated and efficient points
                [Eff,LPNS,cardLPNS,cardeffset]=UpdateLPNS(Eff,LPNS,x,cardLPNS,cardeffset,p);
                if(r(d)>= alpha(d))&&(r(d)<beta(d))
                    x(d)=r(d)+1;
                    r(d)=x(d);
                else
                    d= d-1;
                    if(d>0)
                        [r(d),x(d)]=Updaterd(r(d),alpha(d));
                    else
                        break
                    end
                end
            else
                d=d+1;
                r(d)=alpha(d);
                x(d)=r(d);
            end
        end
    end
end

