!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                           ALLOCATION OF ARRAY SIZES                        !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	USE IFPORT
	IMPLICIT NONE

	ALLOCATE(msynw(ne_input+ni_input),patt_time(n_pw),inp_patt(n_pw))
	ALLOCATE(spkt(ne_input+ni_input),spk(ne_input+ni_input),spkr(ne_input+ni_input))
	ALLOCATE(ypost(ne_input+ni_input),ypre(ne_input+ni_input))
	ALLOCATE(spkt_post2(ne_input+ni_input),spkt_pre(ne_input+ni_input))
	ALLOCATE(tmp_inp(ne_input+ni_input))
	ALLOCATE(tmp_e(n_pw),tmp_i(n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
