!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	INCLUDE 'subroutines/modules.f90'			!modules
	INCLUDE 'config.f90'					!configuration - parameters
	INCLUDE 'initial_conditions.f90'			!values for initial conditions
	INCLUDE 'subroutines/LIF.f90'				!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/plasticity_codependent_e.f90'	!codependent excitatory plasticity implementation
	INCLUDE 'subroutines/input.f90'				!inputs and protocol spike patterns
	INCLUDE 'subroutines/simulations.f90'			!simulation protocols
!==========================================================================================!
	PROGRAM PAIRING_PROTOCOL
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
!	USE TEMP
	IMPLICIT NONE
	INTEGER 		::	trial,f_sweep,inp_sweep
	REAL*8			::	delta_w(2),freq
!======================== initialising subroutines ========================================!
	CALL config()						!call config file with parameters
!==========================================================================================!
!------------------- LOOP OVER DIFFERENT EXTERNAL FREQUENCIES -----------------------------!
	DO inp_sweep = 1,p_sim_int(3)
		p_inp(2) =(DBLE(2**(inp_sweep-2)))*10.0d0	!external frequency for excitatory neuron
		IF(inp_sweep.EQ.1) p_inp(2) = 0.0d0		!external frequency = 0 for first iteration
		p_inp(2) = (dt*p_inp(2))/1000.0d0		!from frequency to probability
		p_inp(3) = p_inp(2)				!external frequency for inhibitory neuron
	!------------------- LOOP OVER DIFFERENT PRE/POST FREQUENCIES -----------------------------!
		DO f_sweep = 1,p_sim_int(2)
			freq = DBLE(f_sweep)*p_sim(2)		!frequency of pairs pre/post
			period = INT(10000.0d0/freq)		!intereval between pair pre/post
		!--------------------------- LOOP OVER MULTIPLE TRIALS ------------------------------------!
			delta_w = 0.0d0				!cumulative weight change initialisation
			DO trial = 1,p_sim_int(1)
				CALL initial_conditions()				!initial conditions for sim
				CALL simulation_post_before_pre()			!simulation of protocol post-before-pre
				delta_w(1) = 100.0d0*(msynw/p_con(5)) + delta_w(1)	!weight change

				CALL initial_conditions()				!initial conditions for sim
				CALL simulation_pre_before_post()			!simulation of protocol pre-before-post
				delta_w(2) = 100.0d0*(msynw/p_con(5)) + delta_w(2)	!weight change
			END DO
			WRITE(1,"(3E)")freq,delta_w/DBLE(p_sim_int(1))			!writing on file frequency of pairs, change for post-before-pre, change for pre-before-post
		!------------------------------------------------------------------------------------------!
		END DO
		WRITE(1,*)" "
	!------------------------------------------------------------------------------------------!
	END DO
!------------------------------------------------------------------------------------------!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
