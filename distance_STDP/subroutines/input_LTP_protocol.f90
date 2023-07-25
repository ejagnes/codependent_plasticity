	SUBROUTINE input(t,t0,jj,time_dt)
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	INTEGER		::	pre_spk,post_spk,t,t0,jj,time_dt
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!-------------------------- resetting external current ------------------------------------!
	x(14) = 0.0d0
!------------------------------------------------------------------------------------------!
!=============== LOOP OVER 60 PRESYNAPTIC SPIKES AND POSTSYNAPTIC BURSTS ==================!
	DO pre_spk = 1,60
		!------------------------ generate pre spikes from protocol -------------------------------!
		IF(t.EQ.(1+(pre_spk-1)*5000)) THEN
			t0 = t
			spk(jj) = .TRUE.
			x(3) = x(3) + msynw(jj)						!AMPA
			x(6) = x(6) + msynw(jj)						!NMDA
		END IF
		!------------------------------------------------------------------------------------------!
		!------------------------ generate post currents from protocol ----------------------------!
		DO post_spk = 1,3
			IF(t.EQ.(t0+(10*time_dt)+(post_spk-1)*200)) x(14) = p_inp(11)
		END DO
		!------------------------------------------------------------------------------------------!
	END DO
!==========================================================================================!

	END SUBROUTINE
