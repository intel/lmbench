/*
 * bw_mem64d.c - simple memory write bandwidth benchmark
 *
 * Usage: bw_mem64 [-P <parallelism>] [-W <warmup>] [-N <repetitions>] [-d <delay>] size what
 *        what: rd wr fwr frd
 *
 * Copyright (c) 2026 Huang Ying
 *
 * Distributed under the FSF GPL with additional restriction that results
 * may published only if
 * (1) the benchmark is unmodified, and
 * (2) the version in the sccsid below is included in the report.
 * Support for this development by Sun Microsystems is gratefully acknowledged.
 */

#include "bench.h"

#define TYPE    int64_t

/*
 * rd - 8 byte read, 16 byte stride
 * wr - 8 byte write, 16 byte stride
 * fwr - write every 8 byte word
 * frd - read every 8 byte word
 *
 * All tests do 512 byte chunks in a loop.
 */
void	rd(iter_t iterations, void *cookie);
void	wr(iter_t iterations, void *cookie);
void	fwr(iter_t iterations, void *cookie);
void	frd(iter_t iterations, void *cookie);
void	init_overhead(iter_t iterations, void *cookie);
void	init_loop(iter_t iterations, void *cookie);
void	cleanup(iter_t iterations, void *cookie);

typedef struct _state {
	double	overhead;
	size_t	nbytes;
	int	aligned;
	TYPE	*buf;
	TYPE	*lastone;
	size_t	N;
} state_t;

static int delay_nr_nop;

void	adjusted_bandwidth(uint64 t, uint64 b, uint64 iter, double ovrhd);

int
main(int ac, char **av)
{
	int	parallel = 1;
	int	warmup = 0;
	int	repetitions = TRIES;
	size_t	nbytes;
	state_t	state;
	int	c;
	char	*usage = "[-P <parallelism>] [-W <warmup>] [-N <repetitions>] [-d <delay>] <size> what [conflict]\nwhat: rd wr fwr frd\n<size> must be larger than 512\n";

	state.overhead = 0;

	while (( c = getopt(ac, av, "P:W:N:d:")) != EOF) {
		switch(c) {
		case 'P':
			parallel = atoi(optarg);
			if (parallel <= 0) lmbench_usage(ac, av, usage);
			break;
		case 'W':
			warmup = atoi(optarg);
			break;
		case 'N':
			repetitions = atoi(optarg);
			break;
		case 'd':
			delay_nr_nop = atoi(optarg);
			break;
		default:
			lmbench_usage(ac, av, usage);
			break;
		}
	}

	/* should have two, possibly three [indicates align] arguments left */
	state.aligned = 0;
	if (optind + 3 == ac) {
		state.aligned = 1;
	} else if (optind + 2 != ac) {
		lmbench_usage(ac, av, usage);
	}

	nbytes = state.nbytes = bytes(av[optind]);
	if (state.nbytes < 512) { /* this is the number of bytes in the loop */
		lmbench_usage(ac, av, usage);
	}

	if (streq(av[optind+1], "rd")) {
		benchmp(init_loop, rd, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "wr")) {
		benchmp(init_loop, wr, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "frd")) {
		benchmp(init_loop, frd, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "fwr")) {
		benchmp(init_loop, fwr, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else {
		lmbench_usage(ac, av, usage);
	}
	adjusted_bandwidth(gettime(), nbytes,
			   get_n() * parallel, state.overhead);
	return(0);
}

void
init_overhead(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
}

void
init_loop(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;

	if (iterations) return;

        state->buf = (TYPE *)valloc(state->nbytes);
	state->lastone = (TYPE*)state->buf - 1;
	state->lastone = (TYPE*)((char *)state->buf + state->nbytes - 512);
	state->N = state->nbytes;

	if (!state->buf) {
		perror("malloc");
		exit(1);
	}
	bzero((void*)state->buf, state->nbytes);
}

void
cleanup(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;

	if (iterations) return;

	free(state->buf);
}

static inline void delay(int nr_nop)
{
	for (register int j = 0; j < nr_nop; j++)
		asm volatile("nop");
}

void
rd(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE sum = 0;
	int nr_nop = delay_nr_nop;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)     sum += p[i]; delay(nr_nop);
		DOIT(0) DOIT(2) DOIT(4) DOIT(6) DOIT(8) DOIT(10) DOIT(12)
		DOIT(14) DOIT(16) DOIT(18) DOIT(20) DOIT(22) DOIT(24) DOIT(26)
		DOIT(28) DOIT(30) DOIT(32) DOIT(34) DOIT(36) DOIT(38) DOIT(40)
		DOIT(42) DOIT(44) DOIT(46) DOIT(48) DOIT(50) DOIT(52) DOIT(54)
		DOIT(56) DOIT(58) DOIT(60)
		DOIT(62)
		p += 64;
	    }
	}
	use_int(sum);
}
#undef	DOIT

void
wr(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	int nr_nop = delay_nr_nop;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)	p[i] = 1; delay(nr_nop);
		DOIT(0) DOIT(2) DOIT(4) DOIT(6) DOIT(8) DOIT(10) DOIT(12)
		DOIT(14) DOIT(16) DOIT(18) DOIT(20) DOIT(22) DOIT(24) DOIT(26)
		DOIT(28) DOIT(30) DOIT(32) DOIT(34) DOIT(36) DOIT(38) DOIT(40)
		DOIT(42) DOIT(44) DOIT(46) DOIT(48) DOIT(50) DOIT(52) DOIT(54)
		DOIT(56) DOIT(58) DOIT(60) DOIT(62);
		p +=  64;
	    }
	}
}
#undef	DOIT

void
fwr(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	TYPE* p_save = NULL;
	int nr_nop = delay_nr_nop;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)	p[i] = 1; delay(nr_nop);
		DOIT(0) DOIT(1) DOIT(2) DOIT(3) DOIT(4) DOIT(5) DOIT(6)
		DOIT(7) DOIT(8) DOIT(9) DOIT(10) DOIT(11) DOIT(12)
		DOIT(13) DOIT(14) DOIT(15) DOIT(16) DOIT(17) DOIT(18)
		DOIT(19) DOIT(20) DOIT(21) DOIT(22) DOIT(23) DOIT(24)
		DOIT(25) DOIT(26) DOIT(27) DOIT(28) DOIT(29) DOIT(30)
		DOIT(31) DOIT(32) DOIT(33) DOIT(34) DOIT(35) DOIT(36)
		DOIT(37) DOIT(38) DOIT(39) DOIT(40) DOIT(41) DOIT(42)
		DOIT(43) DOIT(44) DOIT(45) DOIT(46) DOIT(47) DOIT(48)
		DOIT(49) DOIT(50) DOIT(51) DOIT(52) DOIT(53) DOIT(54)
		DOIT(55) DOIT(56) DOIT(57) DOIT(58) DOIT(59) DOIT(60)
		DOIT(61) DOIT(62) DOIT(63)
		p += 64;
	    }
	    p_save = p;
	}
	use_pointer(p_save);
}
#undef	DOIT

void
frd(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE sum = 0;
	register TYPE *lastone = state->lastone;
	int nr_nop = delay_nr_nop;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)	sum += p[i]; delay(nr_nop);
		DOIT(0) DOIT(1) DOIT(2) DOIT(3) DOIT(4) DOIT(5) DOIT(6)
		DOIT(7) DOIT(8) DOIT(9) DOIT(10) DOIT(11) DOIT(12)
		DOIT(13) DOIT(14) DOIT(15) DOIT(16) DOIT(17) DOIT(18)
		DOIT(19) DOIT(20) DOIT(21) DOIT(22) DOIT(23) DOIT(24)
		DOIT(25) DOIT(26) DOIT(27) DOIT(28) DOIT(29) DOIT(30)
		DOIT(31) DOIT(32) DOIT(33) DOIT(34) DOIT(35) DOIT(36)
		DOIT(37) DOIT(38) DOIT(39) DOIT(40) DOIT(41) DOIT(42)
		DOIT(43) DOIT(44) DOIT(45) DOIT(46) DOIT(47) DOIT(48)
		DOIT(49) DOIT(50) DOIT(51) DOIT(52) DOIT(53) DOIT(54)
		DOIT(55) DOIT(56) DOIT(57) DOIT(58) DOIT(59) DOIT(60)
		DOIT(61) DOIT(62) DOIT(63)
		p += 64;
	    }
	}
	use_int(sum);
}
#undef	DOIT

/*
 * Almost like bandwidth() in lib_timing.c, but we need to adjust
 * bandwidth based upon loop overhead.
 */
void adjusted_bandwidth(uint64 time, uint64 bytes, uint64 iter, double overhd)
{
#define MB	(1000. * 1000.)
	extern FILE *ftiming;
	double secs = ((double)time / (double)iter - overhd) / 1000000.0;
	double mb;

        mb = bytes / MB;

	if (secs <= 0.)
		return;

        if (!ftiming) ftiming = stderr;
	if (mb < 1.) {
		(void) fprintf(ftiming, "%.6f ", mb);
	} else {
		(void) fprintf(ftiming, "%.2f ", mb);
	}
	if (mb / secs < 1.) {
		(void) fprintf(ftiming, "%.6f\n", mb/secs);
	} else {
		(void) fprintf(ftiming, "%.2f\n", mb/secs);
	}
}
