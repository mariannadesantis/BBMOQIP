function [p,Q,c,a] = T2rand(r,seed) %name of the test instance

% example file for building a pure integer strictly convex quadratic 
% test instance which can be solved by MOMIX

% Input: r is the total number of variables

% number of objective functions
p=2;
rng(seed);
% variable: row vector of length m+n
% Q positive semidefinite nxn-matrix
% c row vector of length m+n
% a constant

% first objective function:
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

% global defined objective functions - in case, add more objective
% functions
global func
func=@(x,i)(1:p==i)*[(x'*Q{1})*x + c{1}'*x + a{1}; ...
    (x'*Q{2})*x + c{2}'*x + a{2}];


end
