!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0		!all variables to zero
	x(1) = pr(2)		!membrane potential of soma to resting membrane potential
	x(19) = 100.0d0		!high inihibitory current to prevent excitatory plasticity at t=0
	xd = 0.0d0		!all dendrite 1 variables to zero
	xd(1) = pr(2)		!membrane potential of dendrite 1 to resting membrane potential
	xdb = 0.0d0		!all dendrite 2 variables to zero
	xdb(1) = pr(2)		!membrane potential of dendrite 1 to resting membrane potential
	tr = 0.0d0		!simulation time to zero
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
