!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE PARAMETERS
	USE VARIABLES
	IMPLICIT NONE
	INTEGER					::	n,i
	INTEGER, DIMENSION(:), ALLOCATABLE 	::	seed
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
	spkt_post3 = -10000.0d0
	ypre = 0.0d0
	ypost = 0.0d0
	ypost2 = 0.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!========================== INITIAL EXCITATORY WEIGHTS ====================================!
	msynw(1) = p_con(5)	!weight of first synapse
	msynw(2) = p_con(17)	!weight of second synapse
!==========================================================================================!
!========================== INITIAL EXCITATORY COND AND CURR ==============================!
	exc_pre_cond = 0.0d0
	exc_pre = 0.0d0
!==========================================================================================!
	END SUBROUTINE


