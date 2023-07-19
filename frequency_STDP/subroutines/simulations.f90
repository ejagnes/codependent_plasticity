!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation_post_before_pre()
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	INTEGER		::	t
!=========================== LOOP FOR STEADY-STATE OF VARIABLES ===========================!
	DO t = 1,1000
		tr = tr + dt		!increase simulation time according to time-step
		CALL input_ext()	!external input
		CALL lif()		!leaky integrate-and-fire neuron
	END DO
!==========================================================================================!
!=============================== LOOP FOR SIMULATED PROTOCOL ==============================!
	DO t = 1,period*50
		tr = tr + dt		!increase simulation time according to time-step
		CALL input_ext()	!external input
		CALL input_post_pre(t)	!post-before-pre inputs
		CALL lif()		!leaky integrate-and-fire neuron
		CALL plasticity_e()	!codependent plasticity at the excitatory synapse
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation_pre_before_post()
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	INTEGER		::	t
!=========================== LOOP FOR STEADY-STATE OF VARIABLES ===========================!
	DO t = 1,1000
		tr = tr + dt		!increase simulation time according to time-step
		CALL input_ext()	!external input
		CALL lif()		!Leaky integrate-and-fire neuron
	END DO
!==========================================================================================!
!=============================== LOOP FOR SIMULATED PROTOCOL ==============================!
	DO t = 1,period*50
		tr = tr + dt		!increase simulation time according to time-step
		CALL input_ext()	!external input
		CALL input_pre_post(t)	!pre-before-post inputs
		CALL lif()		!leaky integrate-and-fire neuron
		CALL plasticity_e()	!codependent plasticity at the excitatory synapse
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
