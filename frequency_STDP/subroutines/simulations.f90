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
		CALL lif()		!Leaky integrate-and-fire neuron
	END DO
!==========================================================================================!
	DO t = 1,period*50
		tr = tr + dt
		CALL input_ext()
		CALL input_post_pre(t)
		CALL lif()
		CALL plasticity_e()
	END DO

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation_pre_before_post()
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	INTEGER		::	t

	DO t = 1,1000
		tr = tr + dt
		CALL input_ext()
		CALL lif()
	END DO
	DO t = 1,period*50
		tr = tr + dt
		CALL input_ext()
		CALL input_pre_post(t)
		CALL lif()
		CALL plasticity_e()
	END DO

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
