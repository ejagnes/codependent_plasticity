!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	IMPLICIT NONE
!========================= VARIABLES INITIALISATION =======================================!	
	x = 0.0d0		!all variables to zero
	x(1) = p_ne(2)		!membrane potential to resting membrane potential
	x(12) = inp_clamp	!external current
	spk_post = .FALSE.	!no post spike at t=0
	spk = .FALSE.		!no pre spike at t=0
	tr = 0.0d0		!simulation time to zero
!---------------------- spike times for LIF and plasticity --------------------------------!
	spkt_post = -1000.0d0
	spkt_post2 = -1000.0d0
	spkt_post3 = -1000.0d0
	spkt_pre = -1000.0d0
	ypre = 0.0d0
	ypost = 0.0d0
	ypost2 = 0.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!====================== PLASTIC EXCITATORY INITIAL WEIGHTS ================================!
	msynw = p_con(5)
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
