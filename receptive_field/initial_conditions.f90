!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE
	INTEGER					::	n,i
!	INTEGER, DIMENSION(:), ALLOCATABLE 	::	seed
!===================== SEED INITIALISATION TO BE THE SAME =================================!
!	CALL RANDOM_SEED(size = n)
!	ALLOCATE(seed(n))
!	seed = 481527891 + 37 * (/ (i - 1, i = 1, n) /)
!	CALL RANDOM_SEED(PUT = seed)
!	DEALLOCATE(seed)
!==========================================================================================!
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0		!all variables to zero
	x(1) = pr(2)		!membrane potential to resting membrane potential
	x(19) = 600.0d0		!high inihibitory current to prevent excitatory plasticity at t=0
	x(24) = 100000.0d0	!high inihibitory current to prevent excitatory plasticity at t=0
	tr = 0.0d0		!simulation time to zero
	t = 0			!simulation timestep to zero
	spk_post = .FALSE.	!no spike at t=0
	patt_time = 0.0d0	!input rate envelope to zero
!---------------------- spike times for LIF and plasticity --------------------------------!
	spkt = -10.0d0
	spkt_pre = -10.0d0
	spkt_post = -10.0d0
	spkt_post2 = -10.0d0
	ypost = 0.0d0
	ypre = 0.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!========================== EXCITATORY INITIAL WEIGHTS ====================================!
	msynw(1:ne_input) = pr(91)
!==========================================================================================!
!========================== INHIBITORY INITIAL WEIGHTS ====================================!
	msynw(ne_input+1:ne_input+ni_input) = pr(93)
!==========================================================================================!


	END SUBROUTINE

