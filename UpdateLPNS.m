function [Eff,LPNS,cardLPNS,cardeffset]=UpdateLPNS(Eff,LPNS,x,cardLPNS,cardeffset,p)
global func
r=length(x);

fx = f(x,func,p);
    
add=0;

%If fx is dominated by a func value on LPNS, it is not added to it.
cond=0;
cont=0;
for i=1:cardLPNS
    cond=0;
    for j=1:p
        if(fx(j)<LPNS{i}(j))
            cond=1;
            break
        end
    end
    if(cond==1)
        cont=cont+1;
    end
end



 %Otherwise we add x to Eff and fx to LPNS
 if (cont==cardLPNS)
     add=1;
     cardLPNS = cardLPNS + 1;
     cardeffset = cardeffset + 1;
     Eff{cardeffset}=x;
     LPNS{cardeffset}=fx;
 end
 
 %If fx has been added to LPNS, delete all entries of LPNS dominated by fx.
 if(add==1)
     inddel=zeros(cardLPNS,1);
     for i=1:cardLPNS-1
         %    cond = 0;
         cont = 0;
         for j=1:p
             if(fx(j)<=LPNS{i}(j))
                 cont = cont+1;
                 %             if(fx(j)<LPNS{i}(j))
                 %                 cond = 1;
                 %             end
             end
         end
         %if ((cond == 1)&&(cont==p))
         if ((cont==p))
             %Remove entry {i} from LPNS
             inddel(i)=1;
         end
     end
     LPNS((inddel>0))=[];
     Eff((inddel>0))=[];
     cardLPNS = cardLPNS - sum(inddel);
     cardeffset = cardeffset - sum(inddel);
 end