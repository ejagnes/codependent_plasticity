!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	IMPLICIT NONE
	INTEGER					::	n,i
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0		!all variables to zero
	x(1) = p_ne(2)		!membrane potential to resting membrane potential
	tr = 0.0d0		!simulation time to zero
	spk_post = .FALSE.	!no spike at t=0
!---------------------- spike times for LIF and plasticity --------------------------------!
	spkt = -10.0d0
	spkt_pre = -10.0d0
	spkt_post = -10.0d0
	spkt_post2 = -10.0d0
	spkt_post3 = -10.0d0
	ypost = 0.0d0
	ypost2 = 0.0d0
	ypre = 0.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!========================== EXCITATORY INITIAL WEIGHTS ====================================!
	msynw(1:ne_input) = p_con(5)
!==========================================================================================!
!========================== INHIBITORY INITIAL WEIGHTS ====================================!
	msynw(ne_input+1:ne_input+ni_input) = p_con(7)
!==========================================================================================!


	END SUBROUTINE

