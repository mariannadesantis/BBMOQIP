function [p,Q,c,a] = T2(r,seed)
 
% Input: r is the total number of variables

% number of objective functions
p=2;

% variable: row vector of length m+n
% Q positive semidefinite nxn-matrix
% c row vector of length m+n
% a constant

% first objective function:
Q{1}= 8*eye(r)-0.1*ones(r);
c{1} = [1,2*ones(1,r-2),1]';
a{1}= 0;

% second objective function:
Q{2}= 0.3*eye(r);
c{2} = [-1,-2*ones(1,r-2),5]';
a{2}= 0;

% global defined objective functions - in case, add more objective
% functions
global func
func=@(x,i)(1:p==i)*[(x'*Q{1})*x + c{1}'*x + a{1}; ...
    (x'*Q{2})*x + c{2}'*x + a{2}];
end
