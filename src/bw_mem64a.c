/*
 * bw_mem64a.c - simple memory write bandwidth benchmark
 *
 * Usage: bw_mem64a [-P <parallelism>] [-W <warmup>] [-N <repetitions>] size what
 *        what: frd fwr rd16 wr16 rd32 wr32 rd64 wr64 frd_sse fwr_sse frd_avx fwr_avx
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
 * rd16 - 8 byte read, 16 byte stride
 * wr16 - 8 byte write, 16 byte stride
 * fwr - write every 8 byte word
 * frd - read every 8 byte word
 *
 * All tests do 512 byte chunks in a loop.
 */
void	init_overhead(iter_t iterations, void *cookie);
void	init_loop(iter_t iterations, void *cookie);
void	cleanup(iter_t iterations, void *cookie);

void	frd(iter_t iterations, void *cookie);
void	fwr(iter_t iterations, void *cookie);
void	rd16(iter_t iterations, void *cookie);
void	wr16(iter_t iterations, void *cookie);
void	rd32(iter_t iterations, void *cookie);
void	wr32(iter_t iterations, void *cookie);
void	rd64(iter_t iterations, void *cookie);
void	wr64(iter_t iterations, void *cookie);
void	frd_sse(iter_t iterations, void *cookie);
void	frd_ssep(iter_t iterations, void *cookie);
void	frd_ssen(iter_t iterations, void *cookie);
void	fwr_sse(iter_t iterations, void *cookie);
void	fwr_ssep(iter_t iterations, void *cookie);
void	fwr_ssen(iter_t iterations, void *cookie);
void	frd_avx(iter_t iterations, void *cookie);
void	fwr_avx(iter_t iterations, void *cookie);

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
	char	*usage = "[-P <parallelism>] [-W <warmup>] [-N <repetitions>] <size> what [conflict]\nwhat: rd wr fwr frd\n<size> must be larger than 512\n";

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
	if (state.nbytes < 512) { /* this is the number of bytes in the loop */
		lmbench_usage(ac, av, usage);
	}

	if (streq(av[optind+1], "frd")) {
		benchmp(init_loop, frd, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "fwr")) {
		benchmp(init_loop, fwr, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rd16")) {
		benchmp(init_loop, rd16, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "wr16")) {
		benchmp(init_loop, wr16, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rd32")) {
		benchmp(init_loop, rd32, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "wr32")) {
		benchmp(init_loop, wr32, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "rd64")) {
		benchmp(init_loop, rd64, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "wr64")) {
		benchmp(init_loop, wr64, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "frd_sse")) {
		benchmp(init_loop, frd_sse, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "frd_ssep")) {
		benchmp(init_loop, frd_ssep, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "frd_ssen")) {
		benchmp(init_loop, frd_ssen, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "fwr_sse")) {
		benchmp(init_loop, fwr_sse, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "fwr_ssep")) {
		benchmp(init_loop, fwr_ssep, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "fwr_ssen")) {
		benchmp(init_loop, fwr_ssen, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "frd_avx")) {
		benchmp(init_loop, frd_avx, cleanup, 0, parallel,
			warmup, repetitions, &state);
	} else if (streq(av[optind+1], "fwr_avx")) {
		benchmp(init_loop, fwr_avx, cleanup, 0, parallel,
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

#define DOIT_2(START, STEP)					\
	DOIT(START) DOIT(START + STEP)
#define DOIT_4(START, STEP)					\
	DOIT_2(START, STEP) DOIT_2(START + 2*STEP, STEP)
#define DOIT_8(START, STEP)					\
	DOIT_4(START, STEP) DOIT_4(START + 4*STEP, STEP)
#define DOIT_16(START, STEP)					\
	DOIT_8(START, STEP) DOIT_8(START + 8*STEP, STEP)
#define DOIT_32(START, STEP)					\
	DOIT_16(START, STEP) DOIT_16(START + 16*STEP, STEP)
#define DOIT_64(START, STEP)					\
	DOIT_32(START, STEP) DOIT_32(START + 32*STEP, STEP)

void
frd(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE val;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq " #off "(%0), %%rax\n\t"
		asm volatile(
			DOIT_64(0, 8)
			:
			: "r" (p)
			: "rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"ldr x0, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_64(0, 8)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
	use_int(val);
}
#undef	DOIT

void
fwr(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register volatile TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq %%rax, " #off "(%0)\n\t"
		asm volatile(
			"movq $1, %%rax\n\t"
			DOIT_64(0, 8)
			:
			: "r" (p)
			: "%rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"str x0, [%0, #" #off "]\n\t"
		asm volatile(
			"movz x0, #1\n\t"
			DOIT_64(0, 8)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
}
#undef	DOIT

void
rd16(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val = 0;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq " #off "(%0), %%rax\n\t"
		asm volatile(
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"ldr x0, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_32(0, 2)
#endif
		p +=  64;
	    }
	}
	use_int(val);
}
#undef	DOIT

void
wr16(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq %%rax, " #off "(%0)\n\t"
		asm volatile(
			"movq $1, %%rax\n\t"
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "%rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"str x0, [%0, #" #off "]\n\t"
		asm volatile(
			"movz x0, #1\n\t"
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_32(0, 2)
#endif
		p +=  64;
	    }
	}
}
#undef	DOIT

void
rd32(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq " #off "(%0), %%rax\n\t"
		asm volatile(
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"ldr x0, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_16(0, 4)
#endif
		p +=  64;
	    }
	}
	use_int(val);
}
#undef	DOIT

void
wr32(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq %%rax, " #off "(%0)\n\t"
		asm volatile(
			"movq $1, %%rax\n\t"
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "%rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"str x0, [%0, #" #off "]\n\t"
		asm volatile(
			"movz x0, #1\n\t"
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_16(0, 4)
#endif
		p +=  64;
	    }
	}
}
#undef	DOIT

void
rd64(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq " #off "(%0), %%rax\n\t"
		asm volatile(
			DOIT_8(0, 64)
			:
			: "r" (p)
			: "rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"ldr x0, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_8(0, 64)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_8(0, 8);
#endif
		p +=  64;
	    }
	}
	use_int(val);
}
#undef	DOIT

void
wr64(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off)	"movq %%rax, " #off "(%0)\n\t"
		asm volatile(
			"movq $1, %%rax\n\t"
			DOIT_8(0, 64)
			:
			: "r" (p)
			: "%rax", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"str x0, [%0, #" #off "]\n\t"
		asm volatile(
			"movz x0, #1\n\t"
			DOIT_8(0, 64)
			:
			: "r" (p)
			: "x0", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_8(0, 8);
#endif
		p +=  64;
	    }
	}
}
#undef	DOIT

void
frd_sse(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off) "movdqa " #off "(%0), %%xmm0\n\t"
		asm volatile(
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "xmm0", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"ldr q0, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "q0", "x1", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
	use_int(val);
}
#undef DOIT

void
frd_ssep(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__aarch64__)
#define DOIT(off)	"ldp x0, x1, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "x0", "x1", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
	use_int(val);
}
#undef DOIT

void
frd_ssen(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__aarch64__)
#define DOIT(off)	"ld1 {v0.16b}, [%0], #16\n\t"
		asm volatile(
			DOIT_32(0, 16)
			: "=r" (p)
			:
			: "v0", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_64(0, 1)
		p += 64;
#endif
	    }
	}
	use_int(val);
}
#undef DOIT

void
fwr_sse(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off) "movdqa %%xmm0, " #off "(%0)\n\t"
		asm volatile(
			"mov $1, %%rax\n\t"
			"movq %%rax, %%xmm0\n\t"
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "rax", "xmm0", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"str q0, [%0, #" #off "]\n\t"
		asm volatile(
			"movi v0.16b, #0x1\n\t"
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "q0", "x1", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
}
#undef DOIT

void
fwr_ssep(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__aarch64__)
#define DOIT(off)	"stp x0, x1, [%0, #" #off "]\n\t"
		asm volatile(
			"movz x0, #1\n\t"
			"movz x1, #1\n\t"
			DOIT_32(0, 16)
			:
			: "r" (p)
			: "x0", "x1", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
}
#undef DOIT

void
fwr_ssen(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__aarch64__)
#define DOIT(off)	"st1 {v0.16b}, [%0], #16\n\t"
		asm volatile(
			"movi v0.16b, #0x1\n\t"
			DOIT_32(0, 16)
			: "=r" (p)
			:
			: "v0", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_64(0, 1)
		p += 64;
#endif
	    }
	}
}
#undef DOIT

void
frd_avx(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;
	register TYPE val;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off) "vmovdqa " #off "(%0), %%ymm0\n\t"
		asm volatile(
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "xmm0", "memory"
			);
#elif defined(__aarch64__)
#define DOIT(off)	"ldp q0, q1, [%0, #" #off "]\n\t"
		asm volatile(
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "q0", "q1", "memory");
#else
#define	DOIT(i)	val = p[i];
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
	use_int(val);
}
#undef DOIT

void
fwr_avx(iter_t iterations, void *cookie)
{
	state_t *state = (state_t *) cookie;
	register TYPE *lastone = state->lastone;

	while (iterations-- > 0) {
	    register volatile TYPE *p = state->buf;
	    while (p <= lastone) {
#if defined(__x86_64)
#define DOIT(off) "vmovdqa %%ymm0, " #off "(%0)\n\t"
		asm volatile(
			"mov $1, %%rax\n\t"
			"movq %%rax, %%xmm0\n\t"
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "rax", "xmm0", "memory");
#elif defined(__aarch64__)
#define DOIT(off)	"stp q0, q1, [%0, #" #off "]\n\t"
		asm volatile(
			"movi v0.16b, #0x1\n\t"
			"movi v1.16b, #0x1\n\t"
			DOIT_16(0, 32)
			:
			: "r" (p)
			: "q0", "q1", "memory");
#else
#define	DOIT(i)	p[i] = 1;
		DOIT_64(0, 1)
#endif
		p += 64;
	    }
	}
}
#undef DOIT
