	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: pi(100),ne_input,ni_input,total_time,p_sim_int(10)
	REAL*8			:: p_ne(100),p_syn(100),p_plast(100),p_sim(10),p_con(20),dt,dpi
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8			:: msynw,spkt
	REAL*8			:: ypre,ypost,spkt_post2,spkt_pre,ypost2
	REAL*8			:: spkt2,ypre2,ca_amp
	LOGICAL			:: spk_post,spk
	REAL*8			:: x(30),tr,spkt_post,spkt_post3,inp_clamp
	END MODULE
