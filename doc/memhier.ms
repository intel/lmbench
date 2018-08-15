.\" This document is GNU groff -mgs -t -p -R -s
.\" It will not print with normal troffs, it uses groff features, in particular,
.\" long names for registers & strings.
.\" Deal with it and use groff - it makes things portable.
.\"
.\" $X$ xroff -mgs -t -p -R -s $file
.\" $tty$ groff -mgs -t -p -R -s $file | colcrt - | more
.\" $lpr$ groff -mgs -t -p -R -s $file > ${file}.lpr
.VARPS
.\" Define a page top that looks cool
.\" HELLO CARL!  To turn this off, s/PT/oldPT/
.de PT
.tl '\fBDRAFT\fP'\\*(DY'\fBDRAFT\fP'
..
.de lmPT
.if \\n%>1 \{\
.	sp -.1i
.	ps 14
.	ft 3
.	nr big 24
.	nr space \\w'XXX'
.	nr titlewid \\w'\\*[title]'
.	nr barwid (\\n[LL]-(\\n[titlewid]+(2*\\n[space])))/2
.	ds ln \\l'\\n[barwid]u'\\h'-\\n[barwid]u'\v'-.25'
.	ds bar \\s(\\n[big]\\*(ln\\*(ln\\*(ln\\*(ln\\*(ln\v'1.25'\\h'\\n[barwid]u'\\s0
.	ce 1
\\*[bar]\h'\\n[space]u'\v'-.15'\\*[title]\v'.15'\h'\\n[space]u'\\*[bar]
.	ps
.	sp -.70
.	ps 12
\\l'\\n[LL]u'
.	ft
.	ps
.\}
..
.\" Define a page bottom that looks cool
.\" HELLO CARL!  To turn this off, s/BT/oldBT/
.de BT
.tl '\fBDRAFT\fP'Page %'\fBDRAFT\fP'
..
.de lmBT
.	ps 9
\v'-1'\\l'\\n(LLu'
.	sp -1
.	tl '\(co 2001 \\*[author]'\\*(DY'%'
.	ps
..
.de SP
.	if t .sp .5
.	if n .sp 1
..
.de BU
.	SP
.	ne 2
\(bu\ 
.	if \\n[.$] \fB\\$1\fP\\$2
..
.nr FIGURE 0
.nr TABLE 0
.nr SMALL .25i
.de TSTART
.	KF
.	if \\n[.$] \s(24\\l'\\n[pg@colw]u'\s0
.	ps -1
.	vs -1
..
.de TEND
.	ps +1
.	vs +1
.	if \\n[.$]=2 \{\
.	sp -.5
\s(24\\l'\\n[pg@colw]u'\s0 \}
.	sp .25
.	nr TABLE \\n[TABLE]+1
.	ce 1
\fBTable \\n[TABLE].\ \ \\$1\fP
.	SP
.	KE
..
.de FEND
.	ps +1
.	vs +1
.	if \\n[.$]=2 \{\
.	sp -.5
\s(24\\l'\\n[pg@colw]u'\s0 \}
.	sp .25
.	nr FIGURE \\n[FIGURE]+1
.	ce 1
\fBFigure \\n[FIGURE].\ \ \\$1\fP
.	SP
.	KE
..
.\" Configuration
.nr PI 3n
.nr HM 1i
.nr FM 1i
.nr PO 1i
.if t .po 1i
.nr LL 6.5i
.if n .nr PO 0i
.if n .nr LL 7.5i
.nr PS 10
.nr VS \n(PS+1
.ds title Micro-architecture analysis
.ds author Carl Staelin
.ds lmbench \f(CWlmbench\fP
.ds lmbench1 \f(CWlmbench1\fP
.ds lmbench2 \f(CWlmbench2\fP
.ds lmbench3 \f(CWlmbench3\fP
.ds bcopy \f(CWbcopy\fP
.ds connect \f(CWconnect\fP
.ds execlp  \f(CWexeclp\fP
.ds exit \f(CWexit\fP
.ds fork \f(CWfork\fP
.ds gcc \f(CWgcc\fP
.ds getpid \f(CWgetpid\fP
.ds getpid \f(CWgetpid\fP
.ds gettimeofday \f(CWgettimeofday\fP
.ds kill \f(CWkill\fP
.ds lat_mem_rd  \f(CWlat_mem_rd\fP
.ds lat_ops  \f(CWlat_ops\fP
.ds lmdd  \f(CWlmdd\fP
.ds memmove \f(CWmemmove\fP
.ds mmap \f(CWmmap\fP
.ds par_mem  \f(CWpar_mem\fP
.ds par_ops  \f(CWpar_ops\fP
.ds popen  \f(CWpopen\fP
.ds read \f(CWread\fP
.ds stream \f(CWstream\fP
.ds system  \f(CWsystem\fP
.ds uiomove \f(CWuiomove\fP
.ds write \f(CWwrite\fP
.ds yield  \f(CWyield\fP
.\" References stuff
.de RN  \"Reference Name: .RN $1 -- prints the reference prettily
.\" [\s-2\\$1\s+2]\\$2
[\s-1\\$1\s0]\\$2
..
.\" .R1
.\" sort A+DT
.\" database references
.\" label-in-text
.\" label A.nD.y-2
.\" bracket-label \*([. \*(.] ", "
.\" .R2
.EQ
delim $$
.EN
.TL
\s(14Micro-architecture analysis\s0
.AU
\s+2\fR\*[author]\fP\s0
.AI
\fI\s+2Hewlett-Packard Laboratories Israel\s0\fP
.SP
.AB
\*[lmbench] version 3 includes a number of new micro-benchmarks 
that analyze specific aspects of system micro-architecture,
such as instruction level parallelism, the cache hierarchy and TLB. 
.LP
There are new benchmarks to measure instruction level
parallelism, such as the effectiveness of overlapped
memory accesses or arithmetic operations.
There are other new benchmarks to measure various
aspects of the architecture, such as the cache line
size(s), TLB size, and latency costs for basic 
arithmetic operations.
\*[lmbench] can identify the number of caches, and the size, 
line size, and available parallelism for each cache.  
It can also measure the effective TLB size.
.AE
.if t .MC 3.05i
.NH 1
Introduction
.LP
\*[lmbench] version 3 includes a variety of new benchmarks
designed to measure and analyze various aspects of memory
system design and performance.  The most important aspect
of memory subsystem performance is typically the memory
hierarchy, the number and size of caches.  Other important
aspects include the cache line size, TLB, and memory 
parallelism.
.LP
There are any number of aspects of a computer's
micro-architecture that can impact a program's
performance, such as the design of the memory
hierarchy and the basic performance of the various
arithmetic units.
.LP
All of the new benchmarks were added to \*[lmbench]
because the author needed them to help guide his
design decisions in one or more projects over the
last few years.  
For example, \*[lat_ops] was added because the
author was trying to decide whether a particular
image processing algorithm should be implemented
using integer or floating point arithmetic.
Floating point arithmetic was preferred for a
variety of reasons, but it was feared that 
floating point arithmetic would be prohibitively
expensive compared to integer operations.
By quickly building \*[lat_ops] the author was
able to verify that the floating point performance
should be no worse than integer performance.
.LP
Memory speeds have not kept pace with the dizzying pace
of processor performance improvements.  The result has
been a steady increase in the relative cost of memory
accesses, when measured in terms of instructions or
clock ticks.  For example, a 2GHz processor with 200ns
memory latency would wait roughly 400 instructions for
a single memory access.  
.LP
To alleviate memory bottlenecks, architects use cache
memory to reduce the average memory latency.  Typically
there are between one and three caches in modern
memory subsystems.  A rule of thumb is that each
step down the memory hierarchy results in at least
a doubling of memory latency and at least a doubling 
of the cache size.
.LP
The details of the memory hierarchy design can have
a significant impact on application performance
.RN Whaley98 ,
but unfortunaley developers frequently cannot predict
the exact configuration of machines which will run
their software.  Additionally, many developers are
even unaware of the architectural details of their
own machines.
.LP
One hope is that by providing a portable ANSI-C
tool, developers may be better informed about the
architectural possibilities provided by their
own machines, and they may develop more efficient
software which can automatically utilize features
of the particular hardware based on information
provided by these utilities.
.LP
For example, 
.RN Staelin02c
proposes variations on familiar data structures
which take advantage of the increased memory
parallelism afforded by modern processors to
increase performance as much as 50%.
.LP
Before explaining the various algorithms and
experimental methods for determining various
aspects of the memory hierarchy design, we
first give a short tutorial on memory system
design.  Then we describe the basic techniques
used in analyzing the memory hierarchy, and
how they neutralize or measure various
subsystems or features of the memory system.
Finally, we describe in more detail the
specific algorithms used to measure the various 
aspects of the memory subsystem.
.NH 1
Computer Architecture Primer
.LP
A processor architecture is generally defined by its
instruction set, but most computer architectures
incorporate a large number of common building blocks
and concepts, such as registers, arithmetic logic
units, and caches.
.LP
Of necessity, this primer over-simplifies the
many details and variations of specific computer
designs and architectures.  For more information,
please see 
.RN Hennessy96 .
.TSTART 1
.so lmbench3_arch.pic
.FEND "Architecture diagram" 1
.LP
Figure \n[FIGURE] contains a greatly simplified block diagram
of a computer.  Various important elements, such as
the I/O bus and devices, have been left out.  The
core of the processor are the registers (r0, ..., rn
and f0, ..., fn) and the arithmetic units (ALU and FPU).
In general, the arithmetic units can access data in
registers ''instantly''.  Often data must be explicitly
loaded from memory into a register before it can be
manipulated by the arithmetic units.
.LP
The ALU handles integer arithmetic, such as bit
operations (AND, OR, XOR, NOT, and SHIFT) as
well as ADD, MUL, DIV, and MOD.  Sometimes there
is specialized hardware to handle one or more
operations, such as a barrel shifter for SHIFT
or a multiplier, and sometimes there is no
hardware support for certain operations, such
as MUL, DIV, and MOD.  
.LP
The FPU handles floating point arithmetic.
Sometimes there are separate FPUs for single
and double precision floating point operations.
.NH 2
Memory hierarchy
.LP
Nearly all modern, general purpose computers use
virtual memory with phyically addressed caches.
As such, there is typically one or more caches
between the physical memory and the processor,
and virtual-to-physical address translation
occurs between the processor and the top-level
cache.  Cache staging and replacement is done
in \fIcache line\fR units, which are typically
several words in length, and caches lower in 
the hierarchy sometimes have cache lines which
are larger than those in the higher caches.
.LP
Modern processors usually incorporate at least
an L1 cache on-chip, and some are starting to
also incorporate the L2 cache on-chip.  In
addition, most include a translation look-aside
buffer (TLB) on-chip for fast virtual-to-physical
address translation.
.LP
One key element of any cache design is its
replacement strategy.  Most caches use either
direct-mapped or set associative caches.  In
the first instance any word in physical memory
has exactly one cache line where into which it
may be staged, while set associative caches
allow a given word to be cached into one of a
set of lines.  Direct-mapped caches have a 
very simple replacement policy: the contents
of the line that is needed is discarded.
Set associative caches usually use LRU or
some variant within each set, so the least
recently used line in the set of possible
cache lines is replaced.  The control logic
for direct-mapped caches is much cheaper to
build, but they are generally only as 
effective as a set-associative cache half
the size.\**
.FS 
See
.RN Hennessy96
page 396.
.FE
.LP
Another key element of memory hierarchy design
is the management of dirty data; at what point
are writes passed down the memory hierarchy to
lower caches and main memory?  The two basic
policies are write-through and write-back.
A write-through policy means that writes are
immediately passed through the cache to the
next level in the hierarchy, so the lower
levels are updated at the same time as the
cache.  A write-back policy means that the
cache line is marked as dirty in the cache,
and only when the line is ejected from the
cache is the data passed down the hierarchy.
Write-through policies are often used in 
higher (smaller) caches because multi-
processor systems need to keep a coherent
view of memory and the writes are often
propagated to other processors by \fIsnoopy\fR
caches.
.LP
One often overlooked aspect of cache
performance is cache behavior during
writes.  Most cache lines contain
several words, and most instructions
only update the line a word at a time.
This means that when the processor
writes a word to a cache line that is
not present, the cache will read the
line from memory before completing the
write operation.  For \*[bcopy]-like
operations this means that the overall
memory bandwidth requirement is actually
two reads and one write per copied word,
rather than the expected read and write.
.LP
Most modern processors now include some form
of prefetch in the memory hierarchy.  For
the most part these are simple systems that
can recognize fixed strided accesses through
memory, such as might be seen in many array
operations.  However, prefetching systems
appear to be growing in complexity and
capability.
.LP
Additionally, modern memory subsystems can
usually support multiple outstanding requests;
the level of parallelism is usually dependent
on the level of the hierarchy being accessed.
Top-level caches can sometimes support as 
many as six or eight outstanding requests,
while main memory can usually support two
outstanding requests.  Other elements of 
the memory hierarchy, such as the TLB, often
have additional limits on the level of
achievable parallelism in practice.\**
.FS 
For example, if the TLB serializes all
TLB misses, and if each memory access
causes a TLB miss, then the memory
accesses will be serialized even if
the data was in a cache supporting
six outstanding requests.
.FE
.LP
For more information and details on memory 
subsystem design, and computer architecture
in general, please see
.RN Hennessy96
which has an excellent description of these
and many other issues.
.NH 2
Some Recent Innovations
.LP
There are a number of modern extensions to computer
architecture that attempt to increase the processor's
ability to do several things at once.  Nearly all of
these enhancements are intended to be invisible to
programmers using higher-level languages such as
C or JAVA.
.IP "\fBSuperscalar processors\fR"
Superscalar processors have multiple processing
units which can operate simultaneously.  
.IP "\fBDynamic instruction reordering\fR"
Dynamic instruction reordering allows the processor
to execute instructions whose operands are ready
before instructions which are stalled waiting for
memory or other instruction's completion.
.IP "\fBMemory parallelism\fR"
By allowing multiple outstanding memory requests,
processors allow the memory subsystem to service
multiple (independent) requests in parallel. 
Since memory accesses are a common performance
bottleneck, this can greatly improve performance.
.IP "\fBVector processing\fR"
Vector processing allows the processor to execute
arithmetic operations on vector operands in 
parallel, and in modern commodity processors goes
by names such as MMX, SSE, and 3DNow.
.IP "\fBSimultaneous multi-threading (SMT)\fR"
SMT allows superscalar processors to simulatenously
execute instructions from several threads (contexts)
.RN Tullsen96 .
SMT may include extensions which allow for very
lightweight inter-thread synchronization primitives
that enable much finer-grained thread-level 
parallelism than traditional synchronization
methods
.RN Tullsen99 .
.IP "\fBExplicitly parallel instruction computers (EPIC)\fR"
EPIC allows the compiler to explicitly issue $N$
instructions in parallel at each instruction, which
informs the hardware that these instructions are
independent and may be executed in parallel
.RN Schlansker00 .
It moves much of the burden regarding dependency
checking from the hardware to the compiler.
.NH 1
Basic operation latency
.LP
\*[lmbench3] includes a new micro-benchmark 
which measures the latency for a variety of basic
operations, such as addition, multiplication, and
division of integer, float, and double operands.
To measure the basic operation latency we construct
a basic arithmetic statement containing the desired
operands and operations.  This statement is repeated
one hundred times and these repetitions are then
embedded in a loop.  
.TSTART
.TS
center box tab (&);
c c c
l & l & l .
Operand&Operation&Statement
_
int&$bit$&r^=i;s^=r;r|=s;
&$add$&a+=b;b-=a;
&$mul$&r=(r*i)^r;
&$div$&r=(r/i)^r;
&$mod$&r=(r%i)^r;
_
float&$add$&f+=f;
&$mul$&f*=f;
&$div$&f=g/f;
_
double&$add$&f+=f;
&$mul$&f*=f;
&$div$&f=g/f;
.TE
.TEND "lat_ops statements"
.LP
Table \n[TABLE] shows the data type and expressions
used for each basic operation type.  The variable
$i$ indicates the integer loop variable and generally
changes every ten or hundred evaluations of the
basic expression.  All other variables are of
the basic type being measured, and aside from
being modified by the relevant expressions are
only initialized once at the beginning of the
benchmark routine.
.LP
Each statement has been designed to ensure that
the statement instances are \fIinterlocked\fR,
namely that the processor cannot begin processing
the next instance of the statement until it has
completed processing the previous instance.  This
property is crucial to the correct measurement of
operation latency.
.LP
One important consideration in the design of
the statements was that they not be optimized
out of the loop by intelligent compilers.  
Since the statements are repeated one hundred
times, the compiler has the option of evaluating
the sequence of one hundred repetitions of the
same statement, and sometimes it can find
optimizations that are not immediately 
apparent.  For example, the integer statement
$a=a+a;$ when repeated one hundred times in
a loop can be replaced with the single statement
$a=0;$ because the statement $a=a+a;$ is equivalent
to $a< < =1;$, and one hundred repetitions of that
statement is equivalent to $a< < =100;$, which for
32bit (or even 64bit) integers is equivalent to
$a=0;$.  
.LP
It is relatively easy to identify floating
point statements that interlock, are not
optimized away, and that only use the operation
of interest.
It is much harder to identify integer statements
meeting the same criterion.  All simple 
integer bitwise operations can either be optimized
away, don't interlock, or use operations other
than one of interest.
We chose to add operations other than the 
operation(s) of interest to the statements.
.LP
The integer $mul$, $div$, and $mod$ statements all 
include an added $xor$ operation which prevents
(current) compilers from optimizing the statements
away.  Since the $xor$ operation is generally
completed in a single clock tick, and since
we can measure the $xor$ operation latency
separately and subtract that overhead, we can
still measure the latencies of the other 
operations of interest.
.LP
It is not possible to measure latency for 64bit
operations on 32bit machines because most
implementations allow operations on the upper
and lower bits to overlap.  This means that
on most 32bit machines, the measured latency
would appear to be a non-integral multiple of
the basic clock cycle.  For example, in the
$add$ statement, the system could first add
the two lower words.  Then, in parallel it
could both add the two upper words (along with
the carry from the lower words), and compute
the $xor$ of the lower word.  Finally, it
can overlap the $xor$ of the upper word
with the addition of the two lower words from
the next instantiation of the statement.
.TSTART
.TS
center box tab (&);
c c c c c
c c c c c
l & l & r & r & r .
Operand&Op&HPPA2.0&PIII&AMD
&&400MHz&667MHz&1.3GHz
_
mhz&&2.50&1.50&0.75
int&$bit$&2.53&1.50&0.75
&$add$&2.50&1.51&0.75
&$mul$&14.52&6.07&3.03
&$div$&109.40&58.52&30.86
&$mod$&75.14&65.01&32.59
_
float&$add$&7.54&4.58&3.0
&$mul$&7.50&7.50&3.0
&$div$&45.00&35.26&13.21
_
double&$add$&7.52&4.53&3.01
&$mul$&7.52&7.71&3.01
&$div$&85.01&35.51&13.16
.TE
.TEND "lat_ops results (ns)"
.LP
Table \n[TABLE] contains some sample results
for two processors.  
It does contain one result which is slightly
surprising unless you are familiar with the
PA-RISC architecture: floating point multiply
and divide are faster than the corresponding
integer operations!  This is because PA-RISC
does not contain integer MUL, DIV, or MOD
instructions and the optimizing compiler
converts the integers into floating point,
does the operations in the floating point
unit, and then converts the result back
to an integer.
.NH 2
Basic operation parallelism
.LP
Instruction-level parallelism in commodity processors
has become commonplace in the last ten years.  
Modern processors typically have more than one
operational unit that can be active during a
given clock cycle, such as an integer arithmetic
unit and a floating point unit.  In addition, 
processors may have more than a single instance
of a given type of operational unit, both of
which may be active at a given time.  All this
intra-processor parallelism is used to try and
reduce the average number of clock cycles per
executed instruction.  
.LP
\*[lmbench3] incorporates a new benchmark \*[par_ops]
which attempts to quantify the level of available
instruction-level parallelism provided by the processor.  This 
benchmark is very similar to \*[lat_ops], and
in fact uses the same statement kernels, but it
has been modified and extended.  We create
different versions of each benchmark; each
version has $N$ sets of interleaved statements.
Each set is identical to equivalent \*[lat_ops]
statements.  In this way multiple independent
sets can be executing the same operation(s)
in parallel, if the hardware supports it.
.LP
For example, the float $mul$ benchmark to measure
performance with two parallel streams of statements
would look like something this:
.DS L
\f(CW#define TEN(a) a a a a a a a a a a
void benchmark_1(iter_t iterations, void* cookie)
{
    register iter_t i = iterations;
    struct _state* state = (struct _state*)cookie;
    register float f0 = state->float_data[0];
    register float f1 = state->float_data[1];

    while (i-- > 0) {
        TEN(f0*=f0; f1*=f1;)
    }
    use_int((int)f0);
    use_int((int)f1);
}\fP
.DE
.LP
If the processor had two floating point multiply
units, then both $f0$ and $f1$ multiplies could
proceed in parallel.
.LP
However, there are some potential problems with
the integer operations, namely the fact that the
statements contain mixed operations.  In general,
processors have at least as many integer units
that can do $xor$ as can do the other operations
of interest ($mul$, $div$ and $mod$), so the
inclusion of $xor$ in the statements shouldn't
be a bottleneck.  
.LP
However, since parallelism is measured by comparing 
the latency of the single-stream with that of 
multiple interleaved streams, and since the single-stream 
latency includes the $xor$ latency, the apparent 
parallelism of $mul$, $div$, $mod$ can be over-stated.
For example, if a process has one unit that can
do integer bit operations, such as $xor$, and another
unit for integer $mul$ operations, then the average
latency for $a0 = (i * a0) ^ a0$ in the single stream 
case would be:
.EQ
t bar = t sub xor + t sub mul
.EN
In the multi-stream case, the execution of the $xor$ 
operation of one stream can be overlapped with the 
$mul$ of another stream, so the average latency per 
stream would simply be $t bar = t sub mul$, assuming 
that $mul$ operations are not cheaper than $xor$ 
operations, which results in an apparent parallelism 
$p tilde$:
.EQ
p tilde = {t sub xor + t sub mul} over { t sub mul }
.EN
Assuming that $t sub xor < < t sub mul$, this
still gives a reasonable approximation to
the correct answer.  Unfortunately, this is
not always a reasonable assumption.
.LP
Of course, if it was known ahead of time that
$xor$ and { $mul$, $div$, and $mod$ } used
different execution units, then the benchmark
could simply subtract $t sub xor$ from the
baseline measurement.  The difficulty lies
in determining whether the units overlap
or not.
.TSTART
.TS
center box tab (&);
c c c c c
c c c c c
l & l & r & r & r .
Operand&Op&HPPA2.0&PIII&AMD
&&400MHz&667MHz&1.3GHz
_
int&$bit$&1.99&1.70&1.87
&$add$&1.99&1.61&1.90
&$mul$&6.64&3.81&2.00
&$div$&2.81&1.20&1.00
&$mod$&2.78&1.11&1.03
_
float&$add$&5.88&1.00&2.66
&$mul$&5.86&1.14&2.47
&$div$&2.12&1.03&1.14
_
double&$add$&5.68&1.08&2.49
&$mul$&5.58&1.00&2.53
&$div$&2.19&1.03&1.14
.TE
.TEND "par_ops results"
.LP
.NH 1
Memory analysis
.LP
There are a variety of aspects of memory hierarchy design
that are interesting to a software developer, such as
the number of caches and their sizes.  In addition, other
aspects of cache design, such as the line size,
associativity and parallelism can impact software
performance and are of potential interest to software
developers.
.LP
The problem is designing a portable ANSI-C program to
infer the cache parameters.  A number of operating
systems have hooks to report at least certain aspects
of cache and memory hierarchy design, but any program
utilizing those hooks would not be fully portable
across hardware and operating system platforms.  
.LP
The key observation is that caches help reduce memory
latency.  In a perfect world, all possible data would
fit in the cache, so a graph of average memory latency
versus amount of memory utilized would look like a
series of plateaus separated by cliffs.  The cliff
edges would be located at the cache boundaries and
the plateau height would be the average memory latency.
.LP
The first problem is that one needs a mechanism for
accurately measuring time in a portable fashion.  
\*[lmbench2] introduced a new timing harness
that determines the minimum duration of a timing interval
for \*[gettimeofday] to provide accurate measurements
.RN Staelin98 .
.LP
\*[lmbench] includes a benchmark that measures 
average memory latency, \*[lat_mem_rd]
.RN McVoy96 .
It creates a pointer chain, and then measures the
average time to dereference the pointers.  
\*[lat_mem_rd] creates the pointer chain by simply
striding through memory at fixed intervals, e.g.
every other word.
.LP
\*[lmbench2] extended \*[lat_mem_rd] so
that each timing interval only accessed memory
as many times as necessary to consume a timing
interval.  When accessing cache this often means
that the whole pointer chain will be accessed
at least once during the timing interval, but
when accessing memory this often means that only
a portion of the chain will be accessed during
any given timing interval.
.LP
While this approach gives very useful insights
into memory hierarchy performance, it is not
quite sufficient to determine the various 
characteristics of the memory hierarchy.
.LP
The first problem is that unless the stride is
exactly the same size as the cache line size, then
there will either be multiple successive accesses
to the same line, or some fraction of data
will be completely skipped.  In the first case
the observed latency is much faster than the
true latency because it is the average of a
single miss latency (slow) with one or more
hit latencies (fast).  In the second case, the
amount of data actually loaded into the cache
may be a small fraction of the expected amount
so the data may fit into a smaller (faster) 
cache.
The second problem is that this sequence is
highly predictable, even by simple-minded
prefetching policies, so accurate prefetching 
might be masking the true memory latencies.
.LP
This method does do a few things properly.
First of all, accesses to a single page are
clustered together so the TLB miss cost (if
any) is amortized over as many accesses as
possible.  Secondly, assuming the pointer
chain is laid out unpredictably, the memory
subsystem must wait for the previous load
to complete before it can initiate the
next load, so we can measure the true latency.
.NH 2
Prefetching
.LP
Some memory subsystems have been highly optimized to
recognize and automatically prefetch memory when 
given "predictable" memory access streams, such as 
when striding through array accesses.  This means that
the memory access stream generated by \*[lmbench]
must be unpredictable by the standard prediction
algorithms.
.LP
The original \*[lmbench] memory latency benchmark, 
lat_mem_rd, built a chain of pointers that would
stride backwards through memory.  This was able to
defeat many simple prefetching algorithms of the
time, but some systems came to incorporate prefetching
algorithms that recognized strided accesses in
both directions.
.LP
The obvious method for producing an unpredictable
chain of line references is to use a random
permutation of line indexes.  
.LP
\*[lmbench] uses a deterministic algorithm to compute
the reference chain which guarantees that references
are as far away from previous accesses in both time
and space as possible.  Basically, the binary bits
representing the line index are reversed, so that
1101 becomes 1011, or 001 becomes 100.  This only
works if the number of cache lines is an even power
of two, but since page sizes and line sizes are
always powers of two, this assumption is valid.\**
.FS 
At least this is the case in every modern system known 
to the author.
.FE
.LP
Additionally, since higher-level caches can have
smaller line sizes than lower-level caches, it
is necessary to access every word in the relevant
chunk of memory.  However, accesses to words in
the same line must be separated in time by accesses
to the rest of the memory.  This is achieved by
identifying the line size for the largest cache,
and then setting up the chain so that there is
one pass through the memory for each word in the
line with the sequence of words being determined
by the bit-reversal method described above.  
.LP
For example, suppose a system has 4KB pages, the
largest cache has a line size of 64bytes, and a
word is 4bytes.  Then each page would have 64 lines,
and each line would have 16 words.  The system
would setup a pointer chain that visits each line
on each page using the zeroth word; at the end of
the chain it would then jump to the start of the
pages and visit each line on each page using the
eigth word, and so forth until each word had been
visited.  
.NH 2
Dirty data
.LP
An additional issue that we need to take into 
account is the cache's policy for dirty data.  
Many caches use a copy-back policy, while others
use a write-through policy.  
.LP
Different caches on the same machine may use
different policies.  Also, cache performance
can be affected by the presence of dirty data.
For example, suppose both the L1 and L2 caches
use a copy-back policy, and suppose that the
access time for reading data located in L2
depends on whether the data being ejected from
L1 is dirty and needs to be copied back from L1
to L2 before the read from L2 to L1.
In this case, a benchmark which writes a pointer
chain that fits in L2 but is larger than L1,
and then measures the time to follow the chain,
will get a different average memory latency than
a benchmark which writes the same chain and
reads enough data to flush the L2 cache before
measuring the time to follow the chain.
In the first case, each application read will
result in a write from L1 to L2 followed by
a read from L2 to L1, while in the second
case each application read will only result
in a read from L2 to L1.
.LP
Since it is possible that average memory latencies
for a read-only access stream may be increased if
any of the data in the cache is dirty, we need to
flush the cache after setting up the pointer
chains and before we do any measurements.  
Otherwise, when we access a pointer chain that
is larger than the L1 cache but smaller than the
largest cache, dirty data can reside in the lowest
(largest) cache and as each line is staged from
the largest cache to the L1 cache, it is marked
as dirty in the L1 cache.  Then when each dirty
line is flushed from the L1 cache (to the L2
cache), the system has to write the data back to
L2, which delays the load of the next (dirty)
line from L2 to L1.
.LP
To flush the cache we read (and sum) a large
amount of memory, which should be several times
larger than the largest cache.  In this way,
all dirty data in the cache should be flushed
from the cache without creating additional
dirty data.
.NH 2
Page mapping
.LP
Complicating the issue still further is the fact that
caches do not use full LRU replacement policies.  Nearly
all caches use some form of set associativity, where
pages are directed to a pool of cache lines based on
the physical address.  Replacement within the pool is
typically LRU.  Direct-mapped caches are a special case
where the pool size is a single line.
.LP
Additionally, some systems use victim caches, which are
typically small caches which caches recently discarded
cache lines.  Victim caches can be particularly effective
for direct-mapped caches by reducing the cache miss
rate caused by colliding hot spots.
.LP
However, page mapping and its attendant cache collisions
is under the control of the kernel, and is in fact 
invisible to user-land programs.  Some operating
systems make an effort to minimize possible page collisions 
when giving memory to processes\**, while other operating 
systems appear to simply grab the first available pages, 
regardless of potential cache collision effects.
.FS 
This is generally known as "page coloring", and is much
more important on systems with direct-mapped caches than
those with N-way set associative caches.
.FE
.LP
Factoring out page placement affects on average memory
latency is very difficult, but it is necessary to 
ensure that the correct cache size is identified.
.NH 1
Cache line size
.LP
The first feature of the memory hierarchy we
will try to analyze is the cache line size,
since we can find the line size for the 
largest cache without any other knowledge of
the system, and since determining nearly all
other aspects of the memory subsystem either
require or are greatly simplified by knowing
the cache line size.
.LP
The most obvious aspect of cache design is that replacement
is done on a per-line basis, and cache lines often contain
several words of data (32-128bytes per line is common).
However, it is necessary to ensure that we don't 
generate "spurious" cache hits by referencing a word from 
a cache line that was recently accessed.  We must ensure 
that each line is only re-referenced after all other 
memory in the buffer has been referenced.
.LP
Unfortunately, we usually do not know the cache line size
ahead of time.  In addition, sometimes systems contain
several caches, and each cache can use a different line
size!  Usually line sizes are powers of two, and usually
the smaller (higher) caches have line sizes which are the
same or smaller than the larger (lower) caches.  However,
we still need to ensure that we access all cache lines
for all caches without generating the spurious cache hits.
.LP
Determining the cache line size requires a series of
experiments.  The basic observation is that when the
amount of memory being accessed is larger than the
cache, and when the access chain is arranged properly,
then each memory reference causes a cache miss.  If
however, a word on a recently access line is requested,
then that reference will be a cache hit.  More
completely, the average memory access time $t bar$
is:
.EQ
t bar = t sub miss + ( n - 1 ) t sub hit
.EN
expressed as a function of $n$, the number of accesses 
to the cache line, $t sub miss$, the cache miss latency, 
and $t sub hit$, the cache hit latency.
.TSTART
.G1
.so memhier-line.d 
.G2
.FEND "Line Size"
.LP
We can determine the cache line size by measuring
the average memory access latency over a series of
memory access patterns: accessing every word, every
other word, every fourth word, every eighth word, ...
While the system is accessing multiple words per
cache line, the average memory latency will be
smaller than the cache miss latency, and as the
space between accesses increases, the average
memory increase will grow.
When the system accesses only one word per line,
the average memory latency will remain level even
as the spacing between accesses increases.
.LP
It is possible to utilize this behavior to identify
the cache line size.  The algorithm is to measure
the average memory latency when each word is 
accessed.  Then as you increase the space between
accessed words (doubling the space each iteration),
you look for a situation where the average latency
increased dramatically, say greater than 30%,
followed by a levelling off on the next iteration,
say an increase less than 15%.  The line size is
the last point where the average latency jumped
dramatically.
.NH 1
TLB
.LP
Measuring the TLB-miss costs assumes that one can isolate
those costs from the rest of the memory access costs.  The
key observation is that it is often possible to create a
situation in which all data being accessed resides in the
cache, and yet it requires a TLB-miss to be able to locate
it.
.LP
This program identifies the effective TLB size, rather 
than the true TLB size.  First of all, from a programmer's
point of view, it is really the effective TLB size that
impacts program performance.  Secondly, there is no way
for a user-land program to measure true TLB size because
kernels sometimes pin some kernel page mappings into the 
TLB and because some hardware/OS combinations 
support "super-pages", or multi-page mappings.
.LP
We create two similar pointer chains with identical length
and which reference an identical amount of memory, with one
key difference.  In the first chain, the data is packed
tightly into as few pages as possible, and references
remain within a single page as long as possible.  The
second chain spreads the data over as many pages as
possible and jumps between pages at each reference.
The two chains are arranged so that the same amount of
data will fit into the cache, so that the raw memory
access time for each chain is identical, within 
experimental constraints.  The sole difference between
average access costs should be the TLB-lookup times.
.LP
When the pages from the second chain fit into the TLB,
the average access times for the two chains should be
identical.  However, as soon as the number of pages in
the second chain exceeds the TLB size, the second
chain will start to pay frequent TLB-miss costs.
Depending on the TLB replacement policy, the fraction of 
requests generating TLB-misses in the second chain can vary
dramatically\**.  
.FS 
Pure LRU would ensure that as soon as the chain was one 
page longer than the TLB size, every access would trigger 
a TLB-miss.  However, other replacement algorithms might
result in as few as $"number of pages" - "TLB size" + 1$
misses per iteration over the loop.
.FE
.TSTART
.G1
.so memhier-tlb.d
.G2
.FEND "TLB"
.LP
The system must search for the point at which the
average memory latency of the second chain diverges
from the average latency of the first chain.  Since
most systems have relatively small TLBs and since
checking TLB sizes smaller than the effective TLB
size is faster than checking TLB sizes larger than
the TLB, the system starts with the guess of eight
pages to establish a baseline.  It then iteratively
doubles the number of pages until either a maximum
limit has been reached or the average TLB-miss cost
is greater than 15% of the average memory latency.
Once it discovers the upper bound on the possible
TLB size, it uses a binary search between the last
two TLB size guesses to find the point at which
the average latency for the two streams diverge.
.NH 1
Cache size
.LP
For the purpose of identifying the cache size, the
ideal situation is that as long as the amount of 
memory is equal to or less than the cache size, then
all the data is in the cache and the average memory
latency is the cache hit latency.  As soon as the
memory doesn't fit in cache, then none of it should
be in the cache, so the average memory latency is
the cache miss latency.\**  When examining average
memory latency versus memory size, this would give
nice flat plateaus for each cache, with nice sharp
transitions from one cache to the next, and from the
largest cache to main memory.
.FS
Of course, for real programs, you want the average
memory latency to be as low as possible, which means
that you want as much of the data in cache as possible.
.FE
.LP
However, the realities are that real data from real
systems is corrupted in a variety of ways.  
First of all, even when the memory can fit into the 
cache, pages often collide in the cache and the 
fraction of pages that have collisions often 
increases as the amount of memory nears the cache size.  
Secondly, even when the memory cannot fit into the 
cache, there can be pages that do not collide. 
Finally, there is simple experimental noise, which is 
usually limited to 1% or less.  
.LP
The result of the first two problems is that on
some systems, the average memory latency increases
gradually as the memory size is increased.  There
are no flat plateaus and sharp cliffs which make
it easy to identify the number, size, and 
performance of the caches.
.NH 2
Page coloring
.LP
The first problem is to create a set of pages
which do not collide in the cache.
The solution is to allocate more memory
than necessary, and to try different combinations
of pages to find the page set with the fastest
average memory latency.  Unfortunately, the obvious
algorithm is exponential in the number of pages.
.TSTART
.G1
.so memhier-color.d
.G2
.FEND "Page Coloring Effects"
.LP
One observation is that cache misses are usually
much more expensive than cache hits.  So, one
possibility is to choose a random set of pages
as the baseline and measure the average memory
latency.  Then iterate over the pages, removing
that page from the set and measuring the average
memory latency of the reduced set.  If that page
collides with another page, then the average 
memory latency for the reduced set should be smaller
than the average latency for the whole set.
.LP
Once a page that collides has been identified, then
the system can iterate through available pages,
try adding them to the reduced set and measuring
the average memory latency.  If the page doesn't
collide with any pages in the reduced set, then
the average memory latency should drop still further.  
In this way, the system could identify all
colliding pages and replace them with pages
that don't collide (assuming the memory all
fits in the cache).
.LP
There are a number of problems with this simple approach.  
First of all, it would take a very long time to run due 
to the large, but polynomial, number of experiments required.  
Secondly, as the memory size increases and the 
number of pages involved gets large, the effect 
of a single page on the average memory latency 
can reach the level of experimental noise.
.LP
This approach makes the assumption that physical
page locations do not change once the memory
has been allocated.  In most systems, this 
assumption is valid unless the memory is paged
to disk.  However, at least IRIX includes an
operating system configuration option to allow
the operating system to dynamically relocate
pages in memory.  This capability is disabled
by default, so its use is relatively uncommon.
It is possible that page relocation will become
more common in the future, in which case this
design may need to be revisited in the future.
.LP
Our algorithm uses this basic approach, but 
attempts to reduce the number of experiments
required by removing chunks of pages at a time.
It will remove up to 5% of pages at a time
and see if the average memory latency decreases
significantly, in which case it examines the
chunk a page at a time to find the page or
pages which probably conflict.
.LP
An additional problem is that for large caches,
the measured difference between two sets of
pages with just one page collision difference
can be very hard to measure.  For example,
on a system with a 512Kbyte L2 cache and 4Kbyte
pages, the cache can hold 128 pages.  Assuming
that a cache miss is 200ns, a cache hit is 50ns,
and 123 pages have no collisions but 5 pages
collide, then the average memory latency is
.EQ
t bar = { 123 times 50 + 5 times 200 } over 128
.EN
or 55.85ns.  Suppose we remove one page and
replace it with another page which doesn't
collide, so we now have 4 collisions and
124 pages without collisions, then the
average memory latency is 54.68ns.  The
difference is generally significant even
in the face of experimental noise, but for
larger caches the differences may recede 
into the background noise.
.LP
As caches increase in size, the problems
associated with detecting page collisions
can only increase.  
For example, an 8MB cache on a system with
4KB pages would contain 2,048 pages.
Removing a single page collision, even when
the resulting memory latency for that page
reduces by a factor of four, would simply
result in an overall reduction in average
memory latency of less than 0.2%, which is
smaller than the average experimental measurement
errors.
.LP
Additionally, as caches increase in size,
effects such as cache consumption by the
page table can begin to become important.
.LP
The single largest remaining problem in our
system is that this algorithm does not 
guarantee that we find a set of pages
which do not contain any collisions in all
cases that it \fImight\fR find such a set.
It merely does so \fImost\fR of the time
with (relatively) few measurements.
.LP
One possible means of dealing with this
problem is to try an remove sets of pages
in the hope that enough pages from a set
of colliding pages will be removed at 
once, so that the remaining pages from
that collision set won't collide anymore.
Suppose you have a 4-way set associative
cache, and that you have six pages that
collide.  If you remove two of the pages,
then the remaining four pages don't collide
anymore either.  This means that by 
removing two pages we have removed six
collisions, which should be easier to
detect.
.LP
XXX Look into randomizing the pages
after each iteration of the top-level
loop to make this sort of serendipitious
event more likely.
.NH 2
Measurement
.LP
In order to reduce the number of memory sizes
that are measured by the system, we use a 
binary search on memory sizes to find "edges"
in the memory latency.
We make the simplifying assumption that cache 
sizes are either a power of two, or 1.5 times 
a power of two.  In our experience, this assumption
has been true.
We also assume that no cache is smaller than
512 bytes.
.LP
We explore the memory space at intervals
equivalent to the most recent power of two
divided by four.  So, starting at one 
megabyte we would (potentially) measure
memory latency at 1MB, 1.25MB, 1.5MB, and
1.75MB.  This allows us to detect
cache sizes at the desired intervals, since
the measurement at the exact cache size
can often be corrupted by other system
activity so the next smaller measurement
should still be valid.
.LP
XXX If the measurement size increment is
several times larger than a page, then
perhaps we should actually measure the 
system with a couple pages less than the
stated size?
This would allow us some "slop" for
collisions and might make it easier near
cache boundaries to get accurate 
measurements.
The "slop" should probably be some fraction
of the measurement increment size, such as
10%, so it scales properly.
.LP
Since we start with a maximum size as a given,
and we use 512 bytes as a minimum, and we can
compute the full set of possible measurements,
and initialize an array with the desired sizes.
We can then use a modified binary search on
this array to efficiently locate cache edges
while still (potentially) leaving large, flat
plateaus unexplored between the end points.
.LP
Finally, we assume that true memory latency
is monotonically increasing with the amount
of memory that you access.
This means that if the measured latency ever
decreases as you increase the amount of
accessed memory, then the previous measurement
must have been an error and the value is
replaced by the smaller measurement.
.NH 2
Data analysis
.LP
Assuming the data collected by the system
were noise-free and that the experimental
system had managed to eliminate all artifacts
such as page coloring effects, then the
next problem is to analyze the data to find
the number and size of the caches.
Basically this means examining the data to
find plateaus and cliffs.
Each plateau would represent a cache, and the
cliff represents the edge (size) of the cache.
.LP
Of course, real data is never perfect, and
there are any number of issues which can
affect the experimental results, so the
analysis methodology must be robust to noise.
.LP
XXX describe analysis methodology here
.NH 1
Cache associativity
.LP
No modern caches are fully associative, meaning that
no caches use LRU replacement, because the performance
overhead for LRU is so severe.  Most caches are 
either set associative or direct mapped, meaning
that data from a given location can only go to
one of a small number of cache lines, and in the
case of a direct-mapped cache to a single cache line.
.LP
To determine the cache associativity we need to find
a set of pages which have no page collisions and
which (just) fit into the cache.  We then need to
locate a page which collides with these pages and
append it to the set.
Then we can iterate through the pages in the initial
page set, removing a page at a time, and comparing
the resulting average memory latency with that of
the full set.
When the average memory latency drops significantly,
then we know that this page conflicts with the
full page set, and since the page set only has one
conflict, we know it conflicts with the newly
introduced page.
The number of pages that conflict with this newly
introduced page is the set associativity.
.LP
There is a potential bug in this algorithm 
for systems with victim caches!  
If the victim cache can hold at least a page 
of data, then this algorithm cannot properly 
determine the cache associativity because the 
victim cache will play the role of additional 
associative cache lines.
.LP
For smaller caches there is the additional
problem that the cache associativity may not
be smaller than the number of pages that the
cache may hold.
In which case, this simple approach will 
never find pages that collide in the cache.
The solution to this problem is to increase
the line size and the number of pages so that 
only portions of each page are accessed, and
there can be enough pages to create collisions.
.NH 1
Memory parallelism
.LP
With the increasing memory bottleneck, most modern
systems allow multiple outstanding memory references.
On many systems, the effective parallelism depends
on which part of the memory hierarchy is being
accessed.  For example, L1 caches can often service 
as many as six or eight outstanding requests, while main 
memory systems can usually support at most two 
outstanding requests.
.LP
To measure the available parallelism for a given
chunk of memory, the system sets up a pointer
chain running through the memory exactly the same
as if it were to measure the average memory 
latency.  It then uses fifteen different access
routines, one for each possible level of parallelism.\**
.FS 
The assumption here is that no memory subsystem
supports more than sixteen accesses in parallel.
.FE
Each routine dereferences $N$ pointers in parallel.
For example, the inner loop of the routine where 
$N=2$ would look something like this:
.DS L
\f(CWwhile (iterations-- > 0) {
	p0 = (char**)*p0;
	p1 = (char**)*p1;
}\fP
.DE
.LP
The available parallelism is the maximum speedup
over all N compared to the sequential case.
.LP
Note that this value is often not integral because
many factors go into the effective parallelism,
such as TLB contention, can limit the effective
parallelism.
.NH 1
DRAM pages
.LP
Within DRAM chips there is usually one or more
lines of data which is "cached" in registers
near the chip outputs.
Accessing data contained in these lines is typically
faster than accessing data from the body of the DRAM
chip.
The set of memory contained in a bank of DRAM chips
for a single line (per DRAM chip) of memory is usually
called a DRAM page.
.LP
Recently some systems have started taking advantage
of this potential performance increase by keeping
DRAM pages "open" (in the register bank) after an
access in the hope that the next access will be
to the same page.
This means that main memory latency suddenly 
depends on the access history, and that dramatic
differences in "open" versus "closed" DRAM page
performance may impact software and data structure
design.
.LP
To measure DRAM page latency, we need to compare
performance for accesses to "open" versus "closed"
DRAM pages.
The standard pointer chain developed for measuring
cache and memory latency maximizes "open" DRAM page
accesses while minimizing other overheads, such as
TLB misses.
This means that we need to develop another pointer
chain which maximizes "closed" DRAM accesses while
still minimizing other overheads such as TLB misses.
.LP
This can be done by clustering pages into \fIgroups\fP
whose size is smaller than the TLB size.
Within each group the pointer chain switches pages
on each access to maximize the probability of a "closed" 
DRAM page access.
For all but the last page in the group, each access
points to the same location within the page, except
on the next page.
The last page points to the next location in the
first page, using the same location bit-switching
selection logic used in the standard pointer chain.
.NH 1
Conclusion
.LP
XXX Update conclusions
\*[lmbench] is a useful, portable micro-benchmark suite designed to
measure important aspects of system performance.   We have found that a good
memory subsystem is at least as important as the processor speed.
As processors get faster and faster, more and more of the system design
effort will need to move to the cache and memory subsystems.
.NH 1
Acknowledgments
.LP
Many people have provided invaluable help and insight into both the
benchmarks themselves and the paper.  The \s-1USENIX\s0 reviewers
were especially helpful.
We thank all of them and especially thank:
Wayne Scott \s-1(BitMover)\s0,
Larry McVoy \s-1(BitMover)\s0,
Bruce Chapman \s-1(SUN)\s0,
and
John McCalpin \s-1(Univ. of Virginia)\s0.
.LP
We would also like to thank all of the people that have 
run the benchmark and contributed their results; none of 
this would have been possible without their assistance.
.NH 1
Obtaining the benchmarks
.LP
The benchmarks are available at:
.QP
\fIhttp://ftp.bitmover.com/lmbench\fP
.ft
.\" .R1
.\" bibliography references-memhier
.\" .R2
.\"********************************************************************
.\" Redefine the IP paragraph format so it won't insert a useless line
.\" break when the paragraph tag is longer than the indent distance
.\"
.de @IP
.if \\n[.$]>1 .nr \\n[.ev]:ai (n;\\$2)
.par*start \\n[\\n[.ev]:ai] 0
.if !'\\$1'' \{\
.	\" Divert the label so as to freeze any spaces.
.	di par*label
.	in 0
.	nf
\&\\$1
.	di
.	in
.	fi
.	chop par*label
.	ti -\\n[\\n[.ev]:ai]u
.	ie \\n[dl]+1n<=\\n[\\n[.ev]:ai] \\*[par*label]\h'|\\n[\\n[.ev]:ai]u'\c
.	el \{\
\\*[par*label]
.\".	br
.	\}
.	rm par*label
.\}
..
.\"********************************************************************
.\" redefine the way the reference tag is printed so it is enclosed in
.\" square brackets
.\"
.de ref*end-print
.ie d [F .IP "[\\*([F]" 2
.el .XP
\\*[ref*string]
..
.\"********************************************************************
.\" Get journal number entries right.  Now will print as V(N) rather
.\" than the awful V, N.
.\"
.de ref*add-N
.ref*field N "" ( ) 
..
.\"********************************************************************
.\" Get journal volume entries right.  Now will print as V(N) rather
.\" than the awful V, N.
.\"
.de ref*add-V
.ref*field V , "" "" ""
..
.\"********************************************************************
.\" Get the date entry right.  Should not be enclosed in parentheses.
.\"
.de ref*add-D
.ref*field D ","
..
.R1
accumulate
sort A+DT
database references-memhier
label-in-text
label A.nD.y-2
bracket-label [ ] ", "
bibliography references-memhier
.R2
.\" .so bios
