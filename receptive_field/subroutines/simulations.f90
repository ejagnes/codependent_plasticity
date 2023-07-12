!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        MAIN SIMULATION -> CALLS ROUTINES FOR INPUT, NEURON AND DATA OUTPUT !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITHOUT PLASTICITY FOR INITIALISATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation0(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tt,ttt,i,j,tot_time,tc,tc_inc

	tot_time = INT(tot_time_r*10.0d0)

!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 100 ms of neuronal time------------------------------!
		DO tt = 1,1000
			tr = tr + dt		!from interation to neuronal time
			t = t + 1		!integer time for inhomogeneous input
			CALL input_g()		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron

		END DO
	!------------------------------------------------------------------------------------------!
		CALL output()		!output data for plots
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITH PLASTICITY AT E AND I SYNAPSES                  !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tt,ttt,i,j,tot_time,tc,tc_inc

	tot_time = INT(tot_time_r/10.0d0)

!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 10000 ms of neuronal time ---------------------------!
		DO tt = 1,100000
			tr = tr + dt		!from interation to neuronal time
			t = t + 1		!integer time for inhomogeneous input
			CALL input_g()		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron

			CALL plasticity_e()	!excitatory plasticity
			CALL plasticity_i()	!inhibitory plasticity
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output()		!output data for plots
	END DO
!==========================================================================================!
!=========================== snapshot of weight ===========================================!
	CALL output_w()
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
	INTEGER 		::	tt,ttt,i,j,tot_time,tc,tc_inc

	tot_time = INT(tot_time_r*1000.0d0)

!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 1 ms of neuronal time -------------------------------!
		DO tt = 1,10
			tr = tr + dt		!from interation to neuronal time
			t = t + 1		!integer time for inhomogeneous input
			CALL input_h()		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron

			CALL plasticity_e()	!excitatory plasticity
			CALL plasticity_i()	!inhibitory plasticity
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output()		!output data for plots
	END DO
!==========================================================================================!
!=========================== snapshot of weight ===========================================!
	CALL output_w()
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!   SIMULATION WITH PLASTICITY AT E AND I SYNAPSES - HOMGENEOUS POISSON      !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation3(tot_time_r)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tt,ttt,i,j,tot_time,tc,tc_inc

	tot_time = INT(tot_time_r*1000.0d0)

!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 1 ms of neuronal time -------------------------------!
		DO tt = 1,10
			tr = tr + dt		!from interation to neuronal time
			t = t + 1		!integer time for inhomogeneous input
			CALL input_g()		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron

			CALL plasticity_e()	!excitatory plasticity
			CALL plasticity_i()	!inhibitory plasticity
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output()		!output data for plots
	END DO
!==========================================================================================!
!=========================== snapshot of weight ===========================================!
	CALL output_w()
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!  SIMULATION WITH PLASTICITY AT E AND I SYNAPSES - STIMULATION OF PATHWAY   !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulationbn(tot_time_r,pw)
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8			::	tot_time_r
	INTEGER 		::	tt,ttt,i,j,tot_time,tc,tc_inc,pw

	tot_time = INT(tot_time_r*1000.0d0)

!================================ main loop ===============================================!
	DO ttt = 1,tot_time
	!---------------------------loop over 1 ms of neuronal time -------------------------------!
		DO tt = 1,10
			tr = tr + dt		!from interation to neuronal time
			t = t + 1		!integer time for inhomogeneous input
			CALL input_bn(pw)	!homogeneous input onto postsynaptic neuron with pathway pw activated
			CALL lif()		!leaky integrate-and-fire neuron

			CALL plasticity_e()	!excitatory plasticity
			CALL plasticity_i()	!inhibitory plasticity
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output()			!output data for plots
	END DO
!==========================================================================================!
!=========================== snapshot of weight ===========================================!
	CALL output_w()
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  DATA OUTPUT FOR PLOTS - TIME EVOLUTION                    !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE output()
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	pw
	CHARACTER(15)		::	fm
!==================== calculation of mean weights per input signal ========================!
	DO pw = 1,n_pw
		tmp_e(pw) = SUM(msynw(1+(pw-1)*ne_pw:pw*ne_pw))				!E populations
		tmp_i(pw) = SUM(msynw(ne_input+1+(pw-1)*ni_pw:ne_input+pw*ni_pw))	!I populations
	END DO
!==========================================================================================!
!================ output of average excitatory and inhibitory weights =====================!
!	WRITE(5,"(4E)")tr,SUM(msynw(1:ne_input))/DBLE(ne_input),SUM(msynw(ne_input+1:ne_input+ni_input))/DBLE(ni_input)
!==========================================================================================!
!========== output of average excitatory and inhibitory weights per pathway ===============!
	WRITE(6,"(17E)")tr,tmp_e/DBLE(ne_pw),tmp_i/DBLE(ni_pw)
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                    DATA OUTPUT FOR PLOTS - SNAPSHOTS                       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE output_w()
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	i,j,pw
!==================== calculation of mean weights per input signal ========================!
	DO pw = 1,n_pw
		tmp_e(pw) = SUM(msynw(1+(pw-1)*ne_pw:pw*ne_pw))				!E populations
		tmp_i(pw) = SUM(msynw(ne_input+1+(pw-1)*ni_pw:ne_input+pw*ni_pw))	!I populations
	END DO
!==========================================================================================!
!============================ average weights per pathway =================================!
!	DO pw = 1,n_pw
!		WRITE(8,*)pw,tmp_e(pw)/DBLE(ne_pw),tmp_i(pw)/DBLE(ni_pw)
!	END DO
!	WRITE(8,*)" "
!==========================================================================================!
!==================== normalised average weights per pathway ==============================!
	tmp_e = tmp_e/MAXVAL(tmp_e)
	tmp_i = tmp_i/MAXVAL(tmp_i)
	DO pw = 1,n_pw
		WRITE(9,*)pw,tmp_e(pw),tmp_i(pw)
	END DO
	WRITE(9,*)" "
!==========================================================================================!
!================================ excitatory weights ======================================!
!	DO i = 1,ne_input
!		WRITE(10,*)i,msynw(i)
!	END DO
!	WRITE(10,*)" "
!==========================================================================================!
!================================ inhibitory weights ======================================!
!	j = 0
!	DO i = ne_input+1,ne_input+ni_input
!		j = j + 1
!		WRITE(11,*)j,msynw(i)
!	END DO
!	WRITE(11,*)" "
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
