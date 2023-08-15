!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        MAIN SIMULATION -> CALLS ROUTINES FOR INPUT, NEURON AND DATA OUTPUT !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!   SIMULATION WITHOUT PLASTICITY AT E AND I SYNAPSES - HOMGENEOUS POISSON   !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation01()
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	INTEGER 		::	tt,ttt,tot_time2
!============================== TIME IN ITERATIONS ========================================!
	tot_time2 = INT(p_sim(2)*1000.0d0)
!==========================================================================================!
!================================ main loop ===============================================!
	DO tt = 1,tot_time2
		tr = tr + dt		!from interation to neuronal time
		CALL input_h()		!inhomogeneous input onto postsynaptic neuron
		CALL lif()		!leaky integrate-and-fire neuron
	END DO
	CALL output1()			!output data for plots
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!   SIMULATION WITHOUT PLASTICITY AT E AND I SYNAPSES - HOMGENEOUS POISSON   !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation02()
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	INTEGER 		::	tt,ttt,tot_time
!================================ main loop ===============================================!
	DO tt = 1,100000
		tr = tr + dt		!from interation to neuronal time
		CALL input_h()		!inhomogeneous input onto postsynaptic neuron
		CALL lif()		!leaky integrate-and-fire neuron
	END DO
	CALL output2()			!output data for plots
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!   SIMULATION WITH PLASTICITY AT E AND I SYNAPSES - HOMGENEOUS POISSON      !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation1(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tt,ttt,tot_time,tot_time2
!============================== TIME IN ITERATIONS ========================================!
	tot_time = INT(60.0d0*60.0d0*tot_time_r/p_sim(2))
	tot_time2 = INT(p_sim(2)*1000.0d0/dt)
!==========================================================================================!
!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 10 seconds of neuronal time -------------------------!
		DO tt = 1,tot_time2
			tr = tr + dt		!from interation to neuronal time
			CALL input_h()		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron

			CALL plasticity_orch()	!excitatory plasticity - spike-based
			CALL plasticity_istdp()	!inhibitory plasticity - spike-based
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output1()			!output data for plots
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!   SIMULATION WITH PLASTICITY AT E AND I SYNAPSES - HOMGENEOUS POISSON      !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation2(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tt,ttt,tot_time,tot_time2
!============================== TIME IN ITERATIONS ========================================!
	tot_time = INT(60.0d0*60.0d0*tot_time_r/p_sim(2))
	tot_time2 = INT(p_sim(2)*1000.0d0/dt)
!==========================================================================================!
!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 10 seconds of neuronal time -------------------------!
		DO tt = 1,tot_time2
			tr = tr + dt		!from interation to neuronal time
			CALL input_h()		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron

			CALL plasticity_orch()	!excitatory plasticity - spike-based
			CALL plasticity_i()	!inhibitory plasticity - codependent
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output2()			!output data for plots
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  DATA OUTPUT FOR PLOTS - TIME EVOLUTION                    !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE output1()
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
!================ output of average excitatory and inhibitory weights =====================!
!--------------------------- firing-rate, currents (see LIF.f90) --------------------------!
	WRITE(2,"(8E)")tr,x(20)/10.0d0,x(24:29)/100000.0d0
!------------------------------------------------------------------------------------------!
!------------------- E and I weights, normalised by initial condition ---------------------!
	WRITE(3,"(4E)")tr,SUM(msynw(1:ne_input))/(p_con(5)*DBLE(ne_input)),SUM(msynw(ne_input+1:ne_input+ni_input))/(p_con(7)*DBLE(ni_input))
!------------------------------------------------------------------------------------------!
!--------------------------- mean E and I weights -----------------------------------------!
	WRITE(4,"(4E)")tr,SUM(msynw(1:ne_input))/(DBLE(ne_input)),SUM(msynw(ne_input+1:ne_input+ni_input))/(DBLE(ni_input))
!------------------------------------------------------------------------------------------!
!-------------------------- resetting averaging variables ---------------------------------!
	x(20) = 0.0d0
	x(24:29) = 0.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  DATA OUTPUT FOR PLOTS - TIME EVOLUTION                    !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE output2()
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
!================ output of average excitatory and inhibitory weights =====================!
!--------------------------- firing-rate, currents (see LIF.f90) --------------------------!
	WRITE(5,"(8E)")tr,x(20)/10.0d0,x(24:29)/100000.0d0
!------------------------------------------------------------------------------------------!
!------------------- E and I weights, normalised by initial condition ---------------------!
	WRITE(6,"(4E)")tr,SUM(msynw(1:ne_input))/(p_con(5)*DBLE(ne_input)),SUM(msynw(ne_input+1:ne_input+ni_input))/(p_con(7)*DBLE(ni_input))
!------------------------------------------------------------------------------------------!
!--------------------------- mean E and I weights -----------------------------------------!
	WRITE(7,"(4E)")tr,SUM(msynw(1:ne_input))/(DBLE(ne_input)),SUM(msynw(ne_input+1:ne_input+ni_input))/(DBLE(ni_input))
!------------------------------------------------------------------------------------------!
!-------------------------- resetting averaging variables ---------------------------------!
	x(20) = 0.0d0
	x(24:29) = 0.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!

	END SUBROUTINE

