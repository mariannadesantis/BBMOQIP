function dom = CondEval(LB,LPNS,cardLPNS,p)

for i=1:cardLPNS
    cond = 0;
    cont = 0;
    for j=1:p
        if(LPNS{i}(j)<=LB(j))
            cont = cont+1;
            if(LPNS{i}(j)< LB(j))
                cond = 1;
            end
        end
    end
    if ((cond == 1)&&(cont==p))
         break;
    end
end



if ((cond == 1)&&(cont==p))
    dom = 1;
else
    dom = 0;
end
