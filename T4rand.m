function [p,Q,c,a] = T4rand(r,seed) %name of the test instance

% example file for building a pure integer strictly convex quadratic 
% test instance which can be solved by MOMIX

% Input: r is the total number of variables

% number of objective functions
p=4;
rng(seed);
% variable: row vector of length m+n
% Q positive semidefinite nxn-matrix
% c row vector of length m+n
% a constant

Q1 = rand(r);
A = Q1*Q1';
if(min(eig(A))<0.001)
    A = A+eye(r);
end
Q{1}= A;
c{1} =[1,2*ones(1,r-2),1]';
a{1}= 0;

% second objective function:
Q2 = 5*rand(r);
A2 = Q2*Q2';
if(min(eig(A2))<0.001)
    A2 = A2+eye(r);
end
Q{2}= A2;
c{2} = [-1,-2*ones(1,r-2),5]';
a{2}= 0;

% third objective function:
Q3 = 2*rand(r);
A3 = Q3*Q3';
if(min(eig(A3))<0.001)
    A3 = A3+eye(r);
end
Q{3}=A3;
c{3} = [-1,-ones(1,r-2),5]';
a{3}= 0;


% fourth objective function:
Q4 = 8*rand(r);
A4 = Q4*Q4';
if(min(eig(A4))<0.001)
    A4 = A4+eye(r);
end
Q{4}=A4;
c{4} = ones(r,1);
a{4}= 0;


% add more quadratic constraints by using Qcon{j}, qcon{j}, ccon{j}, for
% j=2,3,...

% global defined objective functions - in case, add more objective
% functions
global func
func=@(x,i)(1:p==i)*[(x'*Q{1})*x + c{1}'*x + a{1}; (x'*Q{2})*x + c{2}'*x...
    + a{2}; (x'*Q{3})*x + c{3}'*x + a{3}; (x'*Q{4})*x + c{4}'*x + a{4}];

end
