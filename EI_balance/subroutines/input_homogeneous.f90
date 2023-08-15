!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                IMPLEMENTATION OF HOMOGENEOUS POISSON INPUT                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_h()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	j0,jf
	REAL*8 			::	tmp
!======================== GENERATE SPIKES FROM RATE PROPABILITIES =========================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!----------------------------- excitatory synapses ----------------------------------------!
	j0 = 1					!vector starting point
	jf = ne_input				!vector ending point
	WHERE((tmp_inp(j0:jf).LE.p_inp(2)).AND.(tr-spkt(j0:jf).GT.p_ne(3)))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
	END WHERE
!------------------------------------------------------------------------------------------!
!--------------------------------- inhibitory synapses ------------------------------------!
	j0 = ne_input + 1			!vector starting point
	jf = ne_input + ni_input		!vector ending point
	WHERE((tmp_inp(j0:jf).LE.p_inp(3)).AND.(tr-spkt(j0:jf).GT.(0.5d0*p_ne(3))))
		spk(j0:jf) = .TRUE.		!spike variable to TRUE
		spkt(j0:jf) = tr		!spike time update
	END WHERE
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== FROM SPIKES TO CONDUCTANCES ===================================!
!----------------------------- excitatory synapses ----------------------------------------!
	tmp = SUM(spk(1:ne_input)*msynw(1:ne_input))
	x(3) = x(3) - tmp				!AMPA
	x(6) = x(6) - tmp				!NMDA
!------------------------------------------------------------------------------------------!
!--------------------------------- inhibitory synapses ------------------------------------!
	x(4) = x(4) - SUM(spk(ne_input+1:ne_input+ni_input)*msynw(ne_input+1:ne_input+ni_input))	!GABA
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

