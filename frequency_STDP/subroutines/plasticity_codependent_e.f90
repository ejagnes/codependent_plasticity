	SUBROUTINE plasticity_e()
	USE IFPORT
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
!=========================== updates when pre neuron spikes ===============================!
	IF(spk) THEN
		ypost = ypost*EXP((spkt_post2-tr)/p_plast(12))						!update post trace for LTP
		spkt_post2 = tr										!update last time trace is updated
!		msynw = msynw*(1.0d0 - p_plast(16)*ypost)						!update weights without inhibitory control
		msynw = msynw*(1.0d0 - p_plast(16)*ypost*DEXP(-x(19)/p_plast(18)))			!update weights with inhibitory control
	END IF
!==========================================================================================!
!=========================== updates when post neuron spikes ==============================!
	IF(spk_post) THEN
		ypre = ypre*EXP((spkt_pre-tr)/p_plast(11))						!update pre trace
		spkt_pre = tr										!update last time trace is updated
		ypost2 = ypost2*EXP((spkt_post3-tr)/p_plast(13))					!update post trace for heterosynaptic
		spkt_post3 = tr										!update last time trace is updated
!		msynw = msynw + (p_plast(15)*ypre*x(18) - p_plast(17)*ypost2*(x(18)**2))		!update weights without inhibitory control
		msynw = msynw + (p_plast(15)*ypre*x(18) - p_plast(17)*ypost2*(x(18)**2))*DEXP(-x(19)/p_plast(18)) !update weights with inhibitory control
		ypost = ypost*EXP((spkt_post2-tr)/p_plast(12)) + 1.0d0					!update post trace with spike
		spkt_post2 = tr										!update last time trace is updated
		ypost2 = ypost2 + 1.0d0									!update post trace for heterosynaptic
	END IF
!=========================== updates when pre neuron spikes ===============================!
	IF(spk) THEN
		ypre = ypre*EXP((spkt_pre-tr)/p_plast(11)) + 1.0d0			!update pre trace with spike
		spkt_pre = tr								!update time of last spike for trace
	END IF
!==========================================================================================!
!======================== max and min values for excitatory synapses ======================!
	IF(msynw.GT.p_plast(1)) msynw = p_plast(1)					!clip weights to max value
	IF(msynw.LT.p_plast(5)) msynw = p_plast(5)					!clip weights to min value
!==========================================================================================!
	END SUBROUTINE
