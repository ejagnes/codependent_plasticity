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
	INCLUDE 'subroutines/plasticity_orch.f90'	!spike-based orchestrated excitatory plasticity implementation
	INCLUDE 'subroutines/plasticity_iSTDP.f90'	!spike-based inhibitory plasticity implementation
	INCLUDE 'subroutines/plasticity_cod_i.f90'	!codependent inhibitory plasticity implementation
	INCLUDE 'subroutines/input_homogeneous.f90'	!homogeneous inputs
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
!==========================================================================================!
!================ main simulation - 1 - spike-based E and I plasticity ====================!
!--------- simulation without plasticity for variables to reach steady state --------------!
	CALL initial_conditions()		!implement initial conditions

	CALL simulation01()			!without plasticity for initial values - argumento is simulated time in seconds
	p_plast(17) = 0.0094d0			!change A_+ from spike-based E plasticity
	CALL simulation1(p_sim(1))		!with plasticity - argument is simulated time in seconds
	p_plast(17) = 0.015d0			!change A_+ from spike-based E plasticity
	CALL simulation1(p_sim(1))		!with plasticity - argument is simulated time in seconds
	p_plast(17) = 0.0094d0			!change A_+ from spike-based E plasticity
	CALL simulation1(p_sim(1))		!with plasticity - argument is simulated time in seconds
	p_plast(17) = 0.005d0			!change A_+ from spike-based E plasticity
	CALL simulation1(p_sim(1))		!with plasticity - argument is simulated time in seconds
!==========================================================================================!
!========== main simulation - 2 - spike-based E and codependent I plasticity ==============!
	CALL initial_conditions()		!implement initial conditions

	CALL simulation02()			!without plasticity for initial values - argumento is simulated time in seconds
	p_plast(17) = 0.0094d0			!change A_+ from spike-based E plasticity
	CALL simulation2(p_sim(1))		!with plasticity - argument is simulated time in seconds
	p_plast(17) = 0.015d0			!change A_+ from spike-based E plasticity
	CALL simulation2(p_sim(1))		!with plasticity - argument is simulated time in seconds
	p_plast(17) = 0.0094d0			!change A_+ from spike-based E plasticity
	CALL simulation2(p_sim(1))		!with plasticity - argument is simulated time in seconds
	p_plast(17) = 0.005d0			!change A_+ from spike-based E plasticity
	CALL simulation2(p_sim(1))		!with plasticity - argument is simulated time in seconds
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
