# BBMOQIP
Implementation of  BB-MOQIP: the branch-and-bound method for solving  Multiobjective Convex Quadratic Integer Problems  presented in the paper 

[1] "A Decision Space Algorithm for Multiobjective Convex Quadratic Integer Optimization"  by M. De Santis and G. Eichfelder


==============================================================

The directory provides the following folders:

1)test instances : within "test instances" you can find
                   the instances as .m files used for
		   the numerical experiments in [1]:
		   (T2),(T2rand),(T3rand),(T4rand).

2)savefiles : is the folder where the results are stored

==============================================================


The directory  further provides the following files:


- Testrun.m : to launch the numerical experiments of paper [1];

- Call_BBMOIQP.m : main file with  the following input parameters:
  * optproblem: 'T*' (* = 1,...,6)
  * parameter: dimension of the decision space
  * timel: time limit in seconds
  * seed : seed for the random instances

- BBMOIQP.m: implementation of the branch-and-bound scheme

- ComputeAlphaBeta.m: computation of the intervals for the fixings
 		      
- ComputeOpt.m: computation of the ideal points

- CondEval.m: evaluation of (Cond) - condition for pruning

- PreProcessing.m: computation of the inverse matrices 

- updateLPNS.m : update of the sets of nondominated and efficient solutions

- Updaterd.m: update of the fixings

- f.m : evaluation of the objective functions
 
MATLAB files for the plot:
- plot_image.m : plots in the image space L_PNS and the images of all feasible 
		points found along the run of the algorithm (2D and 3D)



...enjoy, buon divertimento, viel Spass :-)

