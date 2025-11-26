/*
 * bw_mem64p.c - simple memory write bandwidth benchmark with various read:write proportion
 *
 * Usage: bw_mem64p [-P <parallelism>] [-W <warmup>] [-N <repetitions>] size what
 *        what: rw21 rw31 rw41 rw51
 *
 * Copyright (c) 2025 Huang Ying
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
 * rw21 - 8 byte read/write, 64 byte stride, read/write proportion 2:1
 * rw31 - 8 byte read/write, 64 byte stride, read/write proportion 3:1
 * rw41 - 8 byte read/write, 64 byte stride, read/write proportion 4:1
 * rw51 - 8 byte read/write, 64 byte stride, read/write proportion 5:1
 * rw61 - 8 byte read/write, 64 byte stride, read/write proportion 6:1
 *
 * All tests do 3840 byte chunks in a loop.
 */
void	rw21(iter_t iterations, void *cookie);
void	rw31(iter_t iterations, void *cookie);
void	rw41(iter_t iterations, void *cookie);
void	rw51(iter_t iterations, void *cookie);
void	rw61(iter_t iterations, void *cookie);

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
	char	*usage = "[-P <parallelism>] [-W <warmup>] [-N <repetitions>] <size> what [conflict]\nwhat: rw21 rw31 rw41 rw51\n<size> must be larger than 3840\n";

	state.overhead = 0;

	while (( c = getopt(ac, av, "P:W:N:")) != EOF) {
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
	if (state.nbytes < 3840) { /* this is the number of bytes in the loop */
		lmbench_usage(ac, av, usage);
	}

	if (streq(av[optind+1], "rw21")) {
		benchmp(init_loop, rw21, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rw31")) {
		benchmp(init_loop, rw31, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rw41")) {
		benchmp(init_loop, rw41, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rw51")) {
		benchmp(init_loop, rw51, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rw61")) {
		benchmp(init_loop, rw61, cleanup, 0, parallel,
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
	state->lastone = (TYPE*)((char *)state->buf + state->nbytes - 3840);
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

#define DOIT_2(STEP)					\
	DOIT(0) DOIT(STEP)				\
	p += 2*STEP;
#define DOIT_5(STEP)					\
	DOIT(0) DOIT(STEP) DOIT(2*STEP)			\
	DOIT(3*STEP) DOIT(4*STEP) p += 5*STEP;
#define DOIT_10(STEP)						\
	DOIT_5(STEP) DOIT_5(STEP)
#define DOIT_20(STEP)						\
	DOIT_10(STEP) DOIT_10(STEP)

void
rw21(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE sum = 0;
	TYPE* p_save = NULL;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)				\
		    sum += p[i];		\
		    p[i + 8] = 1;
		DOIT_20(16)
		DOIT_10(16)
	    }
	}
	use_int(sum);
}
#undef	DOIT

void
rw31(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE sum = 0;
	TYPE* p_save = NULL;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)					\
		    sum += p[i] + p[i + 8];		\
		    p[i + 16] = 1;
		DOIT_10(24)
		DOIT_10(24)
	    }
	}
	use_int(sum);
}
#undef	DOIT

void
rw41(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE sum = 0;
	TYPE* p_save = NULL;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)					\
		    sum += p[i] + p[i+8] + p[i+16];	\
		    p[i + 24] = 1;
		DOIT_10(32)
		DOIT_5(32)
	    }
	}
	use_int(sum);
}
#undef	DOIT

void
rw51(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE sum = 0;
	TYPE* p_save = NULL;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)					\
		    sum += p[i] + p[i+8] + p[i+16] +	\
			   p[i+24];			\
		    p[i+32] = 1;
		DOIT_10(40)
		DOIT_2(40)
	    }
	}
	use_int(sum);
}
#undef	DOIT

void
rw61(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE sum = 0;
	TYPE* p_save = NULL;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#define	DOIT(i)					\
		    sum += p[i] + p[i+8] + p[i+16] +	\
			   p[i+24] + p[i+32];		\
		    p[i+40] = 1;
		DOIT_10(48)
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
