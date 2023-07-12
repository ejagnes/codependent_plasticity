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
	INCLUDE 'subroutines/plasticity_cod_e.f90'	!excitatory plasticity implementation
	INCLUDE 'subroutines/plasticity_cod_i.f90'	!inhibitory plasticity implementation
	INCLUDE 'subroutines/input_gaussian.f90'	!inputs from rectified Ornstein-Uhlenbeck process
	INCLUDE 'subroutines/input_burst.f90'		!inputs with high excitatory and low inhibitory firing-rate
!==========================================================================================!
	PROGRAM RECEPTIVE_FIELD_PLASTICITY
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
!======================== initialising subroutines ========================================!
	CALL config()				!call config file with parameters
	CALL allocation()			!allocate vectors and matrices based on parameters
	CALL initial_conditions()		!implement initial conditions
!==========================================================================================!
!===================== main simulation - 1 - first receptive field ========================!
!--------- simulation without plasticity for variables to reach steady state --------------!
	CALL simulation0(50.0d0)			!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!----- simulation with homogeneous poisson and more points per second for plotting --------!
	CALL simulation2(0.5d0)			!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!------------- stimulation to learng the first receptive field profile --------------------!
	CALL simulationbn(0.2d0,6)
!------------------------------------------------------------------------------------------!
!----- simulation with homogeneous poisson and more points per second for plotting --------!
	CALL simulation3(5.0d0)			!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!------------ long simulation for inhibitory weights to reach steady state ----------------!
	CALL simulation(30.0d0*60.0d0)		!argument is simulated time in seconds
	CALL simulation(150.0d0*60.0d0)		!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!==========================================================================================!


!===================== main simulation - 2 - second receptive field =======================!
!----- simulation with homogeneous poisson and more points per second for plotting --------!
	CALL simulation2(0.5d0)			!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!------------- stimulation to learng the second receptive field profile --------------------!
	CALL simulationbn(0.2d0,4)
!------------------------------------------------------------------------------------------!
!----- simulation with homogeneous poisson and more points per second for plotting --------!
	CALL simulation3(5.0d0)			!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!------------ long simulation for inhibitory weights to reach steady state ----------------!
	CALL simulation(30.0d0*60.0d0)		!argument is simulated time in seconds
	CALL simulation(150.0d0*60.0d0)		!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
