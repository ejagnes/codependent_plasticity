	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: p_sim_int(10)
	REAL*8			:: dt,dpi,p_plast(40),p_syn(10),p_ne(20),p_con(20),p_inp(20),p_sim(40)
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8			:: tr,x(30),msynw
	REAL*8			:: ypre,ypost,ypost2,spkt,spkt_post2,spkt_pre,spkt_post,spkt_post3
	LOGICAL			:: spk_post,spk
	INTEGER			:: period
	END MODULE
