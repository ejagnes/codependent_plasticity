!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            IMPLEMENTATION OF CODEPENDENT EXCITATORY PLASTICITY             !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE plasticity_orch()
	USE VARIABLES
	USE PARAMETERS
	USE IFPORT
	IMPLICIT NONE
	INTEGER		::	j0,jf
!================================= vector for updates =====================================!
	j0 = 1				!vector starting point
	jf = ne_input			!vector ending point
!==========================================================================================!
!============================= finding which input neurons spiked =========================!
	WHERE(spk(j0:jf))
		ypost(j0:jf) = ypost(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/p_plast(12))			!update post trace
		spkt_post2(j0:jf) = tr									!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) - p_plast(16)*ypost(j0:jf) + p_plast(17)			!update weights
	END WHERE
!==========================================================================================!
!=========================== updates when post neuron spikes ==============================!
	IF(spk_post) THEN
		ypre(j0:jf) = ypre(j0:jf)*EXP((spkt_pre(j0:jf)-tr)/p_plast(11))				!update pre trace
		spkt_pre(j0:jf) = tr									!update last time trace is updated
		ypost2 = ypost2*EXP((spkt_post3-tr)/p_plast(13))					!update post trace for heterosynaptic
		spkt_post3 = tr										!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + p_plast(15)*ypre(j0:jf)*ypost2				!update weights
		ypost(j0:jf) = ypost(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/p_plast(12)) + 1.0d0		!update post trace with spike
		spkt_post2(j0:jf) = tr									!update last time trace is updated
		spkt_post2 = tr										!update last time trace is updated
		ypost2 = ypost2 + 1.0d0									!update post trace for heterosynaptic
	END IF
!==========================================================================================!
!============================= finding which input neurons spiked =========================!
	WHERE(spk(j0:jf))
		ypre(j0:jf) = ypre(j0:jf)*EXP((spkt_pre(j0:jf)-tr)/p_plast(11)) + 1.0d0			!update pre trace with spike
		spkt_pre(j0:jf) = tr									!update time of last spike for trace
	END WHERE
!==========================================================================================!
!======================== max and min values for excitatory synapses ======================!
	WHERE(msynw(j0:jf).GT.p_plast(1)) msynw(j0:jf) = p_plast(1)	!clip weights to max value
	WHERE(msynw(j0:jf).LT.p_plast(5)) msynw(j0:jf) = p_plast(5)	!clip weights to min value
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
