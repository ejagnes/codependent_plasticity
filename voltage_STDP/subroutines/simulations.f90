!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                      SIMULATION OF THE PROTOCOL                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation_voltage_stdp()
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	IMPLICIT NONE
	INTEGER		::	t,k
!======================== 15 REPETITIONS ACCORDING TO EXPERIMENTS =========================!
	DO k = 1,15
	!-------------------------- first period without spikes -----------------------------------!
		DO t = 1,5*10000
			tr = tr + dt			!increase simulation time according to time-step
			CALL lif()			!leaky integrate-and-fire neuron
			CALL plasticity_e()		!codependent plasticity at the excitatory synapse
		END DO
	!------------------------------------------------------------------------------------------!
	!-------------------------- 5 pre-before-post spikes --------------------------------------!
		DO t = 1,p_sim_int(5)*5
			tr = tr + dt			!increase simulation time according to time-step
			CALL input_pre_post(t)		!pre-before-post inputs
			CALL lif()			!leaky integrate-and-fire neuron
			CALL plasticity_e()		!codependent plasticity at the excitatory synapse
			x(13) = x(13) + x(1)		!for average membrane potential during burst
		END DO
	!------------------------------------------------------------------------------------------!
	!------------------------- second period without spikes -----------------------------------!
		DO t = 1,5*10000
			tr = tr + dt			!increase simulation time according to time-step
			CALL lif()			!leaky integrate-and-fire neuron
			CALL plasticity_e()		!codependent plasticity at the excitatory synapse
		END DO
	!------------------------------------------------------------------------------------------!
	END DO
!==========================================================================================!
	x(13) = x(13)/DBLE(15.0d0*p_sim_int(5)*5)	!average membrane potential
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
