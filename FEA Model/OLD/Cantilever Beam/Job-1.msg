1

   Abaqus Learning Edition 2025                                  Date 22-Apr-2026   Time 11:41:50
   

                                                                                 
                                                                                 
 STEP    1     INCREMENT     1     STEP TIME    0.00    


                        S T E P       1     S T A T I C   A N A L Y S I S


                                                                                          

     AUTOMATIC TIME CONTROL WITH -
          A SUGGESTED INITIAL TIME INCREMENT OF                5.000E-02
          AND A TOTAL TIME PERIOD OF                            1.00    
          THE MINIMUM TIME INCREMENT ALLOWED IS                1.000E-05
          THE MAXIMUM TIME INCREMENT ALLOWED IS                 1.00    

     LINEAR EQUATION SOLVER TYPE         DIRECT SPARSE

 CONVERGENCE TOLERANCE PARAMETERS FOR FORCE    
     CRITERION FOR RESIDUAL FORCE     FOR A NONLINEAR PROBLEM          5.000E-03
     CRITERION FOR DISP.    CORRECTION IN A NONLINEAR PROBLEM          1.000E-02
     INITIAL VALUE OF TIME AVERAGE FORCE                               1.000E-02
     AVERAGE FORCE     IS TIME AVERAGE FORCE    
     ALTERNATE CRIT. FOR RESIDUAL FORCE     FOR A NONLINEAR PROBLEM    2.000E-02
     CRITERION FOR ZERO FORCE     RELATIVE TO TIME AVRG. FORCE         1.000E-05
     CRITERION FOR RESIDUAL FORCE     WHEN THERE IS ZERO FLUX          1.000E-05
     CRITERION FOR DISP.    CORRECTION WHEN THERE IS ZERO FLUX         1.000E-03
     CRITERION FOR RESIDUAL FORCE     FOR A LINEAR INCREMENT           1.000E-08
     FIELD CONVERSION RATIO                                             1.00    
     CRITERION FOR ZERO FORCE     REL. TO TIME AVRG. MAX. FORCE        1.000E-05
     CRITERION FOR ZERO DISP.    RELATIVE TO CHARACTERISTIC LENGTH     1.000E-08

 CONVERGENCE TOLERANCE PARAMETERS FOR MOMENT   
     CRITERION FOR RESIDUAL MOMENT    FOR A NONLINEAR PROBLEM          5.000E-03
     CRITERION FOR ROTATION CORRECTION IN A NONLINEAR PROBLEM          1.000E-02
     INITIAL VALUE OF TIME AVERAGE MOMENT                              1.000E-02
     AVERAGE MOMENT    IS TIME AVERAGE MOMENT   
     ALTERNATE CRIT. FOR RESIDUAL MOMENT    FOR A NONLINEAR PROBLEM    2.000E-02
     CRITERION FOR ZERO MOMENT    RELATIVE TO TIME AVRG. MOMENT        1.000E-05
     CRITERION FOR RESIDUAL MOMENT    WHEN THERE IS ZERO FLUX          1.000E-05
     CRITERION FOR ROTATION CORRECTION WHEN THERE IS ZERO FLUX         1.000E-03
     CRITERION FOR RESIDUAL MOMENT    FOR A LINEAR INCREMENT           1.000E-08
     FIELD CONVERSION RATIO                                             1.00    
     CRITERION FOR ZERO MOMENT    REL. TO TIME AVRG. MAX. MOMENT       1.000E-05

     VOLUMETRIC STRAIN COMPATIBILITY TOLERANCE FOR HYBRID SOLIDS       1.000E-05
     AXIAL STRAIN COMPATIBILITY TOLERANCE FOR HYBRID BEAMS             1.000E-05
     TRANS. SHEAR STRAIN COMPATIBILITY TOLERANCE FOR HYBRID BEAMS      1.000E-05
     SOFT CONTACT CONSTRAINT COMPATIBILITY TOLERANCE FOR P>P0          5.000E-03
     SOFT CONTACT CONSTRAINT COMPATIBILITY TOLERANCE FOR P=0.0         0.100    
     CONTACT FORCE ERROR TOLERANCE FOR CONVERT SDI=YES                 1.00    
     DISPLACEMENT COMPATIBILITY TOLERANCE FOR DCOUP ELEMENTS           1.000E-05
     ROTATION COMPATIBILITY TOLERANCE FOR DCOUP ELEMENTS               1.000E-05

 EQUILIBRIUM WILL BE CHECKED FOR SEVERE DISCONTINUITY ITERATIONS

 TIME INCREMENTATION CONTROL PARAMETERS:
     FIRST EQUILIBRIUM ITERATION FOR CONSECUTIVE DIVERGENCE CHECK              4
     EQUILIBRIUM ITERATION AT WHICH LOG. CONVERGENCE RATE CHECK BEGINS         8
     EQUILIBRIUM ITERATION AFTER WHICH ALTERNATE RESIDUAL IS USED              9
     MAXIMUM EQUILIBRIUM ITERATIONS ALLOWED                                   16
     EQUILIBRIUM ITERATION COUNT FOR CUT-BACK IN NEXT INCREMENT               10
     MAXIMUM EQUILIB. ITERS IN TWO INCREMENTS FOR TIME INCREMENT INCREASE      4
     MAXIMUM ITERATIONS FOR SEVERE DISCONTINUITIES                            50
     MAXIMUM ATTEMPTS ALLOWED IN AN INCREMENT                                  5
     MAXIMUM DISCON. ITERS IN TWO INCREMENTS FOR TIME INCREMENT INCREASE      50
     MAXIMUM CONTACT AUGMENTATIONS FOR *SURFACE BEHAVIOR,AUGMENTED LAGRANGE   50
     CUT-BACK FACTOR AFTER DIVERGENCE                                 0.2500    
     CUT-BACK FACTOR FOR TOO SLOW CONVERGENCE                         0.5000    
     CUT-BACK FACTOR AFTER TOO MANY EQUILIBRIUM ITERATIONS            0.7500    
     CUT-BACK FACTOR AFTER TOO MANY SEVERE DISCONTINUITY ITERATIONS   0.2500    
     CUT-BACK FACTOR AFTER PROBLEMS IN ELEMENT ASSEMBLY               0.2500    
     INCREASE FACTOR AFTER TWO INCREMENTS THAT CONVERGE QUICKLY        1.500    
     MAX. TIME INCREMENT INCREASE FACTOR ALLOWED                       1.500    
     MAX. TIME INCREMENT INCREASE FACTOR ALLOWED (DYNAMICS)            1.250    
     MAX. TIME INCREMENT INCREASE FACTOR ALLOWED (DIFFUSION)           2.000    
     MINIMUM TIME INCREMENT RATIO FOR EXTRAPOLATION TO OCCUR          0.1000    
     MAX. RATIO OF TIME INCREMENT TO STABILITY LIMIT                   1.000    
     FRACTION OF STABILITY LIMIT FOR NEW TIME INCREMENT               0.9500    
     TIME INCREMENT INCREASE FACTOR BEFORE A TIME POINT                1.000    
     GLOBAL STABILIZATION CONTROL IS NOT USED

          PRINT OF INCREMENT NUMBER, TIME, ETC., EVERY    1  INCREMENTS

     THE MAXIMUM NUMBER OF INCREMENTS IN THIS STEP IS                    100

          LARGE DISPLACEMENT THEORY WILL BE USED

     LINEAR EXTRAPOLATION WILL BE USED

     CHARACTERISTIC ELEMENT LENGTH      2.50    

     DETAILS REGARDING ACTUAL SOLUTION WAVEFRONT REQUESTED

     DETAILED OUTPUT OF DIAGNOSTICS TO DATABASE REQUESTED

     PRINT OF INCREMENT NUMBER, TIME, ETC., TO THE MESSAGE FILE EVERY     1  INCREMENTS

     COLLECTING MODEL CONSTRAINT INFORMATION FOR OVERCONSTRAINT CHECKS

     COLLECTING STEP CONSTRAINT INFORMATION FOR OVERCONSTRAINT CHECKS


  INCREMENT     1 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  5.000E-02
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  17ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                      6.108E+03   TIME AVG. FORCE       6.108E+03
 LARGEST SCALED RESIDUAL FORCE     -3.190E+04   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -3.190E+04
 LARGEST INCREMENT OF DISP.         -10.4       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.        -10.4       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     5.976E+03   TIME AVG. MOMENT      5.976E+03
 LARGEST SCALED RESIDUAL MOMENT     1.831E+03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     1.831E+03
 LARGEST INCREMENT OF ROTATION     -7.813E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -7.813E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  7ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                       80.8       TIME AVG. FORCE        80.8    
 LARGEST SCALED RESIDUAL FORCE       48.3       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE       48.3    
 LARGEST INCREMENT OF DISP.         -10.3       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.321       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     5.661E+03   TIME AVG. MOMENT      5.661E+03
 LARGEST SCALED RESIDUAL MOMENT      19.3       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT      19.3    
 LARGEST INCREMENT OF ROTATION     -7.760E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     5.531E-04   AT NODE         22   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     3


 AVERAGE FORCE                       157.       TIME AVG. FORCE        157.    
 LARGEST SCALED RESIDUAL FORCE      -406.       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -406.    
 LARGEST INCREMENT OF DISP.         -9.22       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         1.10       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     5.017E+03   TIME AVG. MOMENT      5.017E+03
 LARGEST SCALED RESIDUAL MOMENT     -3.07       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     -3.07    
 LARGEST INCREMENT OF ROTATION     -6.879E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     8.805E-03   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          ROTATION CORRECTION TOO LARGE COMPARED TO ROTATION INCREMENT
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     4


 AVERAGE FORCE                       85.8       TIME AVG. FORCE        85.8    
 LARGEST SCALED RESIDUAL FORCE     -0.126       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -0.126    
 LARGEST INCREMENT OF DISP.         -9.24       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -1.821E-02   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     5.028E+03   TIME AVG. MOMENT      5.028E+03
 LARGEST SCALED RESIDUAL MOMENT    -6.053E-02   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT    -6.053E-02
 LARGEST INCREMENT OF ROTATION     -6.895E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -1.580E-04   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   4 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  4 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  5.000E-02,  FRACTION OF STEP COMPLETED  5.000E-02
 STEP TIME COMPLETED       5.000E-02,  TOTAL TIME COMPLETED        5.000E-02


  INCREMENT     2 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  5.000E-02
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  1ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                       314.       TIME AVG. FORCE        200.    
 LARGEST SCALED RESIDUAL FORCE      -889.       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -889.    
 LARGEST INCREMENT OF DISP.         -7.41       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         1.83       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     9.159E+03   TIME AVG. MOMENT      7.094E+03
 LARGEST SCALED RESIDUAL MOMENT      746.       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT      746.    
 LARGEST INCREMENT OF ROTATION     -5.510E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     1.386E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                       187.       TIME AVG. FORCE        136.    
 LARGEST SCALED RESIDUAL FORCE      -1.94       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -1.94    
 LARGEST INCREMENT OF DISP.         -7.36       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.        5.328E-02   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     1.091E+04   TIME AVG. MOMENT      7.966E+03
 LARGEST SCALED RESIDUAL MOMENT     0.663       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     0.663    
 LARGEST INCREMENT OF ROTATION     -5.443E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     6.653E-04   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION    5.915E-07
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     3


 AVERAGE FORCE                       213.       TIME AVG. FORCE        149.    
 LARGEST SCALED RESIDUAL FORCE     -0.259       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -0.259    
 LARGEST INCREMENT OF DISP.         -7.33       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.        2.588E-02   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     1.364E+04   TIME AVG. MOMENT      9.334E+03
 LARGEST SCALED RESIDUAL MOMENT     5.126E-04   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     5.126E-04
 LARGEST INCREMENT OF ROTATION     -5.421E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     2.231E-04   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   3 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  3 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  5.000E-02,  FRACTION OF STEP COMPLETED  0.100    
 STEP TIME COMPLETED       0.100    ,  TOTAL TIME COMPLETED        0.100    


  INCREMENT     3 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  7.500E-02
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  5ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                       609.       TIME AVG. FORCE        303.    
 LARGEST SCALED RESIDUAL FORCE     -1.768E+03   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -1.768E+03
 LARGEST INCREMENT OF DISP.         -8.46       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         2.54       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     1.370E+04   TIME AVG. MOMENT      1.079E+04
 LARGEST SCALED RESIDUAL MOMENT     1.183E+03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     1.183E+03
 LARGEST INCREMENT OF ROTATION     -6.217E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     1.914E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                       320.       TIME AVG. FORCE        206.    
 LARGEST SCALED RESIDUAL FORCE      0.151       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      0.151    
 LARGEST INCREMENT OF DISP.         -8.47       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -2.068E-02   AT NODE         70   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     1.820E+04   TIME AVG. MOMENT      1.229E+04
 LARGEST SCALED RESIDUAL MOMENT     0.539       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     0.539    
 LARGEST INCREMENT OF ROTATION     -6.194E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     2.325E-04   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   2 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  2 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  7.500E-02,  FRACTION OF STEP COMPLETED  0.175    
 STEP TIME COMPLETED       0.175    ,  TOTAL TIME COMPLETED        0.175    


  INCREMENT     4 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  0.113    
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  6ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                      1.237E+03   TIME AVG. FORCE        464.    
 LARGEST SCALED RESIDUAL FORCE     -3.926E+03   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -3.926E+03
 LARGEST INCREMENT OF DISP.         -8.94       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         3.77       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     1.856E+04   TIME AVG. MOMENT      1.386E+04
 LARGEST SCALED RESIDUAL MOMENT     2.250E+03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     2.250E+03
 LARGEST INCREMENT OF ROTATION     -6.460E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     2.831E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                       512.       TIME AVG. FORCE        283.    
 LARGEST SCALED RESIDUAL FORCE      0.617       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      0.617    
 LARGEST INCREMENT OF DISP.         -9.00       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -5.990E-02   AT NODE         79   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     1.985E+04   TIME AVG. MOMENT      1.418E+04
 LARGEST SCALED RESIDUAL MOMENT     -1.11       AT NODE         60   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     -1.11    
 LARGEST INCREMENT OF ROTATION     -6.448E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -5.348E-04   AT NODE         15   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   2 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  2 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  0.113    ,  FRACTION OF STEP COMPLETED  0.288    
 STEP TIME COMPLETED       0.288    ,  TOTAL TIME COMPLETED        0.288    


  INCREMENT     5 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  0.169    
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  6ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                      2.251E+03   TIME AVG. FORCE        677.    
 LARGEST SCALED RESIDUAL FORCE     -7.158E+03   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -7.158E+03
 LARGEST INCREMENT OF DISP.         -8.47       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         5.03       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     2.300E+04   TIME AVG. MOMENT      1.594E+04
 LARGEST SCALED RESIDUAL MOMENT     3.191E+03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     3.191E+03
 LARGEST INCREMENT OF ROTATION     -5.871E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     3.802E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  14ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                       811.       TIME AVG. FORCE        389.    
 LARGEST SCALED RESIDUAL FORCE      -4.14       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -4.14    
 LARGEST INCREMENT OF DISP.         -8.65       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.187       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     2.312E+04   TIME AVG. MOMENT      1.597E+04
 LARGEST SCALED RESIDUAL MOMENT     -6.22       AT NODE         68   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     -6.22    
 LARGEST INCREMENT OF ROTATION     -5.949E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -1.248E-03   AT NODE         59   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION    2.432E-06
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     3


 AVERAGE FORCE                       795.       TIME AVG. FORCE        385.    
 LARGEST SCALED RESIDUAL FORCE      -26.7       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -26.7    
 LARGEST INCREMENT OF DISP.         -8.93       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.281       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     3.449E+04   TIME AVG. MOMENT      1.824E+04
 LARGEST SCALED RESIDUAL MOMENT     3.771E-02   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     3.771E-02
 LARGEST INCREMENT OF ROTATION     -6.180E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -2.310E-03   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION    1.401E-05
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     4


 AVERAGE FORCE                      1.170E+03   TIME AVG. FORCE        460.    
 LARGEST SCALED RESIDUAL FORCE     -5.250E-05   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -5.250E-05
 LARGEST INCREMENT OF DISP.         -8.93       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -3.741E-04   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     3.449E+04   TIME AVG. MOMENT      1.824E+04
 LARGEST SCALED RESIDUAL MOMENT     2.250E-03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     2.250E-03
 LARGEST INCREMENT OF ROTATION     -6.180E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -3.258E-06   AT NODE         38   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   4 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  4 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  0.169    ,  FRACTION OF STEP COMPLETED  0.456    
 STEP TIME COMPLETED       0.456    ,  TOTAL TIME COMPLETED        0.456    


  INCREMENT     6 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  0.253    
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  6ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                      3.810E+03   TIME AVG. FORCE       1.019E+03
 LARGEST SCALED RESIDUAL FORCE     -1.160E+04   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -1.160E+04
 LARGEST INCREMENT OF DISP.         -7.05       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         6.35       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     2.656E+04   TIME AVG. MOMENT      1.963E+04
 LARGEST SCALED RESIDUAL MOMENT     3.541E+03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     3.541E+03
 LARGEST INCREMENT OF ROTATION     -4.440E-02   AT NODE         33   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     4.836E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  14ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                      1.234E+03   TIME AVG. FORCE        589.    
 LARGEST SCALED RESIDUAL FORCE      -25.8       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -25.8    
 LARGEST INCREMENT OF DISP.         -7.40       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.349       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     2.631E+04   TIME AVG. MOMENT      1.959E+04
 LARGEST SCALED RESIDUAL MOMENT     -26.0       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     -26.0    
 LARGEST INCREMENT OF ROTATION     -4.655E-02   AT NODE         72   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -2.284E-03   AT NODE         22   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION    1.678E-05
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  14ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     3


 AVERAGE FORCE                      1.264E+03   TIME AVG. FORCE        594.    
 LARGEST SCALED RESIDUAL FORCE      -195.       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -195.    
 LARGEST INCREMENT OF DISP.         -8.13       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.729       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     3.501E+04   TIME AVG. MOMENT      2.104E+04
 LARGEST SCALED RESIDUAL MOMENT     0.793       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     0.793    
 LARGEST INCREMENT OF ROTATION     -5.272E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -6.305E-03   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION    1.921E-04
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     4


 AVERAGE FORCE                      1.818E+03   TIME AVG. FORCE        687.    
 LARGEST SCALED RESIDUAL FORCE     -5.024E-03   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -5.024E-03
 LARGEST INCREMENT OF DISP.         -8.14       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -3.389E-03   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     4.033E+04   TIME AVG. MOMENT      2.192E+04
 LARGEST SCALED RESIDUAL MOMENT    -1.352E-02   AT NODE         53   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT    -1.352E-02
 LARGEST INCREMENT OF ROTATION     -5.276E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -3.281E-05   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   4 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  4 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  0.253    ,  FRACTION OF STEP COMPLETED  0.709    
 STEP TIME COMPLETED       0.709    ,  TOTAL TIME COMPLETED        0.709    


  INCREMENT     7 STARTS. ATTEMPT NUMBER  1, TIME INCREMENT  0.291    
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  4ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     1


 AVERAGE FORCE                      3.088E+03   TIME AVG. FORCE       1.030E+03
 LARGEST SCALED RESIDUAL FORCE     -5.692E+03   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -5.692E+03
 LARGEST INCREMENT OF DISP.         -4.86       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.         4.48       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     2.872E+04   TIME AVG. MOMENT      2.289E+04
 LARGEST SCALED RESIDUAL MOMENT     1.188E+03   AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     1.188E+03
 LARGEST INCREMENT OF ROTATION     -3.016E-02   AT NODE         60   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION     3.400E-02   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          MOMENT    EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  14ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     2


 AVERAGE FORCE                      1.760E+03   TIME AVG. FORCE        840.    
 LARGEST SCALED RESIDUAL FORCE      -60.5       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -60.5    
 LARGEST INCREMENT OF DISP.         -5.32       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.456       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     2.947E+04   TIME AVG. MOMENT      2.300E+04
 LARGEST SCALED RESIDUAL MOMENT     -21.3       AT NODE         81   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT     -21.3    
 LARGEST INCREMENT OF ROTATION     -3.296E-02   AT NODE         61   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -3.352E-03   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION    6.009E-05
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     3


 AVERAGE FORCE                      1.743E+03   TIME AVG. FORCE        838.    
 LARGEST SCALED RESIDUAL FORCE      -61.4       AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE      -61.4    
 LARGEST INCREMENT OF DISP.         -5.71       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -0.392       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          FORCE     EQUILIBRIUM NOT ACHIEVED WITHIN TOLERANCE.

 AVERAGE MOMENT                     4.404E+04   TIME AVG. MOMENT      2.508E+04
 LARGEST SCALED RESIDUAL MOMENT    -7.545E-02   AT NODE         68   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT    -7.545E-02
 LARGEST INCREMENT OF ROTATION     -3.525E-02   AT NODE         63   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -3.559E-03   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
 ESTIMATE OF ROTATION CORRECTION   -1.261E-05
          MOMENT    EQUILIB. ACCEPTED BASED ON SMALL RESIDUAL AND ESTIMATED CORRECTION
 
	SYMMETRIC PURE THREAD-BASED DIRECT SPARSE SOLVER RUNNING ON
 	1 HOST x 1 MPI RANK PER HOST x 1 THREAD PER RANK
        NUMBER OF EQUATIONS:  243
        NUMBER OF RHS:        1
        NUMBER OF FLOPS:      1.425e+04
        SOLVER ELAPSED TIME:  13ms

               CONVERGENCE CHECKS FOR EQUILIBRIUM ITERATION     4


 AVERAGE FORCE                      2.564E+03   TIME AVG. FORCE        955.    
 LARGEST SCALED RESIDUAL FORCE     -6.650E-03   AT NODE         41   DOF  1
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL FORCE     -6.650E-03
 LARGEST INCREMENT OF DISP.         -5.71       AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO DISP.       -3.671E-03   AT NODE         41   DOF  2
   INSTANCE: PART-1-1                                                                        
          THE FORCE     EQUILIBRIUM EQUATIONS HAVE CONVERGED

 AVERAGE MOMENT                     4.405E+04   TIME AVG. MOMENT      2.508E+04
 LARGEST SCALED RESIDUAL MOMENT    -3.806E-03   AT NODE         53   DOF  6
   INSTANCE: PART-1-1                                                                        
  CORRESPONDING RESIDUAL MOMENT    -3.806E-03
 LARGEST INCREMENT OF ROTATION     -3.528E-02   AT NODE         63   DOF  6
   INSTANCE: PART-1-1                                                                        
 LARGEST CORRECTION TO ROTATION    -3.584E-05   AT NODE         41   DOF  6
   INSTANCE: PART-1-1                                                                        
          THE MOMENT    EQUILIBRIUM EQUATIONS HAVE CONVERGED

 ITERATION SUMMARY FOR THE INCREMENT:   4 TOTAL ITERATIONS, OF WHICH
   0 ARE SEVERE DISCONTINUITY ITERATIONS AND  4 ARE EQUILIBRIUM ITERATIONS.

 TIME INCREMENT COMPLETED  0.291    ,  FRACTION OF STEP COMPLETED   1.00    
 STEP TIME COMPLETED        1.00    ,  TOTAL TIME COMPLETED         1.00    


          THE ANALYSIS HAS BEEN COMPLETED



     ANALYSIS SUMMARY:
     TOTAL OF          7  INCREMENTS
                       0  CUTBACKS IN AUTOMATIC INCREMENTATION
                      23  ITERATIONS INCLUDING CONTACT ITERATIONS IF PRESENT
                      23  PASSES THROUGH THE EQUATION SOLVER OF WHICH 
                      23  INVOLVE MATRIX DECOMPOSITION, INCLUDING
                       0  DECOMPOSITION(S) OF THE MASS MATRIX
                       1  REORDERING OF EQUATIONS TO MINIMIZE WAVEFRONT
                       0  ADDITIONAL RESIDUAL EVALUATIONS FOR LINE SEARCHES
                       0  ADDITIONAL OPERATOR EVALUATIONS FOR LINE SEARCHES
                       0  WARNING MESSAGES DURING USER INPUT PROCESSING
                       0  WARNING MESSAGES DURING ANALYSIS
                       0  ANALYSIS WARNINGS ARE NUMERICAL PROBLEM MESSAGES
                       0  ANALYSIS WARNINGS ARE NEGATIVE EIGENVALUE MESSAGES
                       0  ERROR MESSAGES



     JOB TIME SUMMARY
       USER TIME (SEC)      =     0.20    
       SYSTEM TIME (SEC)    =     0.30    
       TOTAL CPU TIME (SEC) =     0.50    
       WALLCLOCK TIME (SEC) =            1
       MEMORY PEAK (GB)     =            0
