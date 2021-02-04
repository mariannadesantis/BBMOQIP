function ExpiredTimeFlag=Call_BBMOIQP(optproblem,parameter,timel,seed)
% algorithm to solve multiobjective integer strictly convex quadratic optimization problems
%% Description
% %   Input parameters:
% %   * optproblem: 'T*' (* = 1,...,6)
% %   * parameter: dimension of the decision space
% %   * timel: time limit in seconds
% %   * seed : seed for the random instances



%% Initializing
close all;
clear func
clc;
format long;
rng(03677,'twister')
addpath('savefiles')
addpath('test instances')
tic;

%% Input
global timelimit stopAlgo
timelimit=timel;
stopAlgo=0;
saveResults=1;

TI = str2func(optproblem);
scalablenum=parameter;

%call the .m file to build the instance
[p,QM,cv,av] = TI(scalablenum,seed);

%dimension of the preimage space
r=scalablenum;

%create folder within savefiles to save results
if saveResults
    foldername=strcat(char(datetime('now','Format','yyyy_MM_dd_HH_mm')),'_',optproblem,'_numVar', num2str(r),'_Seed', num2str(seed));
    dirct=strcat('savefiles/',foldername);
    mkdir(dirct);
    filename = fullfile(dirct, 'results.txt');
    fileID = fopen(filename, 'w');
    fprintf(fileID, ['Objective function: ', optproblem,  ...
        '\n Number of integer variables               ', num2str(r),...
        '\n set time limit                            ', num2str(timelimit)]);
end

tic;

%call BB_MOIQP
[Eff,LPNS,nnodes]=BB_MOIQP(p,QM,cv,av,r,timelimit);

t1 = toc;

%Copy results
if (t1<timelimit)
    ExpiredTimeFlag=0;
    fprintf(fileID, ['\nResults:',...
        '\n Numbers of nodes                         ', num2str(nnodes), ...
        '\n Computational time for main loop                    ', num2str(t1), 's']);
    
    fclose(fileID);
    save(strcat(dirct,'/workspace.mat'));
    cardEff = size(Eff,2);
    cardLPNS = size(LPNS,2);
    h1=plot_image(p,LPNS,cardLPNS);
    
else %computational time expired
    ExpiredTimeFlag=1;
    fprintf(fileID, ['\n\nComputational time expired!']);
    save(strcat(dirct,'/workspace.mat'));
end

end
