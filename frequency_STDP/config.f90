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
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step (ms)
	dt = 0.1d0
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))
!------------------------------- PROTOCOL SPECIFIC ----------------------------------------!
	!number of trials
	p_sim_int(1) = 10
	!number of points
	p_sim_int(2) = 500
	!number of curves (different external input)
	p_sim_int(3) = 6

	!delt t (ms) => pre-post interval (for both pre-before-post and post-before-pre) 
	p_sim(1) = 10.0d0
	!increment for frequency
	p_sim(2) = 50.0d0/DBLE(p_sim_int(2))
!==========================================================================================!
!================================ NEURON PARAMETERS =======================================!
	!neuron membrane potential time constant, tau (ms)
	p_ne(1) = 30.0d0
	!resting membrane potential (mV)
	p_ne(2) = -65.0d0
	!refractory period excitatory (ms)
	p_ne(3) = 2.0d0
	!spiking threshold (mV)
	p_ne(4) = -50.0d0
	!reversal potential for adaptation (mV)
	p_ne(6) = -80.0d0
	!adaptation current amplitude (g_leak)
	p_ne(7) = 0.05d0
	!reset potential (mV)
	p_ne(9) = -60.0d0
	!update rate for activity trace (ms)
	p_ne(10) = 125.0d0
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
	p_inp(11) = 300.0d0
	!duration of current injection (ms)
	p_inp(12) = 2.0d0
!==========================================================================================!
!=============================== CONNECTION WEIGHTS =======================================!
	!synaptic weight - excitatory (plastic) -> postsynaptic neuron (g_leak)
	p_con(5) = 0.12d0
	!synaptic weight - inhibitory (static) -> postsynaptic neuron (g_leak)
	p_con(7) = 0.6d0
	!synaptic weight - excitatory (static) -> postsynaptic neuron (g_leak)
	p_con(17) = 0.9d0*p_con(5)
!==========================================================================================!

!!!!!!!!!!!!!!!!!!!!!!!!! PARAMETERS FOR THE PLASTICITY MODEL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!======================= MAXIMUM/MININUM WEIGHTS FOR SYNAPSES =============================!
	!max synapse weight - excitatory -> excitatory (g_leak)
	p_plast(1) = 1.0d0
	!min synapse weight - excitatory -> excitatory (g_leak)
	p_plast(5) = 0.00001d0
!==========================================================================================!
!======================== EXCITATORY PLASTICITY PARAMETERS ================================!
	!tau_p -> decay time (ms) -> LTP
	p_plast(11) = 16.8d0
	!tau_d -> decay time (ms) -> LTD
	p_plast(12) = 33.7d0
	!tau_het -> decay time (ms) -> heterosynaptic
	p_plast(13) = 125.0d0
	!increment - LTP
	p_plast(15) = 0.0025d0
	!decrement -> LTD
	p_plast(16) = 0.012d0
	!heterosynaptic LTD
	p_plast(17) = 0.00001d0
	!decay term for inhibitory control
	p_plast(18) = 10.0d0
!==========================================================================================!
!===================== PARAMETERS FOR CURRENT TRACES, E & I ===============================!
	!decay for variable E - codependent (ms)
	p_plast(30) = 50.0d0
	p_plast(31) = EXP(-1.0d0*dt/p_plast(30))
	p_plast(32) = 1.0d0 - p_plast(31)
	!decay for variable I - codependent (ms)
	p_plast(33) = 500.0d0
	p_plast(34) = EXP(-1.0d0*dt/p_plast(33))
	p_plast(35) = 1.0d0 - p_plast(34)
!==========================================================================================!
!===================== CHANGING INTERVELS FROM ms TO TIME STEPD============================!
	p_sim_int(4) = NINT(p_sim(1)/dt)
	p_sim_int(5) = p_sim_int(4) + NINT(p_inp(12)/dt)
!==========================================================================================!
!======================== FILES WITH DATA FROM SIMULATION =================================!
	OPEN(100,file="plots_folder.txt")
	WRITE(100,"(A6)")folder
	CLOSE(100)

	CALL SYSTEM('mkdir '//folder)
	OPEN(1,file=folder//'/data01.dat')
	OPEN(2,file=folder//'/data02.dat')

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
!!!!!!!!        x(10) -> external input (mV)                                        !!!!!!!!
!!!!!!!!        x(18) -> NMDA current trace for codependent plasticity              !!!!!!!!
!!!!!!!!        x(19) -> GABA_A current trace for codependent plasticity            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        msynw  -> synaptic weights                                          !!!!!!!!
!!!!!!!!        delta_w(1)  -> change due to post-before-pre                        !!!!!!!!
!!!!!!!!        delta_w(2)  -> change due to pre-before-post                        !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        ypre -> presynaptic traces for plasticity                           !!!!!!!!
!!!!!!!!        ypost,ypost2 -> postsynaptic traces for plasticity                  !!!!!!!!
!!!!!!!!        spkt_pre -> time of last update of presynaptic traces               !!!!!!!!
!!!!!!!!        spkt_post2,spkt_post3 -> time of last update of postsynaptic traces !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
