!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        FILE WITH PARAMETERS FOR SIMULATION                                 !!!!!!!!
!!!!!!!!        ALL PARAMETERS EXPLAINED BELOW                                      !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE config()
	USE PARAMETERS
	IMPLICIT NONE
	REAL*8 :: tmp
!====================== FOLDER NAME - 6 CHARACTERS ========================================!
	folder = "data01"
!==========================================================================================!
!======================== PRE-SYNAPTIC NEURONS (PATHWAYS)==================================!
	!total number of pre-synaptic neurons
	ne_input = 32
	ni_input = ne_input/2
	!number of correlated excitatory neurons (loop in main code)
!	ne_corr = 
	!number of correlated inhibitory neurons
	ni_corr = 8
	!number of pathways
	n_pw = ne_input+ni_input
	n_pw = n_pw*2
!==========================================================================================!
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step
	dt = 0.1d0
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))
!==========================================================================================!
!================================ NEURON PARAMETERS =======================================!
	!neuron membrane potential time constant, tau (ms)
	pr(1) = 30.0d0
	pr(1) = -1.0d0*dt/pr(1)
	!resting membrane potential (mV)
	pr(2) = -65.0d0
	!refractory period excitatory (ms)
	pr(3) = 5.0d0
	!spiking threshold (mV)
	pr(4) = -50.0d0
	!reversal potential for adaptation (mV)
	pr(6) = -80.0d0
	!adaptation current amplitude (g_leak)
	pr(7) = 0.5d0
	!reset potential (mV)
	pr(9) = -60.0d0
	!update rate for activity trace (ms)
	pr(10) = 100.0d0
	pr(10) = EXP(-1.0d0*dt/pr(10))
!==========================================================================================!
!========================== SYNAPSE PARAMETERS ============================================!
	!reversal potential - inhibitory - GABA_A (mV)
	pr(32) = -80.0d0
	!synaptic time constant - AMPA (ms)
	pr(35) = 5.0d0
	pr(35) = EXP(-1.0d0*dt/pr(35))
	!synaptic time constant - GABA_A (ms)
	pr(36) = 10.0d0
	pr(36) = EXP(-1.0d0*dt/pr(36))
	!synaptic time constant - NMDA (ms)
	pr(37) = 150.0d0
	pr(37) = EXP(-1.0d0*dt/pr(37))
	!NMDA parameter 1
	pr(38) = 0.15d0
	!NMDA parameter 2
	pr(39) = -0.08d0
!==========================================================================================!
!================================ EXTERNAL INPUT ==========================================!
	!background firing-rate -> excitatory neurons (Hz)
	pr(75) = 2.0d0
	pr(75) = (dt*pr(75))/1000.0d0
	!background firing-rate -> inhibitory neurons (Hz)
	pr(76) = 4.0d0
	pr(76) = (dt*pr(76))/1000.0d0
	!burst firing-rate -> excitatory neurons (Hz)
	pr(77) = 100.0d0
	pr(77) = (dt*pr(77))/1000.0d0

	!tau for OU process (/10) (ms)
	pr(80) = 5.0d0
	!decay time
	pr(81) = DEXP(-dt/pr(80))
	!decay time 2
	pr(82) = 1.0d0 - pr(81)
	!amplitude
	pr(84) = 250.0d0
!==========================================================================================!
!=============================== CONNECTION WEIGHTS =======================================!
	!synaptic weight - excitatory -> postsynaptic neuron (g_leak)
	pr(91) = 0.3d0
	!synaptic weight - inhibitory -> postsynaptic neuron (g_leak)
	pr(93) = 0.5d0
!==========================================================================================!

!!!!!!!!!!!!!!!!!!!!!!!!! PARAMETERS FOR THE PLASTICITY MODEL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!======================= MAXIMUM/MININUM WEIGHTS FOR SYNAPSES =============================!
	!max synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(1) = 1.0d0
	!max synapse weight - inhibitory -> postsynaptic neuron (g_leak)
	p_plast(3) = 10.0d0
	!min synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(5) = 0.00001d0
	!min synapse weight - inhibitory -> postsynaptic neuron (g_leak)
	p_plast(7) = 0.0001d0
!==========================================================================================!
!======================== EXCITATORY PLASTICITY PARAMETERS ================================!
!-----------------------EXCITATORY--------------------------------!
	!tau_p -> decay time (ms) -> LTP
	p_plast(11) = 16.8d0
	!tau_d -> decay time (ms) -> LTD
	p_plast(12) = 33.7d0
	!!
	p_plast(13) = 0.0d0
	!!
	p_plast(14) = 0.0d0
	!increment - LTP
	p_plast(15) = 0.00003d0
	!decrement -> LTD
	p_plast(16) = 50.0d0*p_plast(15)
	!heterosynaptic LTD
	p_plast(17) = 0.0002d0*p_plast(15)
	!decay term for inhibitory control
	p_plast(18) = 50.0d0
	!presynaptic increase alone
	p_plast(19) = 0.1d0*p_plast(15)
!==========================================================================================!
!======================== INHIBITORY PLASTICITY PARAMETERS ================================!
	!tau_I -> decay time(ms)
	p_plast(21) = 20.0d0
	!!
	p_plast(22) = 0.0d0
	!increment - LTP
	p_plast(23) = 0.001d0
	!decrement - LTD
	p_plast(24) = 0.0d0
	!balance term - codependent
	p_plast(25) = 1.75d0
	!amplitude of balance difference
	p_plast(26) = 0.0001d0
!==========================================================================================!
!===================== PARAMETERS FOR CURRENT TRACES, E & I ===============================!
	!decay for variable E - codependent (ms)
	p_plast(30) = 10.0d0
	p_plast(31) = EXP(-1.0d0*dt/p_plast(30))
	p_plast(32) = 1.0d0 - p_plast(31)
	!decay for variable I - codependent (ms)
	p_plast(33) = 100.0d0
	p_plast(34) = EXP(-1.0d0*dt/p_plast(33))
	p_plast(35) = 1.0d0 - p_plast(34)
!==========================================================================================!
!=============================== DENDRITIC PARAMETERS =====================================!
	!conductance dendrites <-> soma
	pr(197) = 8.0d0
	gc_a = 62500.0d0
	dist = DSQRT(gc_a/pr(197))
!==========================================================================================!
!======================== FIRING RATE OF INHIBITORY POPULATIONS ===========================!
	pr(205) = 2.0d0
!==========================================================================================!
!======================== FILES WITH DATA FROM SIMULATION =================================!
	OPEN(100,file="plots_folder.txt")
	WRITE(100,"(A6)")folder
	CLOSE(100)

	CALL SYSTEM('mkdir '//folder)
	OPEN(1,file=folder//'/data01.dat')

	CALL SYSTEM('mkdir '//folder//'/code')
	CALL SYSTEM('cp *f90 '//folder//'/code/')
	CALL SYSTEM('cp subroutines/*f90 '//folder//'/code/')
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
