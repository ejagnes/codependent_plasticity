!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!              IMPLEMENTATION OF INHOMOGENEOUS POISSON INPUT                 !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_g(t)
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	pw,t,j0,jf
	REAL*8 			::	tmp,randg
!======================= GENERATING CORRELATIONS IN GROUPS OF NEURONS =====================!
	IF(MOD(t,10).EQ.0) THEN							!update every 10 time steps
!---------------------------- loop over input signals -------------------------------------!
		DO pw = 1,n_pw
			CALL grand(1.0d0,randg)					!call random number from gaussian distribution
			patt_time(pw) = patt_time(pw)*pr(81) + pr(84)*randg*pr(82)		!decay of rate envelope and addition of random gaussian noise
		!----------------------- from random variable to spike probability ------------------------!
			IF(patt_time(pw).GT.0.0d0) THEN		!if positive
				inp_patt(pw) = (dt*patt_time(pw))/1000.0d0
			ELSE					!rectification
				inp_patt(pw) = 0.0d0
			END IF
			!------------------------------------------------------------------------------------------!
		END DO
		!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!================ GENERATE SPIKES FROM RATE PROPABILITIES - DENDRITE 1 ====================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!------------------------- correlated excitatory neurons ----------------------------------!
	j0 = 1
	jf = ne_corr
	WHERE((tmp_inp(j0:jf).LE.(pr(75)+inp_patt(1))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------ uncorrelated excitatory neurons ---------------------------------!
	j0 = ne_corr + 1
	jf = ne_input
	WHERE((tmp_inp(j0:jf).LE.(pr(75)+inp_patt(j0:jf))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------- correlated inhibitory neurons ----------------------------------!
	j0 = ne_input + 1
	jf = ne_input + ni_corr
	WHERE((tmp_inp(j0:jf).LE.(pr(76)+pr(205)*inp_patt(1))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------ uncorrelated inhibitory neurons ---------------------------------!
	j0 = ne_input + ni_corr + 1
	jf = ne_input + ni_input
	WHERE((tmp_inp(j0:jf).LE.(pr(76)+pr(205)*inp_patt(j0:jf))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.
		spkt(j0:jf) = tr
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== FROM SPIKES TO CONDUCTANCES ===================================!
!------------------------- excitatory neurons ----------------------------------------------!
	tmp = SUM(DBLE(spk(1:ne_input))*msynw(1:ne_input))
	xd(3) = xd(3) - tmp
	xd(6) = xd(6) - tmp
!------------------------------------------------------------------------------------------!
!------------------------- inhibitory neurons ---------------------------------------------!
	tmp = SUM(DBLE(spk(ne_input+1:ne_input+ni_input))*msynw(ne_input+1:ne_input+ni_input))
	xd(4) = xd(4) - tmp
!------------------------------------------------------------------------------------------!
!================ GENERATE SPIKES FROM RATE PROPABILITIES - DENDRITE 2 ====================!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!------------------------- excitatory neurons ----------------------------------------------!
	DO pw = (n_pw/2)+1,(n_pw/2)+ne_input
		IF(tmp_inp(pw/2).LE.pr(75)+inp_patt(pw)) THEN	
			xdb(3) = xdb(3) + pr(91)
			xdb(6) = xdb(6) + pr(91)
		END IF
	END DO
!------------------------------------------------------------------------------------------!
!------------------------- inhibitory neurons ---------------------------------------------!
	DO pw = (n_pw/2)+ne_input+1,n_pw
		IF(tmp_inp(pw/2).LE.pr(75)+pr(205)*inp_patt(pw)) THEN	
			xdb(4) = xdb(4) + pr(93)*2.2d0
		END IF
	END DO
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!! RANDOM NUMBER GENERATOR - GAUSSIAN NOISE !!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE grand(std_dev,randg)		!arguments -> standard deviation, and output
	USE IFPORT
	USE PARAMETERS
	IMPLICIT NONE
	REAL*8 :: random_number1,random_number2,std_dev
	REAL*8 :: randg
!------------------------ ramdom number between 0 and 1 -----------------------------------!
	random_number1 = rand()
	random_number2 = rand()
!------------------------------------------------------------------------------------------!
!------------------------- generating gaussian random number ------------------------------!
	randg = std_dev*SQRT( -2.0d0*LOG(random_number1) )*COS( dpi*random_number2 )
!------------------------------------------------------------------------------------------!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
