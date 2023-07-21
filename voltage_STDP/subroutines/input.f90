!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  POST-BEFORE-PRE SPIKING PROTOCOL                          !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_pre_post(t)
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	IMPLICIT NONE
	INTEGER		::	t
!------------------- resetting pre- and postsynaptic spikes variables ---------------------!
	spk = .FALSE.
	spk_post = .FALSE.
!------------------------------------------------------------------------------------------!
!======================== GENERATE PRE SPIKES FROM PROTOCOL ===============================!
	IF(MOD(t+p_sim_int(4),p_sim_int(5)).EQ.0.0d0) THEN
		spk = .TRUE.
		x(3) = x(3) + msynw
		x(6) = x(6) + msynw
	END IF
!==========================================================================================!
!======================== GENERATE POST SPIKES FROM PROTOCOL ==============================!
	IF(MOD(t,p_sim_int(5)).EQ.0.0d0) spk_post = .TRUE.
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!