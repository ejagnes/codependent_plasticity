!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                           ALLOCATION OF ARRAY SIZES                        !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE

	ALLOCATE(msynw(ne_input+ni_input))
	ALLOCATE(spkt(ne_input+ni_input),spk(ne_input+ni_input))
	ALLOCATE(ypost(ne_input+ni_input),ypre(ne_input+ni_input))
	ALLOCATE(spkt_post2(ne_input+ni_input),spkt_pre(ne_input+ni_input))
	ALLOCATE(exc_pre(ne_input+ni_input),exc_pre_cond(ne_input+ni_input))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
