/*
 * lat_mem_pingpong.c - measure cache pingpong latency
 *
 * usage: lat_mem_pingpong [-P <parallelism>] [-N <repetitions>] <op>
 *
 * Copyright (c) 2025 Huang Ying
 *
 * Distributed under the FSF GPL with additional restriction that results
 * may published only if:
 * (1) the benchmark is unmodified, and
 * (2) the version in the sccsid below is included in the report.
 */

#include "bench.h"

#define PRESET_ITERATIONS	100000
#define PP_BUF_LEN		(4096 * 16)

void init_loop(iter_t iterations, void *cookie);
void run_pingpong(int parallel, int repetitions, benchmp_f op);

void pingpong_cas(iter_t iterations, void *cookie);
void pingpong_rw(iter_t iterations, void *cookie);

struct pp_state {
	unsigned long me;
	unsigned long next;
	unsigned long *buf;
};

int
main(int ac, char **av)
{
	int	c;
	int	parallel = 1;
	int	repetitions = TRIES;
	char   *usage = "[-P <parallelism>] [-N <repetitions>] <op>\n";
	char   *op;

	while (( c = getopt(ac, av, "P:N:")) != EOF) {
		switch(c) {
		case 'P':
			parallel = atoi(optarg);
			if (parallel <= 0) lmbench_usage(ac, av, usage);
			break;
		case 'N':
			repetitions = atoi(optarg);
			break;
		default:
			lmbench_usage(ac, av, usage);
			break;
		}
	}
	if (optind == ac)
		lmbench_usage(ac, av, usage);
	op = av[optind];
	if (streq(op, "cas"))
		run_pingpong(parallel, repetitions, pingpong_cas);
	else if (streq(op, "rw"))
		run_pingpong(parallel, repetitions, pingpong_rw);
	else
		lmbench_usage(ac, av, usage);

	return 0;
}

void
init_loop(iter_t iterations, void *cookie)
{
	struct pp_state *state = (struct pp_state *) cookie;

	if (iterations) return;

	state->me = benchmp_childid();
	state->next = state->me + 1;
	if (state->next >= benchmp_parallel())
		state->next = 0;
}

void
cleanup(iter_t iterations, void *cookie)
{
	if (iterations) return;
}

void
pingpong_cas(iter_t iterations, void *cookie)
{
	struct pp_state* state = (struct pp_state*)cookie;
	register unsigned long *p = state->buf;
	unsigned long me = state->me;
	unsigned long next = state->next;

	/*
	 * All children must run same iterations, but it is stable
	 * only in timing stage, not in warmup, cooldown, etc. stage.
	 */
	if (!benchmp_timing())
		return;

	while (iterations > 0) {
		unsigned long tme = me;
		if (__atomic_compare_exchange_n(p, &tme, next, 0,
						__ATOMIC_RELAXED, __ATOMIC_RELAXED))
			iterations--;
		asm volatile("nop" ::: "memory");
	}
}

void
pingpong_rw(iter_t iterations, void *cookie)
{
	struct pp_state* state = (struct pp_state*)cookie;
	register volatile unsigned long *p = state->buf;
	register unsigned long me = state->me;
	register unsigned long next = state->next;

	/*
	 * All children must run same iterations, but it is stable
	 * only in timing stage, not in warmup, cooldown, etc. stage.
	 */
	if (!benchmp_timing())
		return;

	while (iterations > 0) {
		if (*p == me) {
			*p = next;
			iterations--;
		}
		asm volatile("nop" ::: "memory");
	}
}

void
run_pingpong(int parallel, int repetitions, benchmp_f op)
{
	double result;
	struct pp_state state;
	iter_t iterations;
	void *buf;

	buf = mmap(NULL, PP_BUF_LEN, PROT_READ | PROT_WRITE,
		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
	if (buf == MAP_FAILED) {
		perror("mmap: ");
		exit(1);
	}
	bzero(buf, PP_BUF_LEN);
	state.buf = buf;

	iterations = get_iterations_setup();
	if (!iterations) {
		iterations = PRESET_ITERATIONS;
	} else if (iterations < 2) {
		fprintf(stderr, "too small iterations: %d from environ, at least 2\n",
			iterations);
		exit(1);
	}

	/*
	 * No warmup, preset iterations (no calibration), because all
	 * worker process must run exactly same number of operations
	 * to avoid deaklock.
	 */
	__benchmp(init_loop, op, cleanup, 0, parallel,
		  0, repetitions, 0, iterations, &state);

	/* We want to get to nanoseconds / pingpong. */
	save_minimum();
	result = (1000. * (double)gettime()) / (double)get_n() / parallel;
	fprintf(stderr, "%.3f\n", result);
}
