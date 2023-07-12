!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                IMPLEMENTATION OF HOMOGENEOUS POISSON INPUT                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_b(pw)
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	pw,j0,jf,pw2
	REAL*8 			::	tmp
!======================== GENERATE SPIKES FROM RATE PROPABILITIES =========================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spkr = 0.0d0
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!-------------------- excitatory synapses of active pathway -------------------------------!
	j0 = (pw-1)*ne_pw + 1			!vector starting point
	jf = pw*ne_pw				!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(pr(77))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.		!spike variable to TRUE
		spkt(j0:jf) = tr		!spike time update
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!-------------------- excitatory synapses of all pathways ---------------------------------!
	j0 = 1					!vector starting point
	jf = ne_input				!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(pr(75))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!---------------------- inhibitory synapses of active pathway -----------------------------!
	j0 = ne_input + (pw-1)*ni_pw + 1	!vector starting point
	jf = ne_input + pw*ni_pw		!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(pr(205)*pr(78))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.		!spike variable to TRUE
		spkt(j0:jf) = tr		!spike time update
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!----------------------- inhibitory synapses of all pathways ------------------------------!
	DO pw2 = 1,n_pw
		IF(pw2.NE.pw) THEN
			j0 = ne_input + (pw2-1)*ni_pw + 1	!vector starting point
			jf = ne_input + pw2*ni_pw		!vector ending point
			WHERE((tmp_inp(j0:jf).LE.(pr(205)*pr(76))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
				spk(j0:jf) = .TRUE.		!spike variable to TRUE
				spkt(j0:jf) = tr		!spike time update
				spkr(j0:jf) = 1.0d0		!spike variable for inputs
			END WHERE
		END IF
	END DO
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== FROM SPIKES TO CONDUCTANCES ===================================!
!-------------------------excitatory neurons-----------------------------------------------!
	tmp = SUM(spkr(1:ne_input)*msynw(1:ne_input))
	x(3) = x(3) + tmp				!AMPA
	x(6) = x(6) + tmp				!NMDA
!------------------------------------------------------------------------------------------!
!-------------------------inhibitory neurons-----------------------------------------------!
	x(4) = x(4) + SUM(spkr(ne_input+1:ne_input+ni_input)*msynw(ne_input+1:ne_input+ni_input))	!GABA
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                IMPLEMENTATION OF HOMOGENEOUS POISSON INPUT                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_bn(pw)
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	pw,j0,jf,pw2,i,pwn
	REAL*8 			::	tmp,prop_fr
!======================== GENERATE SPIKES FROM RATE PROPABILITIES =========================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spkr = 0.0d0
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!-------------------- excitatory synapses of active pathway -------------------------------!
	DO pwn = 1,n_pw
		IF(pwn.EQ.pw) prop_fr = 0.8d0
		IF(pwn.EQ.(pw-1)) prop_fr = 0.6d0
		IF(pwn.EQ.(pw+1)) prop_fr = 0.6d0
		IF(pwn.EQ.(pw-2)) prop_fr = 0.4d0
		IF(pwn.EQ.(pw+2)) prop_fr = 0.4d0
		IF(pwn.EQ.(pw-3)) prop_fr = 0.3d0
		IF(pwn.EQ.(pw+3)) prop_fr = 0.3d0
		IF(pwn.EQ.(pw-4)) prop_fr = 0.2d0
		IF(pwn.EQ.(pw+4)) prop_fr = 0.2d0
		IF(pwn.EQ.(pw-5)) prop_fr = 0.15d0
		IF(pwn.EQ.(pw+5)) prop_fr = 0.15d0

		j0 = (pwn-1)*ne_pw + 1			!vector starting point
		jf = pwn*ne_pw				!vector ending point
		WHERE((tmp_inp(j0:jf).LE.(prop_fr*pr(77))).AND.(tr-spkt(j0:jf).GT.pr(3)))
			spk(j0:jf) = .TRUE.		!spike variable to TRUE
			spkt(j0:jf) = tr		!spike time update
			spkr(j0:jf) = 1.0d0		!spike variable for inputs
		END WHERE
	END DO
!------------------------------------------------------------------------------------------!
!-------------------- excitatory synapses of all pathways ---------------------------------!
	j0 = 1					!vector starting point
	jf = ne_input				!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(pr(75))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!----------------------- inhibitory synapses of all pathways ------------------------------!
	j0 = ne_input + 1			!vector starting point
	jf = ne_input + ni_input		!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(pr(205)*pr(76))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.		!spike variable to TRUE
		spkt(j0:jf) = tr		!spike time update
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== FROM SPIKES TO CONDUCTANCES ===================================!
!-------------------------excitatory neurons-----------------------------------------------!
	tmp = SUM(spkr(1:ne_input)*msynw(1:ne_input))
	x(3) = x(3) + tmp				!AMPA
	x(6) = x(6) + tmp				!NMDA
!------------------------------------------------------------------------------------------!
!-------------------------inhibitory neurons-----------------------------------------------!
	x(4) = x(4) + SUM(spkr(ne_input+1:ne_input+ni_input)*msynw(ne_input+1:ne_input+ni_input))	!GABA
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                IMPLEMENTATION OF HOMOGENEOUS POISSON INPUT                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_h()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	j0,jf,i
	REAL*8 			::	tmp
!======================== GENERATE SPIKES FROM RATE PROPABILITIES =========================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spkr = 0.0d0
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!-------------------- excitatory synapses of all pathways ---------------------------------!
	j0 = 1					!vector starting point
	jf = ne_input				!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(5.0d0*pr(75))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!----------------------- inhibitory synapses of all pathways ------------------------------!
	j0 = ne_input + 1			!vector starting point
	jf = ne_input + ni_input		!vector ending point
	WHERE((tmp_inp(j0:jf).LE.(pr(205)*pr(76))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.		!spike variable to TRUE
		spkt(j0:jf) = tr		!spike time update
		spkr(j0:jf) = 1.0d0		!spike variable for inputs
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== FROM SPIKES TO CONDUCTANCES ===================================!
!-------------------------excitatory neurons-----------------------------------------------!
	tmp = SUM(spkr(1:ne_input)*msynw(1:ne_input))
	x(3) = x(3) + tmp				!AMPA
	x(6) = x(6) + tmp				!NMDA
!------------------------------------------------------------------------------------------!
!-------------------------inhibitory neurons-----------------------------------------------!
	x(4) = x(4) + SUM(spkr(ne_input+1:ne_input+ni_input)*msynw(ne_input+1:ne_input+ni_input))	!GABA
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

