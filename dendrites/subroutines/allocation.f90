!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                           ALLOCATION OF ARRAY SIZES                        !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE

	ALLOCATE(msynw(ne_input+ni_input),patt_time(n_pw),inp_patt(n_pw),z(ne_input+ni_input,10))
	ALLOCATE(spkt(ne_input+ni_input),spk(ne_input+ni_input))
	ALLOCATE(ypost(ne_input+ni_input),ypre(ne_input+ni_input))
	ALLOCATE(spkt_post2(ne_input+ni_input),spkt_pre(ne_input+ni_input))
	ALLOCATE(tmp_inp(ne_input+ni_input))
	ALLOCATE(y(n_branch,10),branch(ne_input+ni_input))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
