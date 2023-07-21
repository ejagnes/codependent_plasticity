!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	INCLUDE 'subroutines/modules.f90'			!modules
	INCLUDE 'config.f90'					!configuration - parameters
	INCLUDE 'initial_conditions.f90'			!values for initial conditions
	INCLUDE 'subroutines/LIF.f90'				!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/plasticity_codependent_e.f90'	!codependent excitatory plasticity implementation
	INCLUDE 'subroutines/input.f90'				!inputs and protocol spike patterns
	INCLUDE 'subroutines/simulations.f90'			!simulation protocols
!==========================================================================================!
	PROGRAM PAIRING_PROTOCOL_VOLTAGE
	USE PARAMETERS
	USE VARIABLES
	USE IFPORT
	IMPLICIT NONE
	INTEGER 		::	t,k,k0,k1,k2,k3,tot_sweep
	REAL*8			::	spkcount,spkcount2,v_inf
	LOGICAL			::	gate_stop
	REAL*8			::	min_delta_w,max_delta_w,output(100000,2),u_0,u_f,min_delta_w_0,max_delta_w_0
!======================== initialising subroutines ========================================!
	CALL config()						!call config file with parameters
!==========================================================================================!
	output = 0.0d0
!---------------------- LOOP OVER DIFFERENT INITIAL WEIGHT --------------------------------!
	p_con(5) = p_sim(4)				!initial weight for loop
	k3 = 0
	DO k0 = 1,p_sim_int(1)
		p_con(5) = p_con(5) + p_sim(3)		!increment for initial weight for loop
		!------------------- LOOP OVER DIFFERENT CURRENT CLAMP VALUES -----------------------------!
		DO k1 = 1,p_sim_int(2)
			inp_clamp = inp_clamp + 10.0d0**(0.12d0*DBLE(k1-2)-2.0d0)	!increase in current clamp (mV)
			IF(k1.EQ.1) inp_clamp = 0.0d0					!first iteration with zero current
			!------------------- LOOP OVER DIFFERENT bAP AMPLITUDES -----------------------------------!
			k = 0								!dummy index starting at 0
			gate_stop = .TRUE.						!logical variable to stop loop
			DO WHILE(gate_stop)
				k = k + 1						!increment of dummy index
				WRITE(*,*)k0,k1,k
				v_inf = 10.0d0**(0.04d0*DBLE(k-1)-1.0d0)		!calculating u_{inf} for bAP amplitude
				ca_amp = v_inf/(p_ne(12)-p_ne(2)-v_inf)			!calculating bAP amplitude
				ca_amp = ca_amp/(50.0d0*0.05d0)				!normalising bAP amplitude
				IF(k.EQ.1) ca_amp = 0.0d0				!no bAP during first iteration
				CALL initial_conditions()				!subroutine with initial conditions
				CALL simulation_voltage_stdp()				!protocol simulation
				WRITE(1,"(5E)")p_con(5),inp_clamp,ca_amp,x(13),msynw
				IF(x(13).GT.7.0d0+p_ne(2)) THEN				!test for depolarisation levels
					gate_stop = .FALSE.				!high depolarisations skip the current iteration
				ELSE
					k3 = k3 + 1					!increment for dummy index
					output(k3,1) = x(13)-p_ne(2)			!depolarisation
					output(k3,2) = 100.0d0*(msynw/p_con(5))		!change in weight
					WRITE(2,"(2E)")x(13)-p_ne(2),100.0d0*(msynw/p_con(5)) !output
				END IF
			END DO
			!------------------------------------------------------------------------------------------!
		END DO
		!------------------------------------------------------------------------------------------!
	END DO
	tot_sweep = k3
!------------------------------------------------------------------------------------------!

!======================== DATA OUTPUT FOR PLOTTING ========================================!
	min_delta_w_0 = 0.0d0/0.0d0
	max_delta_w_0 = 0.0d0/0.0d0
	gate_stop = .TRUE.
	k = 0
	DO WHILE(gate_stop)
		k = k + 1
		u_0 = 10.0d0**(0.05d0*DBLE(k-1)-1.55d0)
		u_f = 10.0d0**(0.05d0*DBLE(k)-1.55d0)
		IF(u_f.GT.7.0d0) gate_stop = .FALSE.
		min_delta_w = 100000.0d0
		max_delta_w = 0.0d0
		DO k3 = 1,tot_sweep
			IF((output(k3,1).GE.u_0).AND.(output(k3,1).LT.u_f)) THEN
				IF(output(k3,2).LE.min_delta_w) min_delta_w = output(k3,2)
				IF(output(k3,2).GE.max_delta_w) max_delta_w = output(k3,2)
			END IF
		END DO
		IF(min_delta_w.GT.9999.0d0) min_delta_w = min_delta_w_0
		IF(max_delta_w.LT.0.00001d0) max_delta_w = max_delta_w_0
		WRITE(3,*)0.5d0*(u_0+u_f),min_delta_w,max_delta_w

		min_delta_w_0 = min_delta_w
		max_delta_w_0 = max_delta_w
	END DO
!==========================================================================================!		
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
