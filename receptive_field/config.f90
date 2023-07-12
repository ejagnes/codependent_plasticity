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
!======================== PRE-SYNAPTIC NEURONS (PATHWAYS)==================================!
	!number of pathways
	n_pw = 8
	!number of excitatory neurons per pathway
	ne_pw = 100
	!number of inhibitory neurons per pathway
	ni_pw = 25
	!total number of pre-synaptic neurons
	ne_input = n_pw*ne_pw
	ni_input = n_pw*ni_pw
!==========================================================================================!
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step (ms)
	dt = 0.1d0
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))
!==========================================================================================!
!================================ NEURON PARAMETERS =======================================!
	!neuron membrane potential time constant, tau (ms)
	pr(1) = 30.0d0
!	pr(1) = -1.0d0*dt/pr(1)
	!resting membrane potential (mV)
	pr(2) = -65.0d0
	!refractory period excitatory (ms)
	pr(3) = 5.0d0
	!spiking threshold (mV)
	pr(4) = -50.0d0
	!reversal potential for adaptation (mV)
	pr(6) = -80.0d0
	!adaptation current amplitude (1)
	pr(7) = 5.0d0
	!reset potential (mV)
	pr(9) = -60.0d0
	!update rate for activity trace (ms)
	pr(10) = 100.0d0
	pr(10) = EXP(-1.0d0*dt/pr(10))
!==========================================================================================!
!========================== SYNAPSE PARAMETERS ============================================!
	!reversal potential - excitatory - AMPA (mV) -> not used
	pr(31) = 0.0d0
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
	pr(76) = 2.0d0
	pr(76) = (dt*pr(76))/1000.0d0
	!burst firing-rate -> excitatory neurons (Hz)
	pr(77) = 50.0d0
	pr(77) = (dt*pr(77))/1000.0d0
	!burst firing-rate -> inhibitory neurons (Hz)
	pr(78) = 2.0d0!100.0d0
	pr(78) = (dt*pr(78))/1000.0d0

	!tau for OU process (ms)
	pr(80) = 50.0d0
	pr(80) = 0.1d0*pr(80)
	!decay time 1
	pr(81) = DEXP(-dt/pr(80))
	!amplitude (Hz)
	pr(82) = 5.0d0
!==========================================================================================!
!=============================== CONNECTION WEIGHTS =======================================!
	!synaptic weight - excitatory -> postsynaptic neuron (g_leak)
	pr(91) = 0.12d0
	!synaptic weight - inhibitory -> postsynaptic neuron (g_leak)
	pr(93) = 0.9d0
!==========================================================================================!

!!!!!!!!!!!!!!!!!!!!!!!!! PARAMETERS FOR THE PLASTICITY MODEL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!======================= MAXIMUM/MININUM WEIGHTS FOR SYNAPSES =============================!
	!max synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(1) = 1.0d0
	!max synapse weight - inhibitory -> postsynaptic neuron (g_leak)
	p_plast(3) = 10.0d0
	!min synapse weight - excitatory -> postsynaptic neuron (g_leak)
	p_plast(5) = 0.0001d0
	!min synapse weight - inhibitory -> postsynaptic neuron (g_leak)
	p_plast(7) = 0.001d0
!==========================================================================================!
!======================== EXCITATORY PLASTICITY PARAMETERS ================================!
	!tau_p -> decay time (ms0 -> LTP
	p_plast(11) = 16.8d0
	!tau_d -> decay time (ms) -> LTD
	p_plast(12) = 33.7d0
	!increment - LTP
	p_plast(15) = 0.0005d0/3.0d0
	!decrement - LTD
	p_plast(16) = 1000.0d0*p_plast(15)
	!heterosynaptic LTD
	p_plast(17) = 0.00002d0*p_plast(15)
	!decay term for inhibitory control (mV)
	p_plast(18) = 150.0d0
	!power of decay term
	p_plast(19) = 3.0d0
!==========================================================================================!
!======================== INHIBITORY PLASTICITY PARAMETERS ================================!
	!tau_I -> decay time (ms)
	p_plast(21) = 20.0d0
	!increment/decrement - LTP/LTD
	p_plast(23) = 0.00015d0
	!balance term - codependent
	p_plast(25) = 0.93d0
	!amplitude of balance difference
	p_plast(26) = 0.00001d0
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
!======================== FIRING RATE OF INHIBITORY POPULATIONS ===========================!
	!function of control firing-rate
	pr(205) = 2.0d0
!==========================================================================================!
!======================== FILES WITH DATA FROM SIMULATION =================================!
	OPEN(100,file="plots_folder.txt")
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
	OPEN(8,file=folder//'/data08.dat')
	OPEN(9,file=folder//'/data09.dat')
	OPEN(10,file=folder//'/data10.dat')
	OPEN(11,file=folder//'/data11.dat')
	OPEN(12,file=folder//'/data12.dat')

	CALL SYSTEM('mkdir '//folder//'/code')
	CALL SYSTEM('cp *f90 '//folder//'/code/')
	CALL SYSTEM('cp subroutines/*f90 '//folder//'/code/')
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        VARIABLES                                                           !!!!!!!!
!!!!!!!!        x(1)  -> membrane potential (mV)                                    !!!!!!!!
!!!!!!!!        x(2)  -> AMPA conductance (g_leak)                                  !!!!!!!!
!!!!!!!!        x(3)  -> GABA_A conductance (g_leak)                                !!!!!!!!
!!!!!!!!        x(11) -> learning rate for anti-Hebbian plasticity                  !!!!!!!!
!!!!!!!!        x(12) -> trace for scaling plasticity                               !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        msynw  -> synaptic weights                                          !!!!!!!!
!!!!!!!!        msynw0 -> initial synaptic weights                                  !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        patt_time -> OU variable                                            !!!!!!!!
!!!!!!!!        inp_patt -> rate envelope for inh. Poisson process                  !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        ypre1,ypre2 -> presynaptic traces for plasticity                    !!!!!!!!
!!!!!!!!        ypost1,ypost2 -> postsynaptic traces for plasticity                 !!!!!!!!
!!!!!!!!        spkt_pre1,spkt_pre2 -> time of last update of presynaptic traces    !!!!!!!!
!!!!!!!!        spkt_post1,spkt_post2 -> time of last update of postsynaptic traces !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

