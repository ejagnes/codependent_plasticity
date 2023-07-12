!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        DECLARATION OF SHARED VARIABLES (PARAMETERS, VARIABLES, TEMP)       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: pi(100),ne_input,ni_input,ne_pw,ni_pw,n_pw
	REAL*8			:: pr(300),p_plast(50),dt,dpi
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:),spkr(:)
	REAL*8,ALLOCATABLE	:: ypre(:),ypost(:),spkt_post2(:),spkt_pre(:)
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),tr,spkt_post
	REAL*8,ALLOCATABLE	:: patt_time(:),inp_patt(:),tmp_e(:),tmp_i(:)
	INTEGER,ALLOCATABLE	:: branch(:)
	INTEGER			:: t
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:)
	END MODULE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
