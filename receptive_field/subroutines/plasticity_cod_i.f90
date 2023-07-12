!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            IMPLEMENTATION OF CODEPENDENT INHIBITORY PLASTICITY             !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE plasticity_i()
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	INTEGER		::	j0,jf
!================================= vector for updates =====================================!
	j0 = ne_input+1			!vector starting point
	jf = ne_input+ni_input		!vector ending point
!==========================================================================================!
!============================= finding which input neurons spiked =========================!
	WHERE(spk(j0:jf))
		ypost(j0:jf) = ypost(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/p_plast(21))	!update post trace
		spkt_post2(j0:jf) = tr							!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + p_plast(23)*x(17)*ypost(j0:jf)		!update weights
	END WHERE
!==========================================================================================!
!=========================== updates when post neuron spikes ==============================!
	IF(spk_post) THEN
		ypre(j0:jf) = ypre(j0:jf)*EXP((spkt_pre(j0:jf)-tr)/p_plast(21))			!update pre trace
		spkt_pre(j0:jf) = tr								!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + p_plast(23)*x(17)*ypre(j0:jf)			!update weights
		ypost(j0:jf) = ypost(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/p_plast(21)) + 1.0d0	!update post trace with spike
		spkt_post2(j0:jf) = tr								!update last time trace is updated
	END IF
!==========================================================================================!
!============================= finding which input neurons spiked =========================!
	WHERE(spk(j0:jf))
		ypre(j0:jf) = ypre(j0:jf)*EXP((spkt_pre(j0:jf)-tr)/p_plast(21)) + 1.0d0		!update pre trace with spike
		spkt_pre(j0:jf) = tr								!update time of last spike for trace
	END WHERE
!==========================================================================================!
!======================== max and min values for inhibitory synapses ======================!
	WHERE(msynw(j0:jf).GT.p_plast(3)) msynw(j0:jf) = p_plast(3)	!clip weights to max value
	WHERE(msynw(j0:jf).LT.p_plast(7)) msynw(j0:jf) = p_plast(7)	!clip weights to min value
!==========================================================================================!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	END SUBROUTINE
