!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        FILE WITH PARAMETERS FOR SIMULATION                                 !!!!!!!!
!!!!!!!!        ALL PARAMETERS EXPLAINED BELOW                                      !!!!!!!!
!!!!!!!!        VARIABLES EXPLAINED AT TABLE AT THE END                             !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE config()
	USE PARAMETERS
	IMPLICIT NONE
!====================== FOLDER NAME - 6 CHARACTERS ========================================!
	folder = "data01"
!==========================================================================================!
!======================== PRE-SYNAPTIC NEURONS (HOMOGENEOUS) ==============================!
	!total number of pre-synaptic neurons
	ne_input = 800
	ni_input = 200
!==========================================================================================!
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step (ms)
	dt = 0.1d0
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))
!------------------------------- PROTOCOL SPECIFIC ----------------------------------------!
	!period for each simulation block with different firing-rate set-point (hours)
	p_sim(1) = 10.0d0
	!period between points in plots (s)
	p_sim(2) = 10.0d0
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
	!background firing-rate -> excitatory neurons (Hz)
	p_inp(2) = 10.0d0
	p_inp(2) = (dt*p_inp(2))/1000.0d0
	!background firing-rate -> inhibitory neurons (Hz)
	p_inp(3) = 20.0d0
	p_inp(3) = (dt*p_inp(3))/1000.0d0
!==========================================================================================!
!=============================== CONNECTION WEIGHTS =======================================!
	!synaptic weight - excitatory (plastic) -> postsynaptic neuron (g_leak)
	p_con(5) = 0.11d0
	!synaptic weight - inhibitory (plastic) -> postsynaptic neuron (g_leak)
	p_con(7) = 0.7d0
!==========================================================================================!
!!!!!!!!!!!!!!!!!!!!!!!!! PARAMETERS FOR THE PLASTICITY MODEL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!======================= MAXIMUM/MININUM WEIGHTS FOR SYNAPSES =============================!
	!max synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(1) = 1.15d0
	!max synapse weight - inhibitory -> postsynaptic neuron (g_leak)
	p_plast(3) = 10.0d0
	!min synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(5) = 0.000001d0
	!min synapse weight - inhibitory -> postsynaptic neuron (g_leak)
	p_plast(7) = 0.000001d0
!==========================================================================================!
!=================== SPIKE-BASED EXCITATORY PLASTICITY PARAMETERS =========================!
	!tau_p -> decay time (ms0 -> LTP
	p_plast(11) = 16.8d0
	!tau_d -> decay time (ms) -> LTD
	p_plast(12) = 33.7d0
	!tau_y -> decay time (ms) -> triplet
	p_plast(13) = 100.0d0
	!increment - LTP
	p_plast(15) = 0.001d0
	!decrement - LTD
	p_plast(16) = 0.045d0
	!neurotransmitter-triggered LTP
	p_plast(17) = 0.0094d0
!==========================================================================================!
!======================== INHIBITORY PLASTICITY PARAMETERS ================================!
	!tau_I -> decay time (ms)
	p_plast(21) = 20.0d0
	!increment/decrement - LTP/LTD
	p_plast(23) = 0.00015d0
	!balance term - codependent
	p_plast(25) = 0.855d0
	!amplitude of balance difference
	p_plast(26) = 0.001d0

	p_plast(27) = 0.005d0
	p_plast(28) = 0.28d0
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
	!rectifying parameter for ISP
	p_plast(36) = 170.0d0
!==========================================================================================!
!======================== FILES WITH DATA FROM SIMULATION =================================!
	OPEN(100,file="folder_plots.txt")
	WRITE(100,"(A6)")folder
	CLOSE(100)

	CALL SYSTEM('mkdir '//folder)
	OPEN(1,file=folder//'/data01.dat')
	OPEN(2,file=folder//'/data02.dat')
	OPEN(3,file=folder//'/data03.dat')
	OPEN(4,file=folder//'/data04.dat')
	OPEN(5,file=folder//'/data05.dat')
	OPEN(6,file=folder//'/data06.dat')
	OPEN(7,file=folder//'/data07.dat')

	CALL SYSTEM('mkdir '//folder//'/code')
	CALL SYSTEM('cp *f90 '//folder//'/code/')
	CALL SYSTEM('cp subroutines/*f90 '//folder//'/code/')
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
