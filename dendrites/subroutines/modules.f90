	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: pi(100),ne_input,ni_input,ne_pw,ni_pw,n_pw,n_branch,ne_unc,ni_unc,ne_unci,ni_unci,ne_corr,ni_corr
	REAL*8			:: pr(300),p_plast(50),dt,dpi,gc_a,dist
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:),y(:,:),z(:,:)
	REAL*8,ALLOCATABLE	:: ypre(:),ypost(:),spkt_post2(:),spkt_pre(:)
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),xd(30),xdb(30),tr,tr2,spkt_post
	REAL*8,ALLOCATABLE	:: patt_time(:),inp_patt(:),inp_patt2(:),unc_burst(:),inp_unc(:)
	INTEGER,ALLOCATABLE	:: branch(:)
	INTEGER			:: spk_count
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:)
	END MODULE
