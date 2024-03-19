!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!============================ files with subroutines ======================================!
	INCLUDE 'subroutines/modules.f90'		!modules
	INCLUDE 'subroutines/allocation.f90'		!allocation of vector sizes
	INCLUDE 'config.f90'				!configuration - parameters
	INCLUDE 'initial_conditions.f90'		!values for initial conditions
	INCLUDE 'subroutines/simulations.f90'		!simulation protocols
	INCLUDE 'subroutines/LIF.f90'			!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/plasticity_codep_e.f90'	!excitatory plasticity implementation
	INCLUDE 'subroutines/plasticity_codep_i.f90'	!inhibitory plasticity implementation
	INCLUDE 'subroutines/input_gaussian.f90'	!inputs from rectified Ornstein-Uhlenbeck process
!==========================================================================================!
	PROGRAM TWO_LAYER_NEURON_DENDRITES
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	USE TEMP
	IMPLICIT NONE
	INTEGER		::	l1
	REAL*8		::	w1,w2
!======================== initialising subroutines ========================================!
	CALL config()				!call config file with parameters
	CALL allocation()			!allocate vectors and matrices based on parameters
!==========================================================================================!
!=========================== loop over co-active group size ===============================!
	DO l1 = 1,31
		ne_corr = l1

		CALL initial_conditions()
	!--------- simulation without plasticity for variables to reach steady state --------------!
		CALL simulation(5.0d0)			!argument is simulated time in seconds
	!------------------------------------------------------------------------------------------!
	!----------------------------- simulation with plasticity ---------------------------------!
		CALL simulation2(360.0d0)		!argument is simulated time in minutes
	!------------------------------------------------------------------------------------------!
	!---------------------------- weight averages ---------------------------------------------!
		w1 = SUM(msynw(1:ne_corr))/DBLE(ne_corr)			!correlated inputs
		w2 = SUM(msynw(ne_corr+1:ne_input))/DBLE(ne_input-ne_corr)	!uncorrelated inputs
	!------------------------------------------------------------------------------------------!
	!------------------------------ output data for plots -------------------------------------!
		WRITE(1,*)l1,(w1-w2)/(w1+w2)
	!------------------------------------------------------------------------------------------!
		WRITE(*,*)l1,(w1-w2)/(w1+w2)
		WRITE(*,*)w1,w2
	END DO
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
