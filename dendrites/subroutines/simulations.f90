!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITHOUT PLASTICITY FOR INITIALISATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	t,tot_time

	tot_time = INT(tot_time_r*10000.0d0)

!================================ main loop ===============================================!
	DO t = 1,tot_time
		tr = tr + dt		!from interation to neuronal time
		CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
		CALL lif()		!leaky integrate-and-fire neuron
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITH PLASTICITY AT E AND I SYNAPSES                  !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation2(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	t,tot_time

	tot_time = INT(tot_time_r*10000.0d0*60.0d0)

!================================ main loop ===============================================!
	DO t = 1,tot_time
		tr = tr + dt		!from interation to neuronal time
		CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
		CALL lif()		!leaky integrate-and-fire neuron
		CALL plasticity_e()	!excitatory plasticity
		CALL plasticity_i()	!inhibitory plasticity
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
