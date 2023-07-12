!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!              IMPLEMENTATION OF INHOMOGENEOUS POISSON INPUT                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_g()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER			::	pw,j0,jf
	REAL*8 			::	randg,tmp
!======================= GENERATING CORRELATIONS IN GROUPS OF NEURONS =====================!
	IF(MOD(t,10).EQ.0) THEN							!update every 10 time steps
	!---------------------------- loop over input signals -------------------------------------!
		DO pw = 1,n_pw
			CALL grand(1.0d0,randg)					!call random number from gaussian distribution
			patt_time(pw) = patt_time(pw)*pr(81) + randg		!decay of rate envelope and addition of random gaussian noise
		!----------------------- from random variable to spike probability ------------------------!
			IF(patt_time(pw).GT.0.0d0) THEN		!if positive	
				inp_patt(pw) = (pr(82)*dt*patt_time(pw))/1000.0d0
			ELSE					!rectification
				inp_patt(pw) = 0.0d0
			END IF
			!------------------------------------------------------------------------------------------!
		END DO
		!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!======================== GENERATE SPIKES FROM RATE PROPABILITIES =========================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spkr = 0.0d0
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!-------------------------excitatory neurons-----------------------------------------------!
	DO pw = 1,n_pw
		j0 = (pw-1)*ne_pw + 1			!vector starting point
		jf = pw*ne_pw				!vector ending point
	!------------ finding neurons that spiked and implementing refrac period ------------------!
		WHERE((tmp_inp(j0:jf).LE.(pr(75)+inp_patt(pw))).AND.(tr-spkt(j0:jf).GT.pr(3)))
			spk(j0:jf) = .TRUE.		!spike variable to TRUE
			spkt(j0:jf) = tr		!spike time update
			spkr(j0:jf) = 1.0d0		!spike variable for inputs
		END WHERE
	END DO
	!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!-------------------------inhibitory neurons ----------------------------------------------!
	DO pw = 1,n_pw
		j0 = ne_input + (pw-1)*ni_pw + 1	!vector starting point
		jf = ne_input + pw*ni_pw		!vector ending point
	!------------ finding neurons that spiked and implementing refrac period ------------------!
		WHERE((tmp_inp(j0:jf).LE.(pr(205)*(pr(76)+inp_patt(pw)))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
			spk(j0:jf) = .TRUE.	!spike variable to TRUE
			spkt(j0:jf) = tr	!spike time update
			spkr(j0:jf) = 1.0d0	!spike variable for inputs
		END WHERE
	!------------------------------------------------------------------------------------------!
	END DO
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== FROM SPIKES TO CONDUCTANCES ==================================!
!-------------------------excitatory synapses----------------------------------------------!
	tmp = SUM(spkr(1:ne_input)*msynw(1:ne_input))
	x(3) = x(3) + tmp				!AMPA
	x(6) = x(6) + tmp				!NMDA
!------------------------------------------------------------------------------------------!
!-------------------------inhibitory synapses----------------------------------------------!
	x(4) = x(4) + SUM(spkr(ne_input+1:ne_input+ni_input)*msynw(ne_input+1:ne_input+ni_input))	!GABA
!------------------------------------------------------------------------------------------!
	x(25) = SUM(spkr(1:ne_input)) + x(25)
	x(26) = SUM(spkr(ne_input+1:ne_input+ni_input)) + x(26)
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!             PSEUDO RANDOM GAUSSIAN RANDOM NUMBER GENERATOR                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE grand(std_dev,randg)		!arguments -> standard deviation, and output
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	REAL*8 :: random_number_g(2),std_dev
	REAL*8 :: randg
!------------------------ ramdom number between 0 and 1 -----------------------------------!
	CALL RANDOM_NUMBER(random_number_g)
!------------------------------------------------------------------------------------------!
!------------------------- generating gaussian random number ------------------------------!
	randg = std_dev*DSQRT( -2.0d0*DLOG(random_number_g(1)) )*DCOS( dpi*random_number_g(2) )
!------------------------------------------------------------------------------------------!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
