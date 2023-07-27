!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!============================ files with subroutines ======================================!
	INCLUDE 'subroutines/modules.f90'			!modules
	INCLUDE 'subroutines/allocation.f90'			!allocation of vector sizes
	INCLUDE 'config.f90'					!configuration - parameters
	INCLUDE 'initial_conditions.f90'			!values for initial conditions
	INCLUDE 'subroutines/simulations.f90'			!simulation protocols
	INCLUDE 'subroutines/LIF.f90'				!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/input_LTP_protocol.f90'		!pre-before-burst inputs
	INCLUDE 'subroutines/plasticity_codependent_e.f90'	!excitatory plasticity implementation
!==========================================================================================!
	PROGRAM RECEPTIVE_FIELD_PLASTICITY
	USE PARAMETERS
	USE VARIABLES
	IMPLICIT NONE
	REAL*8		::	w_stdp(50),interval_ltp,distance_ltp
	INTEGER		::	k,interval_dt,interval_dt_strong,interval_dt_weak
!======================== initialising subroutines ========================================!
	CALL config()								!call config file with parameters
	CALL allocation()							!allocate vectors and matrices based on parameters
!==========================================================================================!
!================== STDP-like curve with a single synapse =================================!
	DO k = 1,50
		interval_dt = k							!interval between pre spike and first post spike in burst (dt)
		CALL initial_conditions()					!initial conditions for sim
		CALL simulation0(1.0d0)						!simulation of period without input/output
		CALL simulation_pre_before_burst(30.0d0,interval_dt,1)		!simulation of protocol pre-before-brust, synapse #1
		w_stdp(k) = 100.0d0*msynw(1)/p_con(5)				!storing change of weight for different dt's
		WRITE(1,*)DBLE(interval_dt),100.0d0*msynw(1)/p_con(5)		!writing on file interval between pre/post, change in weight
	END DO
!==========================================================================================!
!============= temporal-dependence of LTP induction with two synapses =====================!
	interval_dt_strong = 5							!dt for "strong" LTP
	interval_dt_weak = 35							!dt for "weak" LTP
	interval_ltp = -60.0d0							!initialisation of variable for interval between LTP inductions
	DO k = 1,20
		interval_ltp = interval_ltp + 60.0d0				!increase in interval between strong and weak LTP inductions
		CALL initial_conditions()					!initial conditions for sim
		CALL simulation0(1.0d0)						!simulation of period without input/output
		CALL simulation_pre_before_burst(30.0d0,interval_dt_strong,1)	!simulation of protocol pre-before-brust, synapse #1

		CALL simulation0(interval_ltp)					!simulation of period without input/output
		CALL simulation_pre_before_burst(50.0d0,interval_dt_weak,2)	!simulation of protocol pre-before-brust, synapse #2
		WRITE(2,*)interval_ltp,100.0d0*msynw(2)/p_con(17),w_stdp(interval_dt_weak)	!writing on file interval between pre/post, change in weight
	END DO
!==========================================================================================!
!============= distance-dependence of LTP induction with two synapses =====================!
	distance_ltp = -0.2d0							!initialisation for distance between synapses
	DO k = 1,100
		distance_ltp = distance_ltp + 0.2d0				!increment in the distance between synapses
		p_plast(42) = DEXP(-0.5d0*((distance_ltp**2)/p_plast(40)))	!effect of the neighbouring synapses
		CALL initial_conditions()					!initial conditions for sim
		CALL simulation0(5.0d0)						!simulation of period without input/output
		CALL simulation_pre_before_burst(30.0d0,interval_dt_strong,1)	!simulation of protocol pre-before-brust, synapse #1

		CALL simulation0(90.0d0)					!simulation of period without input/output
		CALL simulation_pre_before_burst(50.0d0,interval_dt_weak,2)	!simulation of protocol pre-before-brust, synapse #2
		WRITE(3,*)distance_ltp,100.0d0*msynw(2)/p_con(17),w_stdp(interval_dt_weak)	!writing on file interval between pre/post, change in weight
	END DO
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
