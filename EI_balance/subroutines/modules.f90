!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        DECLARATION OF SHARED VARIABLES (PARAMETERS, VARIABLES, TEMP)       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: ne_input,ni_input
	REAL*8			:: p_ne(50),p_sim(10),p_syn(50),p_inp(50),p_con(50),p_plast(50),dt,dpi
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:)
	REAL*8,ALLOCATABLE	:: ypre(:),ypost(:),spkt_post2(:),spkt_pre(:)
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),tr,spkt_post,spkt_post3,ypost2
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:)
	END MODULE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
