!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        MAIN SIMULATION -> CALLS ROUTINES FOR INPUT, NEURON AND DATA OUTPUT !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!          SIMULATION WITHOUT PLASTICITY DUE TO LACK OF INPUT/OUTPUT         !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation0(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tot_time,t

	tot_time = INT(tot_time_r*10000.0d0)
	spk = .FALSE.
!================================ main loop ===============================================!
	DO t = 1,tot_time
		tr = tr + dt			!from interation to neuronal time
		CALL lif()			!leaky integrate-and-fire neuron
!		CALL plasticity_e()		!codependent plasticity at the excitatory synapse -> commented out (no input)
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!              SIMULATION WITH PLASTICITY AT E SYNAPSES                      !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation_pre_before_burst(tot_time_r,time_dt,jj)
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tot_time,t,time_dt,jj,t0

	tot_time = INT(tot_time_r*10000.0d0)
!================================ main loop ===============================================!
	t0 = -100000
	DO t = 1,tot_time
		tr = tr + dt			!from interation to neuronal time
		CALL input(t,t0,jj,time_dt)	!pre-before-burst inputs
		CALL lif()			!leaky integrate-and-fire neuron
		CALL plasticity_e()		!codependent plasticity at the excitatory synapse
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
