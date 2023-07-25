!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            IMPLEMENTATION OF CODEPENDENT EXCITATORY PLASTICITY             !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE plasticity_e()
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER		::	j0,jf,j,k
	REAL*8		::	exc_eff
!================================= vector for updates =====================================!
	j0 = 1				!vector starting point
	jf = ne_input			!vector ending point
!==========================================================================================!
!============================= finding which input neurons spiked =========================!
	WHERE(spk(j0:jf))
		ypost(j0:jf) = ypost(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/p_plast(12))			!update post trace
		spkt_post2(j0:jf) = tr									!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf)*(1.0d0 - p_plast(16)*ypost(j0:jf))				!update weights
	END WHERE
!==========================================================================================!
!=========================== updates when post neuron spikes ==============================!
	IF(spk_post) THEN
		ypost2 = ypost2*EXP((spkt_post3-tr)/p_plast(13))					!update post trace for heterosynaptic
		spkt_post3 = tr										!update last time trace is updated
		DO j = 1,ne_input
			ypre(j) = ypre(j)*EXP((spkt_pre(j)-tr)/p_plast(11))				!update pre trace
			spkt_pre(j) = tr								!update last time trace is updated
			IF(j.EQ.1) exc_eff = exc_pre(1) + p_plast(42)*exc_pre(2)			!update excitatory current trace from neighbour
			IF(j.EQ.2) exc_eff = exc_pre(2) + p_plast(42)*exc_pre(1)			!update excitatory current trace from neighbour
			msynw(j) = msynw(j) + (p_plast(15)*ypre(j)*exc_eff - p_plast(17)*ypost2*(exc_eff**2))	!update weights
			ypost(j) = ypost(j)*EXP((spkt_post2(j)-tr)/p_plast(12)) + 1.0d0			!update post trace with spike
			spkt_post2(j) = tr								!update last time trace is updated
		END DO
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
	WHERE(msynw(j0:jf).GT.p_plast(1)) msynw(j0:jf) = p_plast(1)					!clip weights to max value
	WHERE(msynw(j0:jf).LT.p_plast(5)) msynw(j0:jf) = p_plast(5)					!clip weights to min value
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
