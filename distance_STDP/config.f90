!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        FILE WITH PARAMETERS FOR SIMULATION                                 !!!!!!!!
!!!!!!!!        ALL PARAMETERS EXPLAINED BELOW                                      !!!!!!!!
!!!!!!!!        VARIABLES EXPLAINED AT TABLE AT THE END                             !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE config()
	USE PARAMETERS
	IMPLICIT NONE
	REAL*8 :: tmp
!====================== FOLDER NAME - 6 CHARACTERS ========================================!
	folder = "data01"
!==========================================================================================!
!======================== PRE-SYNAPTIC NEURONS (HOMOGENEOUS) ==============================!
	!total number of pre-synaptic neurons
	ne_input = 2
	ni_input = 0
!==========================================================================================!
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step (ms)
	dt = 0.1d0
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))
!==========================================================================================!
!================================ NEURON PARAMETERS =======================================!
	!neuron membrane potential time constant, tau (ms)
	p_ne(1) = 30.0d0
	!resting membrane potential (mV)
	p_ne(2) = -65.0d0
	!refractory period excitatory (ms) -> not used here
	p_ne(3) = 5.0d0
	!spiking threshold (mV)
	p_ne(4) = -50.0d0
	!reversal potential for adaptation (mV)
	p_ne(6) = -80.0d0
	!adaptation current amplitude (g_leak) -> not used here
	p_ne(7) = 5.0d0
	!reset potential (mV)
	p_ne(9) = -60.0d0
	!update rate for activity trace (ms) -> not used here
	p_ne(10) = 100.0d0
	p_ne(10) = EXP(-1.0d0*dt/p_ne(10))
!==========================================================================================!
!========================== SYNAPSE PARAMETERS ============================================!
	!reversal potential - excitatory - AMPA (mV) -> not used
	p_syn(1) = 0.0d0
	!reversal potential - inhibitory - GABA_A (mV)
	p_syn(2) = -80.0d0
	!synaptic time constant - AMPA (ms)
	p_syn(3) = 5.0d0
	p_syn(3) = EXP(-1.0d0*dt/p_syn(3))
	!synaptic time constant - GABA_A (ms)
	p_syn(4) = 10.0d0
	p_syn(4) = EXP(-1.0d0*dt/p_syn(4))
	!synaptic time constant - NMDA (ms)
	p_syn(5) = 150.0d0
	p_syn(5) = EXP(-1.0d0*dt/p_syn(5))
	!NMDA parameter 1
	p_syn(6) = 0.15d0
	!NMDA parameter 2
	p_syn(7) = -0.08d0
!==========================================================================================!
!================================ EXTERNAL INPUT ==========================================!
	!amplitude of input current to elicit an action potential (mV)
	p_inp(11) = 600.0d0
!==========================================================================================!
!=============================== CONNECTION WEIGHTS =======================================!
	!synaptic weight - excitatory (plastic) -> postsynaptic neuron (g_leak)
	p_con(5) = 0.12d0
	!synaptic weight - excitatory (static) -> postsynaptic neuron (g_leak)
	p_con(17) = 0.15d0*p_con(5)
!==========================================================================================!

!!!!!!!!!!!!!!!!!!!!!!!!! PARAMETERS FOR THE PLASTICITY MODEL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!======================= MAXIMUM/MININUM WEIGHTS FOR SYNAPSES =============================!
	!max synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(1) = 1.0d0
	!min synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(5) = 0.0001d0
!==========================================================================================!
!======================== EXCITATORY PLASTICITY PARAMETERS ================================!
	!tau_p -> decay time (ms0 -> LTP
	p_plast(11) = 16.8d0
	!tau_d -> decay time (ms) -> LTD
	p_plast(12) = 33.7d0
	!tau_het -> decay time (ms) -> heterosynaptic
	p_plast(13) = 300.0d0
	!increment - LTP
	p_plast(15) = 0.5d0
	!decrement - LTD
	p_plast(16) = 0.02d0
	!heterosynaptic LTD
	p_plast(17) = 2.02d0*p_plast(15)
!==========================================================================================!
!===================== PARAMETERS FOR CURRENT TRACES, E & I ===============================!
	!decay for variable E - codependent (ms)
	p_plast(30) = 250000.0d0
	p_plast(31) = EXP(-1.0d0*dt/p_plast(30))
	p_plast(32) = 1.0d0 - p_plast(31)
!==========================================================================================!
!======================== PARAMETERS FOR GAUSSIAN WITH DISTANCE EFFECT ====================!
	!sigma^2 of gaussian
	p_plast(40) = 10.0d0
	!distance between two synapses
	p_plast(41) = 3.0d0
	!"neihgbouring" term
	p_plast(42) = DEXP(-0.5d0*((p_plast(41)**2)/p_plast(40)))
!==========================================================================================!
!======================== FILES WITH DATA FROM SIMULATION =================================!
	OPEN(100,file="plots_folder.txt")
	WRITE(100,"(A6)")folder
	CLOSE(100)

	CALL SYSTEM('mkdir '//folder)
	OPEN(1,file=folder//'/data01.dat')
	OPEN(2,file=folder//'/data02.dat')
	OPEN(3,file=folder//'/data03.dat')

	CALL SYSTEM('mkdir '//folder//'/code')
	CALL SYSTEM('cp *f90 '//folder//'/code/')
	CALL SYSTEM('cp subroutines/*f90 '//folder//'/code/')
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        VARIABLES                                                           !!!!!!!!
!!!!!!!!        x(1)  -> membrane potential (mV)                                    !!!!!!!!
!!!!!!!!        x(2)  -> AHP conductance (g_leak)                                   !!!!!!!!
!!!!!!!!        x(3)  -> AMPA conductance (g_leak)                                  !!!!!!!!
!!!!!!!!        x(4)  -> GABA_A conductance (g_leak)                                !!!!!!!!
!!!!!!!!        x(6)  -> NMDA conductance (g_leak)                                  !!!!!!!!
!!!!!!!!        x(8)  -> NMDA nonlinear function (1)                                !!!!!!!!
!!!!!!!!        x(14) -> external input (mV)                                        !!!!!!!!
!!!!!!!!        x(18) -> NMDA current trace for codependent plasticity              !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        msynw  -> synaptic weights                                          !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        ypre -> presynaptic traces for plasticity                           !!!!!!!!
!!!!!!!!        ypost,ypost2 -> postsynaptic traces for plasticity                  !!!!!!!!
!!!!!!!!        spkt_pre -> time of last update of presynaptic traces               !!!!!!!!
!!!!!!!!        spkt_post2,spkt_post3 -> time of last update of postsynaptic traces !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
