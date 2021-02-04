function [rd,xd]=Updaterd(rd,alpha)

if(rd>=alpha)
    xd = rd+1;
else
    xd = rd-1;
end
rd=xd;