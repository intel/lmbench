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
.tl '\(co 2002 \\*[author]'%'\fB\\*(DY DRAFT DO NOT DISTRIBUTE\fP'
..
.de lmBT
.	ps 9
\v'-1'\\l'\\n(LLu'
.	sp -1
.	tl '\(co 2002 \\*[author]'\\*(DY'%'
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
.ds title Measuring scalability
.ds author Carl Staelin
.ds lmbench \f(CWlmbench\fP
.ds lmbench1 \f(CWlmbench1\fP
.ds lmbench2 \f(CWlmbench2\fP
.ds lmbench3 \f(CWlmbench3\fP
.ds bcopy \f(CWbcopy\fP
.ds benchmp  \f(CWbenchmp\fP
.ds bw_file_rd \f(CWbw_file_rd\fP
.ds bw_mem \f(CWbw_mem\fP
.ds bw_mmap_rd \f(CWbw_mmap_rd\fP
.ds bw_pipe \f(CWbw_pipe\fP
.ds bw_tcp \f(CWbw_tcp\fP
.ds bw_udp \f(CWbw_udp\fP
.ds bw_unix \f(CWbw_unix\fP
.ds connect \f(CWconnect\fP
.ds execlp  \f(CWexeclp\fP
.ds execve  \f(CWexecve\fP
.ds exit \f(CWexit\fP
.ds fcntl \f(CWfcntl\fP
.ds fork \f(CWfork\fP
.ds fstat \f(CWfstat\fP
.ds gcc \f(CWgcc\fP
.ds getpid \f(CWgetpid\fP
.ds getppid \f(CWgetppid\fP
.ds gettimeofday \f(CWgettimeofday\fP
.ds kill \f(CWkill\fP
.ds lat_connect \f(CWlat_connect\fP
.ds lat_ctx \f(CWlat_ctx\fP
.ds lat_fcntl \f(CWlat_fcntl\fP
.ds lat_fifo \f(CWlat_fifo\fP
.ds lat_fs \f(CWlat_fs\fP
.ds lat_http \f(CWlat_http\fP
.ds lat_mem_rd \f(CWlat_mem_rd\fP
.ds lat_mmap \f(CWlat_mmap\fP
.ds lat_ops \f(CWlat_ops\fP
.ds lat_pagefault \f(CWlat_pagefault\fP
.ds lat_pipe \f(CWlat_pipe\fP
.ds lat_proc \f(CWlat_proc\fP
.ds lat_rpc \f(CWlat_rpc\fP
.ds lat_select \f(CWlat_select\fP
.ds lat_sem \f(CWlat_sem\fP
.ds lat_sig \f(CWlat_sig\fP
.ds lat_syscall \f(CWlat_syscall\fP
.ds lat_tcp \f(CWlat_tcp\fP
.ds lat_udp \f(CWlat_udp\fP
.ds lat_unix \f(CWlat_unix\fP
.ds lat_unix_connect \f(CWlat_unix_connect\fP
.ds line \f(CWline\fP
.ds lmdd  \f(CWlmdd\fP
.ds lmdd \f(CWlmdd\fP
.ds memmove \f(CWmemmove\fP
.ds mhz  \f(CWmhz\fP
.ds mmap \f(CWmmap\fP
.ds par_mem  \f(CWpar_mem\fP
.ds par_ops  \f(CWpar_ops\fP
.ds pipe  \f(CWpipe\fP
.ds popen  \f(CWpopen\fP
.ds read \f(CWread\fP
.ds select  \f(CWselect\fP
.ds semop \f(CWsemop\fP
.ds sh  \f(CW/bin/sh\fP
.ds stat \f(CWstat\fP
.ds stream \f(CWstream\fP
.ds system  \f(CWsystem\fP
.ds tlb \f(CWtlb\fP
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
\s(14lmbench user guide\s0
.AU
\s+2\fR\*[author]\fP\s0
.AI
\fI\s+2Hewlett-Packard Laboratories Israel\s0\fP
.SP
.AB
\*[lmbench] is a micro-benchmark suite designed to focus
attention on the basic building blocks of many
common system applications, such as databases, simulations, 
software development, and networking.  
It is also designed to make it easy for users to create
additional micro-benchmarks that can measure features, 
algorithms, or subsystems of particular interest to the
user.
.SP
There is a timing harness, \*[benchmp], designed 
to measure performance at specific levels of parallel 
(simultaneous) load.
.AE
.if t .MC 3.05i
.NH 1
Introduction
.LP
\*[lmbench] is a widely used suite of micro-benchmarks
that measures important aspects of computer system
performance, such as memory latency and bandwidth.
Crucially, the suite is written in portable ANSI-C
using POSIX interfaces and is intended to run on a 
wide range of systems without modification.
.LP
The benchmarks included in the suite were chosen
because in the \*[lmbench] developer's experience,
they each represent an aspect of system performance
which has been crucial to an application's
performance.  
.LP
In general the benchmarks report either the latency
or bandwidth of an operation or data pathway.  The
exceptions are generally those benchmarks that
report on a specific aspect of the hardware, such
as the processor clock rate, which is reported 
in MHz and nanoseconds.
.LP
\*[lmbench] consists of three major components:
a timing harness, the individual benchmarks
built on top of the timing harness, and the
various scripts and glue that build and run the 
benchmarks and process the results.
.NH 2
\*[lmbench] history
.LP
\*[lmbench1] was written by Larry McVoy
while he was at Sun Microsystems.  It focussed
on two measures of system performance: latency
and bandwidth.  It measured a number of basic
operating system functions, such as file system
read/write bandwidth or file creation time.  It
also focussed a great deal of energy on measuring
data transfer operations, such as \*[bcopy] and
\*[pipe] latency and bandwidth as well as raw
memory latency and bandwidth.
.LP
Shortly after 
.RN McVoy96
was published, 
.RN Brown97
examined the \*[lmbench] benchmarks and published
a detailed critique of its strengths and weaknesses.
Largely in response to these remarks, development
of \*[lmbench2] began with a focus on
improving the experimental design and statistical
data analysis.  The primary change was the development
and adoption across all the benchmarks of a timing 
harness that incorporated loop-autosizing and clock 
resolution detection.  In addition, each experiment
was typically repeated eleven times with the median
result reported to the user.
.LP
\*[lmbench3] focussed on extending 
\*[lmbench]'s functionality along two dimensions:
measuring multi-processor scalability and measuring
basic aspects of processor architecture.
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
An important feature of multi-processor systems is their
ability to scale their performance.  \*[lmbench1]
was able to measure various important aspects of 
system performance, except that only one client process
was active at a time
.RN McVoy96 .
\*[lmbench2] introduced a new macro, BENCH(), which
implemented a sophisticated timing harness that
automatically managed nearly all aspects of accurately
timing operations
.RN Staelin98 .
For example, it automatically
detects the minimal timing interval necessary to 
provide timing results within 1% accuracy, and it
automatically repeats most experiments eleven times
and reports the median result.
.LP
However, this timing harness is incapable of measuring
the performance of a system under scalable loads.  
\*[lmbench3] took the ideas and techniques
developed in the earlier versions and extended them
to create a new timing harness which can measure
system performance under parallel, scalable loads.
.LP
\*[lmbench3] also includes a version of John 
McCalpin's STREAM benchmarks.  Essentially the STREAM 
kernels were placed in the new \*[lmbench] timing harness.
Since the new timing harness also measures scalability
under parallel load, the \*[lmbench3] STREAM
benchmarks include this capability automatically.  
.LP
Finally, \*[lmbench3] includes a number of new
benchmarks which measure various aspects of the
processor architecture, such as basic operation
latency and parallelism, to provide developers
with a better understanding of system capabilities.
The hope is that better informed developers will
be able to better design and evaluate performance
critical software in light of their increased
understanding of basic system performance.
.NH 1
Prior Work
.LP
Benchmarking is not a new field of endeavor.
There are a wide variety of approaches to 
benchmarking, many of which differ greatly
from that taken by \*[lmbench].  
.LP
One common form of benchmark is to take an
important application or application and
worklist, and to measure the time required
to complete the entire task.  
This approach is particularly useful when 
evaluating the utility of systems for a 
single and well-known task.
.LP
Other benchmarks, such as SPECint, use a
variation on this approach by measuring
several applications and combining the
results to predict overall performance.
.\" .LP
.\" XXX Byte benchmark
.LP
Another variation takes the "kernel" of
an important application and measures its
performance, where the "kernel" is usually
a simplification of the most expensive
portion of a program.  
Dhrystone 
.RN Weicker84
is an example of this type of
benchmark as it measures the performance
of important matrix operations and was often
used to predict system performance for
numerical operations.
.LP
.RN Banga98
developed a benchmark to measure HTTP server
performance which can accurately measure
server performance under high load.
Due to the idiosyncracies of the HTTP protocol 
and TCP design and implementation, there are 
generally operating system limits on the rate 
at which a single system can generate 
independent HTTP requests.  
However, 
.RN Banga98
developed a system which can scalably present
load to HTTP servers in spite of this limitation.
.LP
John McCalpin's STREAM benchmark measures
memory bandwidth during four common vector
operations
.RN McCalpin95 .
It does not measure memory latency, and
strictly speaking it does not measure raw
memory bandwith although memory bandwidth
is crucial to STREAM performance.
More recently, work has begun on extending
STREAM to measure scalable memory subsystem
performance, particularly for multi-processor
machines.
.LP
Uros Prestor
.RN Prestor01
XXX
.LP
Micro-benchmarking extends this "kernel" 
approach, by measuring the performance
of operations or resources in isolation.
\*[lmbench] and many other benchmarks, such 
as nfsstone
.RN Shein89 ,
measure the performance of key operations so 
users can predict performance for certain 
workloads and applications by combining the 
performance of these operations in the right 
mixture.
.LP
.RN Saavedra92
takes the micro-benchmark approach and applies
it to the problem of predicting application
performance. 
They analyze applications or other benchmarks
in terms of their ``narrow spectrum benchmarks''
to create a linear model of the application's
computing requirements.  
They then measure the computer system's 
performance across this set of micro-benchmarks
and use a linear model to predict the application's
performance on the computer system.
.RN Seltzer99
applied this technique using the features
measured by \*[lmbench] as the basis for
application prediction.
.LP
Benchmarking I/O systems has proven particularly
troublesome over the years, largely due to the
strong non-linearities exhibited by disk systems.
Sequential I/O provides much higher bandwidth
than non-sequential I/O, so performance is 
highly dependent on the workload characteristics
as well as the file system's ability to 
capitalize on available sequentiality by
laying out data contiguously on disk.
.LP
I/O benchmarks have a tendency to age poorly.
For example, IOStone
.RN Park90a ,
IOBench
.RN Wolman89 ,
and the Andrew benchmark
.RN Howard88
used fixed size datasets, whose size was
significant at the time, but which no longer
measure I/O performance as the data can now
fit in the processor cache of many modern
machines.
.LP
The Andrew benchmark attempts to separately
measure the time to create, write, re-read, 
and then delete a large number of files in
a hierarchical file system.  
.LP
Bonnie
.RN Bray90
measures sequential, streaming I/O bandwidth
for a single process, and random I/O latency
for multiple processes.  
.LP
Peter Chen developed an adaptive harness for
I/O benchmarking
.RN Chen94a ,
which defines I/O load in terms of five parameters,
uniqueBytes, sizeMean, readFrac, seqFrac, and
processNum.  The benchmark then explores the
parameter space to measure file system performance
in a scalable fashion.
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
Memory Hierarchy
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
the size
.RN Hennessy96 .
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
.NH 1
Timing Harness
.LP
The first, and most crucial element in extending
\*[lmbench2] so that it could measure scalable
performance, was to develop a new timing harness
that could accurately measure performance for
any given load.
Once this was done, then each benchmark would
be migrated to the new timing harness.
.LP
The harness is designed to accomplish a number
of goals:
.IP 1.
during any timing interval of any child it is
guaranteed that all other child processes are
also running the benchmark
.IP 2.
the timing intervals are long enough to average
out most transient OS scheduler affects
.IP 3.
the timing intervals are long enough to ensure
that error due to clock resolution is negligible
.IP 4.
timing measurements can be postponed to allow
the OS scheduler to settle and adjust to the
load
.IP 5.
the reported results should be representative 
and the data analysis should be robust
.IP 6.
timing intervals should be as short as possible
while ensuring accurate results
.LP
Developing an accurate timing harness with a
valid experimental design is more difficult 
than is generally supposed.
Many programs incorporate elementary timing
harnesses which may suffer from one or more
defects, such as insufficient care taken to
ensure that the benchmarked operation is run
long enough to ensure that the error introduced 
by the clock resolution is insignificant.
The basic elements of a good timing harness
are discussed in 
.RN Staelin98 .
.LP
The new timing harness must also collect and process
the timing results from all the child processes so
that it can report the representative performance.
It currently reports the median performance over
all timing intervals from all child processes.  It
might perhaps be argued that it should report the
median of the medians.
.LP
Most of the benchmarks now accept a "-P <parallelism>"
flag, and the timing harness does the right thing to
try and measure parallel application performance.
.LP
When running benchmarks with more than one child,
the harness must first get a baseline estimate
of performance by running the benchmark in only
one process using the standard \*[lmbench] timing
interval, which is often 5,000 micro-seconds.
Using this information, the harness can compute
the average time per iteration for a single
process, and it uses this figure to compute the
number of iterations necessary to ensure that
each child runs for at least one second.
.NH 2
Clock resolution
.LP
\*[lmbench] uses the \*[gettimeofday] clock, whose 
interface resolves time down to 1 micro-second.  
However, many system clock's resolution is only 10 
milli-seconds, and there is no portable way to query 
the system to discover the true clock resolution.
.LP
The problem is that the timing intervals must
be substantially larger than the clock resolution
in order to ensure that the timing error doesn't
impact the results.  For example, the true duration
of an event measured with a 10 milli-second clock
can vary $+-$10 milli-seconds from the true time,
assuming that the reported time is always a
truncated version of the true time.  If the clock
itself is not updated precisely, the true error
can be even larger.  
This implies that timing intervals on these systems
should be at least 1 second.
.LP
However, the \*[gettimeofday] clock resolution in
most modern systems is 1 micro-second, so timing
intervals can as small as a few milli-seconds
without incurring significant timing errors related
to clock resolution.
.LP
Since there is no standard interface to query the operating
system for the clock resolution, \*[lmbench] must 
experimentally determine the appropriate timing 
interval duration which provides results in a timely 
fashion with a negligible clock resolution error.
.NH 2
Coordination
.LP
Developing a timing harness that correctly manages 
$N$ processes and accurately measures system performance 
over those same $N$ processes is significantly more difficult
than simply measuring system performance with a single
process because of the asynchronous nature of
parallel programming.
.LP
In essence, the new timing harness needs to create
$N$ jobs, and measure the average performance of the
target subsystem while all $N$ jobs are running.  This
is a standard problem for parallel and distributed
programming, and involves starting the child
processes and then stepping through a handshaking
process to ensure that all children have started
executing the benchmarked operation before any child
starts taking measurements.
.TSTART 1
.TS
box tab (/) allbox expand ;
c c
l l .
Parent/Child
T{
start up P child processes
T}/T{
run benchmark operation for a little while
T}
T{
wait for P "ready" signals
T}/T{
send a "ready" signal
T}
T{
[sleep for "warmup" microseconds]
T}/T{
run benchmark operation while polling for a "go" signal
T}
T{
send "go" signal to P children
T}/T{
begin timing benchmark operation
T}
T{
wait for P "done" signals
T}/T{
send a "done" signal
T}
T{
for each child, send "results" signal and gather results
T}/T{
run benchmark operation while polling for a "results" signal
T}
T{
collate results
T}/T{
send timing results and wait for "exit" signal
T}
T{
send "exit" signal
T}/T{
exit
T}
.TE
.TEND "Timing harness sequencing"
.LP
Table \n[TABLE] shows how the parent and child
processes coordinate their activities to ensure
that all children are actively running the
benchmark activity while any child could be
taking timing measurements.
.LP
.NH 2
Accuracy
.LP
The new timing harness also needs to ensure that the 
timing intervals are long enough for the results to 
be representative.  The previous timing harness assumed
that only single process results were important, and
it was able to use timing intervals as short as
possible while ensuring that errors introduced by
the clock resolution were negligible.  
In many instances this meant that the timing intervals 
were smaller than a single scheduler time slice.  
The new timing harness must run benchmarked items 
long enough to ensure that timing intervals are longer
than a single scheduler time slice.
Otherwise, you can get results which are complete nonsense.  
For example, running several copies of an \*[lmbench2] 
benchmark on a uni-processor machine will often report 
that the performance with $N$ jobs running in parallel 
is equivalent to the performance with a single job running!\**
.FS
This was discovered by someone who naively attempted
to parallelize \*[lmbench2] in this fashion, and I
received a note from the dismayed developer describing
the failed experiment.
.FE
.LP
In addition, since the timing intervals now have to be
longer than a single scheduler time slice, they also
need to be long enough so that a single scheduler time
slice is insignificant compared to the timing interval.
Otherwise the timing results can be dramatically 
affected by small variations in the scheduler's
behavior.
.NH 2
Resource consumption
.LP
One important design goal was that resource consumption
be constant with respect to the number of child
processes.  
This is why the harness uses shared pipes to communicate
with the children, rather than having a separate set of
pipes to communicate with each child.
An early design of the system utilized a pair of pipes
per child for communication and synchronization between
the master and slave processes.  However, as the number
of child processes grew, the fraction of system 
resources consumed by the harness grew and the additional
system overhead could start to interfere with the accuracy 
of the measurements.
.LP
Additionally, if the master has to poll (\*[select])
$N$ pipes, then the system overhead of that operation
also scales with the number of children.  
.NH 2
Pipe atomicity
.LP
Since all communication between the master process and
the slave (child) processes is done via a set of shared
pipes, we have to ensure that we never have a situation
where the message can be garbled by the intermingling
of two separate messages from two separate children.
This is ensured by either using pipe operations that
are guaranteed to be atomic on all machines, or by
coordinating between processes so that at most one
process is writing at a time.
.LP
The atomicity guarantees are provided by having each
client communicate synchronization states in one-byte 
messages.  For example, the signals from the master
to each child are one-byte messages, so each child
only reads a single byte from the pipe.  Similarly,
the responses from the children back to the master
are also one-byte messages.  In this way no child
can receive partial messages, and no message can
be interleaved with any other message.
.LP
However, using this design means that we need to
have a separate pipe for each \fIbarrier\fR in
the process, so the master uses three pipes to
send messages to the children, namely: \fIstart_signal\fR,
\fIresult_signal\fR, and \fIexit_signal\fR.
If a single pipe was used for all three barrier events,
then it is possible for a child to miss a signal,
or if the signal is encoded into the message, 
then it is possible for a child to infinite loop
pulling a signal off the pipe, recognizing that
it has already received that signal so that it
needs to push it back into the pipe, and then
then re-receiving the same message it just re-sent.
.LP
However, all children share a single pipe to send
data back to the master process.  Usually the
messages on this pipe are single-byte signals,
such as \fIready\fR or \fIdone\fR.  However, the
timing data results need to be sent from the
children to the master and they are (much) larger
than a single-byte message.  In this case, the
timing harness sends a single-byte message on
the \fIresult_signal\fR channel, which can be
received by at most one child process.  This
child then knows that it has sole ownership of
the response pipe, and it writes its entire 
set of timing results to this pipe.  Once the
master has received all of the timing results
from a single child, it sends the next one-byte
message on the \fIresult_signal\fR channel to
gather the next set of timing results.
.TSTART 1
.so lmbench3_signals.pic
.FEND "Control signals" 1
.LP
The design of the signals is shown in Figure \n[FIGURE].
.NH 2
Benchmark initialization
.LP
By allowing the benchmark to specify an
initialization routine that is run in the
child processes, the new timing harness
allows benchmarks to do either or both
global initializations that are shared
by all children and specific per-child
initializations that are done independently
by each child.
Global initialization is done in the
master process before the \*[benchmp] 
harness is called, so the state is 
preserved across the \*[fork] operations.
Per-child initialization is done inside
the \*[benchmp] harness by the optional
initialization routine and is done after
the \*[fork] operation.
.LP
Similarly, each benchmark is allowed to
specify a cleanup routine that is run by
the child processes just before exiting.
This allows the benchmark routines to
release any resources that they may have
used during the benchmark.
Most system resources would be automatically
released on process exit, such as file
descriptors and shared memory segments,
but some resources such as temporary files
might need to be explicitly released by
the benchmark.
.NH 2
Scheduler transients
.LP
Particularly on multi-processor systems, side-effects
of process migration can dramatically affect program 
runtimes.  For example, if the processes are all
initially assigned to the same processor as the parent
process, and the timing is done before the scheduler
migrates the processes to other available processors,
then the system performance will appear to be that of
a uniprocessor.  Similarly, if the scheduler is
over-enthusiastic about re-assigning processes to
processors, then performance will be worse than
necessary because the processes will keep encountering
cold caches and will pay exhorbitant memory access
costs.
.LP
The first case is a scheduler transient, and users
may not want to measure such transient phenomena
if their primary interest is in predicting performance
for long-running programs.  Conversely, that same
user would be extraordinarily interested in the
second phenomena.  The harness was designed to
allow users to specify that the benchmarked processes
are run for long enough to (hopefully) get the
scheduler past the transient startup phase, so it
can measure the steady-state behavior.
.NH 2
Data analysis
.LP
Analyzing the data to produce representative results
is a crucial step in the benchmarking process.  
\*[lmbench] generally reports the \fImedian\fP
result for $11$ measurements.  
Most benchmarks report the results of a single measurement
.RN Howard88 ,
an average of several results
.RN McCalpin95 ,
or a trimmed mean
.RN Brown97 .
XXX UNKNOWN:
.RN Weicker84,Shein89,Park,Wolman89,Banga97,Saavedra92,Chen94a,Bray90
.LP
Since \*[lmbench] is able to use timing intervals
that are often smaller than a scheduler time slice,
the raw timing results are often severely skewed.
The median is preferable to the mean when the data
can be very skewed
.RN Jain91 .
.LP
In some instances, however, \*[lmbench] internally
uses the \fIminimum\fP rather than the median, 
such as in \*[mhz].  
In those instances, we are not trying to find the 
\fIrepresentative\fP value, but rather the 
\fIminimum\fP value.
There are only a few sources of error which could
cause a the measured timing result to be shorter 
than the true elapsed time: the system clock is
adjusted, or round-off error in the clock resolution.
The timing interval duration is set to ensure that
the round-off error is bounded to 1% of the timing
interval, and we blithely assume that people don't
reset their system clocks while benchmarking their
systems.
.LP
\*[lmbench] does not currently report any statistics
representing measurement variation, such as the 
difference between the first and third quartiles.
.NH 1
Interface
.LP
Unfortunately we had to move away from the
macro-based timing harness used in \*[lmbench2] 
and migrate to a function-based system.  
.LP
The new interface looks like:
.DS
typedef void (*bench_f)(uint64 iterations, 
			void* cookie);
typedef void (*support_f)(void* cookie);

extern void benchmp(support_f initialize,
		bench_f benchmark,
		support_f cleanup,
		int enough,
		int parallel,
		int warmup,
		int repetitions,
		void* cookie);
.DE
.LP
A brief description of the parameters:
.IP \fIenough\fR
Enough can be used to ensure that a timing interval is at
least 'enough' microseconds in duration.  For most benchmarks
this should be zero, but some benchmarks have to run for more
time due to startup effects or other strange behavior.
.IP \fIparallel\fR
is simply the number of instances of the benchmark
that will be run in parallel on the system.  
.IP \fIwarmup\fR
can be used to force the benchmark to run for warmup
microseconds before the system starts making timing measurements.
Note that it is a lower bound, not a fixed value, since it
is simply the time that the parent sleeps after receiving the
last "ready" signal from each child (and before it sends 
the "go" signal to the children).  
.IP \fIrepetitions\fR
is the number of times the experiment should
be repeated.  The default is eleven.
.IP \fIcookie\fR
is a pointer that can be used by the benchmark
writer to pass in configuration information, such as buffer
size or other parameters needed by the inner loop.  
In \*[lmbench3] it is generally used to point
to a structure containing the relevant configuration
information.
.LP
To write a simple benchmark for getppid() all you would need
to do is:
.DS
void
benchmark_getppid(uint64 iterations, 
			void* cookie)
{
	while (iterations-- > 0) {
		getppid();
	}
}
.DE
.LP
and then somewhere in your program you might call:
.DS
benchmp(NULL, benchmark_getppid, NULL, 
	0, 1, 0, NULL);
micro("getppid", get_n());
.DE
.LP
A more complex example which has "state" and uses the 
initialization and cleanup capabilities might look something
like this:
.DS
struct bcopy_state {
	int len;
	char* src;
	char* dst;
};
.DE
.DS
void
initialize_bcopy(void* cookie)
{
	struct bcopy_state* state = 
		(struct bcopy_state*)cookie;

	state->src = valloc(state->len);
	state->dst = valloc(state->len);

	bzero(src, state->len);
	bzero(src, state->len);
}
.DE
.DS
void
benchmark_bcopy(uint64 iterations, 
		void* cookie)
{
	struct bcopy_state* state = 
		(struct bcopy_state*)cookie;

	while (iterations-- > 0) {
		bcopy(state->src, 
		      state->dst, state->len);
	}
}
.DE
.DS
void
cleanup_bcopy(void* cookie)
{
	struct bcopy_state* state = 
		(struct bcopy_state*)cookie;

	free(state->src);
	free(state->dst);
}
.DE
.LP
and then your program look something like:
.DS
#include "bench.h"
int
main()
{
	struct bcopy_state state;

	state.len = 8 * 1024 * 1024;
	benchmp(initialize_bcopy, 
		benchmark_bcopy, 
		cleanup_bcopy, 
		0, 1, 0, TRIES, &state);
	fprintf(stderr, "bcopy: ");
	mb(state.len * get_n());
	exit(0);
}
.DE
.LP
Note that this particular micro-benchmark would measure
cache-to-cache \*[bcopy] performance unless the amount of
memory being copied was larger than half the cache size.
A slightly more sophisticated approach might allocate
as much memory as possible and then \*[bcopy] from one
segment to another, changing segments within the allocated
memory before each \*[bcopy] to defeat the caches.
.NH 1
Benchmarks
.LP
\*[lmbench] contains a large number of micro-benchmarks
that measure various aspects of hardware and operating
system performance.  The benchmarks generally measure
latency or bandwidth, but some new benchmarks also
measure parallelism.
.TSTART
.TS
center box tab (&);
c c 
l & l .
Name&Measures
_
&Bandwidth
bw_file_rd&T{
\*[read] and then load into processor
T}
bw_mem&T{
read, write, and copy data to/from memory
T}
bw_mmap_rd&read from \*[mmap]'ed memory
bw_pipe&\*[pipe] inter-process data copy
bw_tcp&TCP inter-process data copy
bw_unix&UNIX inter-process
_
&Latency
lat_connect&TCP socket connection
lat_ctx&T{
context switch via \*[pipe]-based ``hot-potato'' token passing
T}
lat_fcntl&\*[fcntl] operation
lat_fifo&T{
FIFO ``hot-potato'' token passing
T}
lat_fs&file creation and deletion
lat_http&http GET request latency
lat_mem_rd&memory read
lat_mmap&\*[mmap] operation
lat_ops&basic operations
lat_pagefault&page fault handler
lat_pipe&\*[pipe] ``hot-potato'' token passing
lat_proc&T{
procedure call overhead and process creation using \*[fork],
\*[fork] and \*[execve], and \*[fork] and \*[sh]
T}
lat_rpc&SUN RPC procedure call
lat_select&\*[select]
lat_sem&T{
semaphore ``hot-potato'' token passing
T}
lat_sig&T{
signal handle installation and handling
T}
lat_syscall&\*[getppid], \*[write], \*[stat], \*[fstat], \*[open], \*[close]
lat_tcp&TCP ``hot-potato'' token passing
lat_udp&UDP ``hot-potato'' token passing
lat_unix&UNIX ``hot-potato'' token passing
lat_unix_connect&UNIX socket connection
_
&Parallelism
par_mem&memory subsystem
par_ops&T{
instruction-level parallelism of basic arithmetic operations
T}
_
mhz&CPU clock frequency
line&cache line size
tlb&number of pages mapped by TLB
stream&STREAM clones
lmdd&\fIdd\fR clone
.TE
.TEND "\*[lmbench] micro-benchmarks"
.LP
Table \n[TABLE] contains the full list of micro-benchmarks
in \*[lmbench].
.NH 2
Bandwidth
.LP
.LP
By bandwidth, we mean the rate at which a particular facility can move
data.  
We attempt to measure the data movement ability of a number of
different facilities:
library \*[bcopy],
hand-unrolled \*[bcopy],
direct-memory read and write (no copying),
pipes,
TCP sockets,
the \*[read] interface,
and
the \*[mmap] interface.
.NH 2
Memory bandwidth
.LP
Data movement is fundamental to any operating system.  
In the past, performance
was frequently measured in MFLOPS because floating point units were
slow enough that microprocessor systems were
rarely limited by memory bandwidth.  Today, floating point units are usually much
faster than memory bandwidth, so many current MFLOP ratings can not be 
maintained using memory-resident data; they are ``cache only'' ratings.
.LP
We measure the ability to
copy, read, and write data over a varying set of sizes.
There are too many results to report all of them here, so we concentrate on 
large memory transfers.
.LP
We measure copy bandwidth two ways.  The first is the user-level library
\*[bcopy] interface.
The second is a hand-unrolled loop that loads and stores
aligned 8-byte words.  
In both cases, we took care to
ensure that the source and destination locations would not map to the same
lines if the any of the caches were direct-mapped.  
In order to test memory bandwidth rather than cache bandwidth, 
both benchmarks copy an 8M\** area to another 8M area.  
(As secondary caches reach 16M, these benchmarks will have to
be resized to reduce caching effects.)
.FS
Some of the PCs had less than 16M of available memory;
those machines copied 4M. 
.FE
.LP
The copy results actually represent one-half to one-third of the memory
bandwidth used to obtain those results since we are reading and writing
memory.  If the cache line size is larger than the word stored, then
the written cache line will typically be read before it is written.  The
actual amount of memory bandwidth used varies because some architectures
have special instructions specifically designed for the \*[bcopy]
function.  Those architectures will move twice as much memory as
reported by this benchmark; less advanced architectures move three
times as much memory: the memory read, the memory read because it is
about to be overwritten, and the memory written.
.LP
The \*[bcopy] results reported in Table 2
may be correlated with John McCalpin's \*[stream]
.RN McCalpin95
benchmark results in the following manner:
the \*[stream] benchmark reports all of the memory moved
whereas the \*[bcopy] benchmark reports the bytes copied.  So our
numbers should be approximately one-half to one-third of his numbers.
.LP
Memory reading is measured by an unrolled loop that sums up a series of
integers.  On most (perhaps all) systems measured the integer
size is 4 bytes.  The loop is unrolled such that most compilers generate
code that uses a constant offset with the load, resulting in a load and
an add for each word of memory.  The add is an integer add that completes
in one cycle on all of the processors.  Given that today's processor 
typically cycles at 10 or fewer nanoseconds (ns) and that memory is typically 200-1,000
ns per cache line, the results reported here should be dominated by the
memory subsystem, not the processor add unit.
.LP
The memory contents are added up because almost all C compilers
would optimize out the whole loop when optimization was turned on, and
would generate far too many instructions without optimization.
The solution is to
add up the data and pass the result as an unused argument to the 
``finish timing'' function.  
.LP
Memory reads represent about one-third to one-half of the \*[bcopy] work, and we expect
that pure reads should run at roughly twice the speed of \*[bcopy].
Exceptions to this rule should be studied, for exceptions indicate a bug
in the benchmarks, a problem in \*[bcopy], or some unusual hardware.  
.TSTART
.so bw_allmem.tbl
.TEND "Memory bandwidth (MB/s)"
.LP
Memory writing is measured by an unrolled loop that stores a value into
an integer (typically a 4 byte integer) and then increments the pointer.
The processor cost of each memory operation is approximately the same
as the cost in the read case.
.LP
The numbers reported in Table \n[TABLE]
are not the raw hardware speed in some cases.
The Power2\** is capable of up to 800M/sec read rates 
.FS
Someone described this machine as a $1,000 processor on a $99,000 memory
subsystem.
.FE
.RN McCalpin95
and HP PA RISC (and other prefetching)
systems also do better if higher levels of code optimization used
and/or the code is hand tuned.
.LP
The Sun libc bcopy in Table \n[TABLE] 
is better because they use a hardware specific bcopy
routine that uses instructions new in SPARC V9 that were added specifically
for memory movement.
.LP
The Pentium Pro read rate in Table \n[TABLE] is much higher than the write rate because,
according to Intel, the write transaction turns into a read followed by
a write to maintain cache consistency for MP systems.
.NH 2
IPC bandwidth
.LP
Interprocess communication bandwidth is frequently a performance issue.
Many Unix applications are composed of several processes communicating
through pipes or TCP sockets.  Examples include the \f(CWgroff\fP documentation
system that prepared this paper, the \f(CWX Window System\fP, remote file access,
and \f(CWWorld Wide Web\fP servers.
.LP
Unix pipes are an interprocess communication mechanism implemented as 
a one-way byte stream. Each end of the stream has an associated file
descriptor; one is the write descriptor and the other the read
descriptor.
TCP sockets are similar
to pipes except they are bidirectional and can cross machine 
boundaries.
.LP
Pipe bandwidth is measured by creating two processes, a writer and a
reader, which transfer 50M of data in 64K transfers.
The transfer size was chosen so that the overhead of system calls
and context switching would not dominate the benchmark time.
The reader prints the timing results, which guarantees that all
data has been moved before the timing is finished.
.LP
TCP bandwidth is measured similarly, except the data is transferred in
1M page aligned transfers instead of 64K transfers.  If the TCP
implementation supports it, the send and receive socket buffers are
enlarged to 1M, instead of the default 4-60K.  We have found that
setting the transfer size equal to the socket buffer size produces the
greatest throughput over the most implementations.
.TSTART
.so bw_ipc.tbl
.TEND "Pipe and local TCP bandwidth (MB/s)"
.LP
\*[bcopy] is important to this test because the 
pipe write/read is typically implemented as a \*[bcopy] into the kernel
from the writer and then a \*[bcopy] from the kernel to the reader.  
Ideally, these results would be approximately one-half of the 
\*[bcopy] results.  It is possible for the kernel \*[bcopy]
to be faster than the C library \*[bcopy] since the kernel may have 
access to \*[bcopy] hardware unavailable to the C library.
.LP
It is interesting to compare pipes with TCP because the TCP benchmark is
identical to the pipe benchmark except for the transport mechanism.  
Ideally, the TCP bandwidth would be as good as the pipe
bandwidth.  It is not widely known that the
majority of the TCP cost is in the \*[bcopy], the checksum,
and the network interface driver. 
The checksum and the driver may be safely eliminated in the loopback
case and if the costs have been eliminated, then TCP should be just as
fast as pipes.  From the pipe and TCP results in Table \n[TABLE], it is easy to
see that Solaris and HP-UX have done this optimization.
.LP
Bcopy rates in Table \n[TABLE] can be lower than pipe rates because the
pipe transfers are done in 64K buffers, a size that frequently fits in
caches, while the bcopy is typically an 8M-to-8M copy, which does not
fit in the cache.
.LP
In Table \n[TABLE], the SGI Indigo2, a uniprocessor, does better than
the SGI MP on pipe bandwidth because of caching effects - in the UP
case, both processes share the cache; on the MP, each process is
communicating with a different cache.
.LP
All of the TCP results in Table \n[TABLE] are in loopback mode \(em that
is both ends of the socket are on the same machine.  It was impossible
to get remote networking results for all the machines included in this
paper.  We are interested in receiving more results for identical
machines with a dedicated network connecting them.  The results we have
for over the wire TCP bandwidth are shown below.
.TSTART
.so bw_tcp.tbl
.TEND "Remote TCP bandwidth (MB/s)"
.LP
The SGI using 100MB/s Hippi is by far the fastest in Table \n[TABLE].
The SGI Hippi interface has hardware support for TCP checksums and 
the IRIX operating system uses virtual memory tricks to avoid copying 
data as much as possible.
For larger transfers, SGI Hippi has reached 92MB/s over TCP.
.LP
100baseT is looking quite competitive when compared to FDDI in Table
\n[TABLE], even though FDDI has packets that are almost three times
larger.  We wonder how long it will be before we see gigabit ethernet
interfaces.
.NH 2
Cached I/O bandwidth
.LP
Experience has shown us that reusing data in the file system
page cache can be a performance issue.  This 
section measures that operation through two interfaces, \*[read] and
\*[mmap].   
The benchmark here is not an I/O benchmark in that no disk activity is
involved.
We wanted to measure the overhead
of reusing data, an overhead that is CPU intensive, rather than disk intensive.
.LP
The \*[read] interface copies data from the kernel's file system page cache into the
process's buffer, using 64K buffers.  The transfer size was chosen 
to minimize the kernel entry overhead while
remaining realistically sized.
.LP
The difference between the \*[bcopy] and the \*[read] benchmarks
is the cost of the file and virtual memory system overhead.  In most
systems, the \*[bcopy] speed should be faster than the \*[read] speed.  The
exceptions usually have hardware specifically designed
for the \*[bcopy] function and that hardware may be available only to
the operating system.  
.LP
The \*[read] benchmark is implemented by rereading a file
(typically 8M) in 64K
buffers.  Each buffer is summed as a series of integers in the user
process.  The summing is done for two reasons: for an apples-to-apples
comparison the memory-mapped benchmark needs to touch all the data,
and the file system can sometimes transfer data into memory faster than the
processor can read the data.
For example, \s-1SGI\s0's XFS can move data into memory at
rates in excess of 500M per second, but it can move data into
the cache at only 68M per second.  The intent is to measure performance
delivered to the application, not DMA performance to memory.
.TSTART
.so bw_reread2.tbl
.TEND "File vs. memory bandwidth (MB/s)"
.LP
The \*[mmap] interface provides a way to access the kernel's file cache 
without copying the data.  
The \*[mmap] benchmark is implemented by mapping the entire file (typically 8M)
into the
process's address space.  The file is then summed to force the data
into the cache.
.LP
In Table \n[TABLE], 
a good system will have \fIFile read\fP as fast as (or even faster than)
\fILibc bcopy\fP because as the file system overhead goes to zero, the
file reread case is virtually the same as the library \*[bcopy] case.
However, file reread can be faster because the kernel may have access to
\*[bcopy] assist hardware not available to the C library.  
Ideally, \fIFile mmap\fP performance should approach \fIMemory read\fP
performance, but \*[mmap] is often dramatically worse.  
Judging by the results, this looks to be a 
potential area for operating system improvements.
.LP
In Table \n[TABLE] the Power2 does better on file reread than bcopy because it takes
full advantage of the memory subsystem from inside the kernel.  
The mmap reread is probably slower because of the lower clock rate;
the page faults start to show up as a significant cost.   
.LP
It is surprising that the Sun Ultra1 was able to bcopy at the high
rates shown in Table 2 but did not show those rates for file reread
in Table \n[TABLE].
HP has the opposite problem, they get file reread faster than bcopy,
perhaps because the kernel \*[bcopy] has access to hardware support.
.LP
The Unixware system has outstanding mmap reread rates, better than
systems of substantially higher cost.  Linux needs to do some work on
the \f(CWmmap\fP code.
.NH 2
Latency
.LP
Latency is an often-overlooked
area of performance problems, possibly because resolving latency issues
is frequently much harder than resolving bandwidth issues.  For example,
memory bandwidth may be increased by making wider cache lines and increasing
memory ``width'' and interleave,
but memory latency can be improved only by shortening paths or increasing
(successful) prefetching.  
The first step toward improving latency is understanding the 
current latencies in a system.
.LP
The latency measurements included in this suite are
memory latency,
basic operating system entry cost,
signal handling cost,
process creation times,
context switching,
interprocess communication,
.\" virtual memory system latency,
file system latency, 
and disk latency.
.NH 2 
Memory read latency background
.LP
In this section, we expend considerable effort to define the different memory
latencies and to explain and justify our benchmark.
The background is a bit tedious but important, since we believe the
memory
latency measurements to be one of the most thought-provoking and useful
measurements in \*[lmbench].  
.LP
The most basic latency measurement is memory latency since most of
the other latency measurements can be expressed in terms of memory
latency.  For example, context switches require saving the current
process state and loading the state of the next process.  However, memory
latency is rarely accurately measured and frequently misunderstood.
.LP
Memory read latency has many definitions;
the most common,
in increasing time order,
are memory chip cycle time, processor-pins-to-memory-and-back time,
load-in-a-vacuum time, and back-to-back-load time.  
.BU "Memory chip cycle latency" :
Memory chips are rated in nanoseconds; typical speeds are around 60ns.
A general overview on DRAM architecture may be found in
.RN Hennessy96 .
The 
specific information we describe here is from 
.RN Toshiba94  
and pertains to the \s-1THM361020AS-60\s0 module and \s-1TC514400AJS\s0
\s-1DRAM\s0 used in \s-1SGI\s0 workstations.  The 60ns time is the
time from 
.ps -1
.nr width \w'R\&A\&S'
.nr height \n[rst]+1000
RAS\v'-\n[height]u'\h'-\n[width]u'\fB\l'\n[width]u'\fP\v'\n[height]u'
.ps
assertion to the when 
the data will be available on the \s-1DRAM\s0 pins (assuming 
.ps -1
.nr width \w'C\&A\&S'
.nr height \n[rst]+1000
CAS\v'-\n[height]u'\h'-\n[width]u'\fB\l'\n[width]u'\fP\v'\n[height]u'
.ps
access time requirements were met).
While it is possible
to get data out of a \s-1DRAM\s0 in 60ns, that is not all of
the time involved.  There is a precharge time that must occur after
every access.
.RN Toshiba94
quotes 110ns as the random read or write cycle time and this
time is more representative of the cycle time.  
.\" For example, most systems offer a wide range of memory 
.\" capacity, from 64MB to 1GB or more.  If 64MB simms are used, the number
.\" of simms range from 1 to 16.  The more simms there are, the more 
.\" capacitance there is in the memory subsystem.  More capacitance means
.\" longer setup times for the fully populated memory subsystem.  System
.\" designers have to allow time for this setup.
.\" For more details, consult [XXX - reference on DRAM].
.\" This is sometimes referred to as the chip latency.  The
.\" chip cycle time is the chip latency plus the time required to restore
.\" the data in the capacitors which is often referred to as the precharge
.\" time.  This means that 60 nanosecond memory chips really are more like
.\" 100 nanosecond memory chips.  Some systems operate memory in ``page
.\" mode'' or ``static column'' memory systems hold either RAS or CAS and
.\" allow subsequent accesses in the same row or column in one cycle instead
.\" of two.
.BU "Pin-to-pin latency" :
This number represents the time needed
for the memory request to travel from the processor's pins to the memory
subsystem and back again.  Many vendors have used the pin-to-pin
definition of memory latency in their reports.  For example, 
.RN Fenwick95 
while describing the \s-1DEC\s0 8400
quotes memory latencies of 265ns; a careful
reading of that paper shows that these are pin-to-pin numbers.  In spite
of the historical precedent in vendor reports, this definition of memory
latency is misleading since it ignores actual delays seen when a load
instruction is immediately followed by a use of the data being loaded.
The number of additional cycles inside the processor can be significant
and grows more significant with today's highly pipelined architectures.
.LP
It is worth noting that the pin-to-pin numbers 
include the amount of time it takes to charge
the lines going to the \s-1SIMM\s0s, a time that increases with the
(potential) number of \s-1SIMM\s0s in a system.  More \s-1SIMM\s0s mean
more capacitance which requires in longer charge times.  This is one reason
why personal computers frequently have better memory latencies than
workstations: the PCs typically have less memory capacity.
.BU "Load-in-a-vacuum latency" :
A load in a vacuum is the time that the processor will wait for one load that
must be fetched from main memory (i.e., a cache miss).  The ``vacuum'' 
means that there is no other activity on the system bus, including no other
loads.  
While this number is frequently used as the memory latency, it is not very
useful.  It is basically a ``not to exceed'' number important only for
marketing reasons.
Some architects point out that since most processors implement nonblocking
loads (the load does not cause a stall until the data is used), the perceived
load latency may be much less that the real latency.  When pressed, however,
most will admit that cache misses occur in bursts, resulting in perceived
latencies of at least the load-in-a-vacuum latency.
.BU "Back-to-back-load latency" :
Back-to-back-load latency is the time that each load takes, assuming
that the instructions before and after are also cache-missing loads.
Back-to-back loads may take longer than loads in a vacuum for the
following reason: many systems implement something known as \fIcritical
word first\fP, which means that the subblock of the cache line that
contains the word being loaded is delivered to the processor before the
entire cache line has been brought into the cache.  If another load
occurs quickly enough after the processor gets restarted from the
current load, the second load may stall because the cache is still
busy filling the cache line for the previous load.  On some systems,
such as the current implementation of UltraSPARC, 
the difference between back to back and load in a vacuum is about 35%.
.LP
\*[lmbench] measures back-to-back-load latency because it is the
only measurement that may be easily measured from software and
because we feel that it is what most software developers consider to be memory
latency.  Consider the following C code fragment:
.DS
.nf
.ft CW
p = head;
while (p->p_next)
	p = p->p_next;
.ft
.fi
.DE
On a \s-1DEC\s0 Alpha, the loop part turns into three instructions, including the
load.  A 300 Mhz processor has a 3.33ns cycle time, so the loop
could execute in slightly less than 10ns.  However, the load itself
takes 400ns on a 300 Mhz \s-1DEC\s0 8400.  In other words, the 
instructions cost 10ns but the load stalls for 400.  Another
way to look at it is that 400/3.3, or 121, nondependent,
nonloading instructions following the load would be needed 
to hide the load latency.  
Because superscalar processors typically execute multiple operations
per clock cycle, they need even more useful operations between cache
misses to keep the processor from stalling.
.LP
This benchmark illuminates the tradeoffs in processor cache design.
Architects like large cache lines, up to 64 bytes or so, because 
the prefetch effect of gathering a whole line increases
hit rate given reasonable spatial locality.
Small stride sizes have high spatial locality and should have higher
performance, but large stride sizes have poor spatial locality causing
the system to prefetch useless data.
So the benchmark provides the following insight into negative 
effects of large line prefetch:
.BU 
Multi-cycle fill operations are typically atomic events at the 
caches, and sometimes block other cache accesses until they
complete.
.BU
Caches are typically single-ported. Having a large line prefetch
of unused data causes extra bandwidth
demands at the cache, and can cause increased access latency for 
normal cache accesses.
.LP
In summary, we believe that processors are so fast that the average
load latency for cache misses will be closer to the
back-to-back-load number than to the load-in-a-vacuum number.  We are
hopeful that the industry will standardize on this definition of
memory latency.
.NH 2 
Memory read latency
.LP
The entire memory hierarchy can be measured, including on-board data 
cache latency and size, external data cache latency and size, and 
main memory latency.
Instruction caches are not measured.
TLB miss latency can also be measured, as in 
.RN Saavedra92 ,
but we stopped at main memory.  Measuring TLB miss time is problematic
because different systems map different amounts of memory with their 
TLB hardware.
.LP
The benchmark varies two parameters, array size and array stride.  
For each size, a list of pointers is created for all of the different 
strides.  Then the list is walked thus:
.DS
.ft CW
mov  r4,(r4)  # C code: p = *p;
.ft
.DE
The time to do about 1,000,000 loads (the list wraps) is measured and
reported.  The time reported is pure latency time and may be zero even though
the load instruction does not execute in zero time.  Zero is defined as one
clock cycle; in other words, the time reported is \fBonly\fP memory latency
time, as it does not include the instruction execution time.  It is assumed
that all processors can do a load instruction in one processor cycle 
(not counting stalls).  In other words, if the processor cache load time
is 60ns on a 20ns processor, the load latency reported
would be 40ns, the additional 20ns is for the load instruction
itself.\**
.FS
In retrospect, this was a bad idea because we calculate the clock
rate to get the instruction execution time.  If the clock rate is off,
so is the load time.
.FE
Processors that can manage to get the load address out to the 
address pins before the end of the load cycle get some free time in this
benchmark (we don't know of any processors that do that).
.LP
This benchmark has been validated by logic analyzer measurements
on an \s-1SGI\s0 Indy by Ron Minnich while he was at the Maryland Supercomputer
Research Center.
.TSTART 1
.so mem.pic
.FEND "Memory latency" 1
.LP
Results from the memory latency benchmark are plotted as a series of data sets
as shown in Figure \n[FIGURE].
Each data set represents a stride size,
with the array size varying from 512 bytes up to 8M or more.
The curves contain a series of 
horizontal plateaus, where each plateau represents a level in the
memory hierarchy.  
The point where each plateau ends and the line rises marks the
end of that portion of the memory hierarchy (e.g., external cache).  
Most machines have similar memory hierarchies:
on-board cache, external cache, main memory, and main memory plus TLB
miss costs.  
There are variations: some processors are missing a cache, while 
others add another cache to the hierarchy.
.\" XXX Larry please double-check this; I am going on dim memory...
For example, the Alpha 8400 has two on-board caches, one 8K
and the other 96K.
.LP
The cache line size can be derived by comparing curves and noticing which
strides are faster than main memory times.  The smallest stride that is
the same as main memory speed is likely to be the cache line size because
the strides that are faster than memory are
getting more than one hit per cache line.  
.\" Prefetching may confuse
.\" the issue because a demand read may stall behind a prefetch load,
.\" causing cache lines to appear twice as large as they are.
.\" XXX
.\" Larry --- can we use prime modulus arithmetic to set up pointer 
.\" loops which might appear random but which really aren't and which
.\" hit every stride once before looping?
.\"
.\" XXX
.\" Larry --- is there any way we can defeat/disable prefetching
.\" so the cache line size can be more accurately determined?
.\"
.\" XXX
.\" Larry --- can we create a benchmark for TLB misses?
.\" I think it was Tom Rokicki who suggested that we create a
.\" benchmark where the data fits in the cache, but the pages don't
.\" fit in the TLB.  
.\"
.\" XXX
.\" Larry --- is the description of the memory hierarchy correct?
.\" I am not sure I haven't added an extra level of external cache...
.EQ
delim $$
.EN
.LP
Figure \n[FIGURE] shows memory latencies on a nicely made machine,
a \s-1DEC\s0 Alpha.
We use this machine as the example 
because it shows the latencies and sizes of
the on-chip level 1 and motherboard level 2 caches, and because it
has good all-around numbers, especially considering it can support a
4M level 2 cache.
The on-board cache is $2 sup 13$ bytes or 8K, while the
external cache is $2 sup 19$ bytes or 512K.
.EQ
delim off
.EN
.TSTART
.so lat_allmem.tbl
.TEND "Cache and memory latency (ns)"
.nr MEMTABLE \n[TABLE]
.LP
Table \n[TABLE] shows the cache size, cache latency, and main memory
latency as extracted from the memory latency graphs.  
The graphs and the tools for extracting the data are 
included with \*[lmbench].  
It is worthwhile to plot all of the graphs and examine them since the
table is missing some details, such as the
\s-1DEC\s0 Alpha 8400 processor's second 96K on-chip cache.
.LP
We sorted Table \n[TABLE] on level 2 cache latency because we think
that many applications will fit in the level 2 cache.  The HP and IBM
systems have only one level of cache so we count that as both level 1
and level 2.  Those two systems have remarkable cache performance for
caches of that size.  In both cases, the cache delivers data in one
clock cycle after the load instruction.  
.LP
HP systems usually focus on
large caches as close as possible to the processor.  A older HP
multiprocessor system, the 9000/890, has a 4M, split I&D, direct mapped
cache with a 2K victim cache, accessible in one clock (16ns).\**  That system is
primarily a database server.  
.FS
The Usenix version of this paper had this as a set associate cache; that was
incorrect.
.FE
.LP
The IBM focus is on low latency, high
bandwidth memory.  The IBM memory subsystem is good because all of
memory is close to the processor, but has the weakness that it is
extremely difficult to evolve the design to a multiprocessor system.
.LP 
The 586 and PowerPC motherboards have quite poor second level caches,  
the caches are not substantially better than main memory.
.LP
The Pentium Pro and Sun Ultra second level caches are of medium speed 
at 5-6 clocks latency each.  5-6 clocks seems fast until it is compared
against the HP and IBM one cycle latency caches of similar size.  
Given the tight integration of the Pentium Pro level 2 cache, it is 
surprising that it has such high latencies.
.LP
The 300Mhz DEC Alpha has a rather high 22 clock latency to the second
level cache which is probably one of the reasons that they needed a 96K
level 1.5 cache.  SGI and DEC have used large second level caches
to hide their long latency from main memory.
.LP
.NH 2
Operating system entry
.LP
Entry into the operating system is required for many system facilities.  
When calculating the cost of a facility, it is useful to know how
expensive it is to perform a nontrivial entry into the operating system.
.LP
We measure nontrivial entry into the system by repeatedly writing one
word to \f(CW/dev/null\fP, a pseudo device driver that does nothing but
discard the data.   This particular entry point was chosen because it has
never been optimized in any system that we have measured.  Other entry
points, typically \*[getpid] and \*[gettimeofday], are heavily used,
heavily optimized, and sometimes implemented as user-level library
routines rather than system calls.  
A write to the \f(CW/dev/null\fP driver will go
through the system call table to \*[write], verify the user area as
readable, look up the file descriptor to get the vnode, call the vnode's
write function, and then return.  
.TSTART
.so lat_nullsys.tbl
.TEND "Simple system call time (microseconds)"
.LP
Linux is the clear winner in the system call time.  The reasons are
twofold: Linux is a uniprocessor operating system, without any
MP overhead, and Linux is a small operating system, without all
of the ``features'' accumulated by the commercial offers.
.LP
Unixware and Solaris are doing quite well, given that they are both fairly
large, commercially oriented operating systems with a large accumulation
of ``features.''
.NH 2
Signal handling cost
.LP
Signals in Unix are a way to tell another process to handle an event.  They
are to processes as interrupts are to the CPU.
.LP
Signal handling is often critical to layered systems.  Some applications,
such as databases, software development environments, and threading libraries
provide an operating system-like layer on top of the operating system,
making signal handling a critical path in many of these applications.
.LP
\*[lmbench] measure both signal installation and signal dispatching in two separate
loops, within the context of one process.
It measures signal handling by installing a signal handler and then repeatedly
sending itself the signal.   
.TSTART
.so lat_signal.tbl
.TEND "Signal times (microseconds)"
.LP
Table \n[TABLE] shows the signal handling costs.  
Note that there are no context switches in this benchmark; the signal goes
to the same process that generated the signal.  In real applications,
the signals usually go to another process, which implies
that the true cost of sending that signal is the signal overhead plus the
context switch overhead.  We wanted to measure signal and context
switch overheads separately since context
switch times vary widely among operating systems.
.LP
SGI does very well on signal processing,
especially since their hardware is of an older generation than
many of the others.  
.LP
The Linux/Alpha signal handling numbers are so poor
that we suspect that this is a bug, especially given that the Linux/x86
numbers are quite reasonable.
.NH 2
Process creation costs
.LP
Process benchmarks are used to measure the basic process primitives,
such as creating a new process, running a different program, and context
switching.  Process creation benchmarks are of particular interest
in distributed systems since many remote operations include the creation
of a remote process to shepherd the remote operation to completion.
Context switching is important for the same reasons.
.BU "Simple process creation" .
The Unix process creation primitive is \*[fork], which
creates a (virtually) exact copy of the calling process.
Unlike VMS and some other operating systems, Unix starts any new process
with a \*[fork].  
Consequently, \*[fork] and/or \f(CWexecve\fP should be fast and
``light,'' facts that many have been ignoring for some time.
.LP
\*[lmbench] measures simple process creation by creating a process 
and immediately
exiting the child process.  The parent process waits for the child
process to exit.   
The benchmark is intended to measure the overhead for creating a 
new thread of control, so it includes the \*[fork] and
the \*[exit] time.
.LP
The benchmark also includes a \f(CWwait\fP system call in the parent and
context switches from the parent to the child and back again.   Given that
context switches of this sort are on the order of 20 microseconds and a 
system call is on the order of 5 microseconds, and that the entire benchmark
time is on the order of a millisecond or more, the extra overhead
is insignificant.
Note that even this relatively simple task is very expensive and is
measured in milliseconds while most of the other operations we consider are
measured in microseconds.  
.BU "New process creation" .
The preceding benchmark did not create a new application; it created a
copy of the old application.   This benchmark measures the cost of creating a
new process and changing that process into a new application, which.  
forms the basis of every Unix command
line interface, or shell.  
\*[lmbench] measures this facility by forking a new child and having that child
execute a new program \(em in this case, a tiny program that prints 
``hello world'' and exits.
.LP
The startup cost is especially noticeable
on (some) systems that have shared libraries.  Shared libraries can
introduce a substantial (tens of milliseconds) startup cost.  
.\" XXX - statically linked example?
.TSTART
.so lat_allproc.tbl
.TEND "Process creation time (milliseconds)"
.BU "Complicated new process creation" .
When programs start other programs, they frequently use one of
three standard interfaces: \*[popen], \*[system], and/or \*[execlp].  The first
two interfaces start a new process by invoking the standard command
interpreter, \f(CW/bin/sh\fP, to start the process.  Starting programs this way
guarantees that the shell will look for the requested application
in all of the places that the user would look \(em in other words, the shell
uses the user's $PATH variable as a list of places to find the
application.  \*[execlp] is a C library routine which also looks for the
program using the user's $PATH variable.
.LP
Since this is a common way of starting applications, we felt it
was useful to show the costs of the generality.
.LP
We measure this by starting \f(CW/bin/sh\fP to start the same tiny 
program we ran in the last case.
In Table \n[TABLE] the cost of asking the shell to go 
look for the program is
quite large, frequently ten times as expensive as just creating a 
new process, and four times as expensive as explicitly naming the location
of the new program.
.LP
The results that stand out in Table \n[TABLE] are the poor Sun Ultra 1 results.
Given that the processor is one of the fastest, the problem is likely to be
software.  There is room for substantial improvement in the Solaris
process creation code.
.NH 2
Context switching
.LP
Context switch time is defined here as 
the time needed to save the state of one process and restore the state
of another process.  
.LP
Context switches are frequently in the critical performance path of 
distributed applications.  For example, the multiprocessor versions
of the IRIX operating system use
processes to move data through the networking stack.  This means that the
processing time for each new packet arriving at an idle system includes
the time needed to switch in the networking process.  
.LP
Typical context switch benchmarks measure just the minimal context switch
time \(em the time to switch between two processes that are doing nothing
but context switching.  We feel that this is
misleading because there are frequently more than two active processes,
and they usually have a larger working set (cache footprint)
than the benchmark processes.
.LP
Other benchmarks frequently include the cost of 
the system calls needed to force the context switches.  
For example, Ousterhout's context switch benchmark 
measures context switch time plus a \*[read] and a \*[write]
on a pipe.  
In many of the systems measured by \*[lmbench], the pipe overhead 
varies between 30% and 300% of the context switch time, so we were 
careful to factor out the pipe overhead.
.BU "Number of processes."
The context switch benchmark is implemented as 
a ring of two to twenty processes that are connected with Unix pipes.  
A token is passed from process to process, forcing context switches.  
The benchmark measures the time needed to pass
the token two thousand times from process to process.  
Each transfer of the token has two costs: the context switch, and
the overhead of passing the token.
In order to calculate just the context switching time, the benchmark first
measures the cost of passing the token through a ring of pipes in a
single process.  This overhead time is defined as the cost of passing
the token and is not included in the reported context switch time.
.BU "Size of processes."
In order to measure more realistic context switch times, we add
an artificial variable size ``cache footprint'' to the switching
processes.  The cost of the context switch then includes the cost
of restoring user-level state (cache footprint).  The cache footprint
is implemented by having the process allocate an array of data\**
.FS
All arrays are at the same virtual
address in all processes.
.FE
and sum
the array as a series of integers after receiving the token but before
passing the token to the next process.  Since most systems will cache data
across context switches, the working set for the benchmark is slightly 
larger than the number of processes times the array size.  
.LP
It is worthwhile to point out that the overhead mentioned above
also includes the cost of accessing the data, in the same way as
the actual benchmark.   However, because the overhead is measured
in a single process, the cost is typically the cost with ``hot''
caches.  In the Figure 2, each size is plotted as a line, with
context switch times on the Y axis, number of processes on the 
X axis, and the process size as the data set.
The process size and the hot cache overhead costs for
the pipe read/writes and any data access is what is labeled
as \f(CWsize=0KB overhead=10\fP.  The size is in kilobytes and the overhead
is in microseconds.
.LP
The context switch time does not include anything other than
the context switch, provided that all the benchmark processes fit in the
cache.  If the total size of all of the benchmark processes is larger
than the cache size,  the cost of each context switch will include cache
misses.
We are trying to show realistic context switch times as a
function of both size and number of processes.
.TSTART 1
.so ctx.pic
.FEND "Context switch times" 1
.LP
Results for an Intel Pentium Pro system running Linux at 167 MHz are
shown in Figure \n[FIGURE].
The data points on the figure are labeled with the working set
due to the sum of data in all of the processes.  The actual working set is
larger, as it includes the process and kernel overhead as well.  
One would expect the context switch times to stay constant until 
the working set is
approximately the size of the second level cache.  The Intel system has a 
256K second level cache, and the context switch times 
stay almost constant until about 256K (marked as .25M in the graph).
.BU "Cache issues"
The context switch benchmark is a deliberate measurement of the
effectiveness of the caches across process context switches.  If the
cache does not include the process identifier (PID, also sometimes
called an address space identifier) as part of the address, then the
cache must be flushed on every context switch.  If the cache does not map
the same virtual addresses from different processes to different cache
lines, then the cache will appear to be flushed on every context
switch.
.LP
If the caches do
not cache across context switches there would be no grouping at the
lower left corner of Figure \n[FIGURE], instead, the graph would
appear as a series of straight, horizontal, parallel lines.  The number
of processes will not matter, the two process case will be just as bad
as the twenty process case since the cache would not be
useful across context switches.
.TSTART
.so ctx.tbl
.TEND "Context switch time (microseconds)"
.LP
We picked four points on the graph and extracted those values for Table
\n[TABLE].  The complete set of values, as well as tools to graph them,
are included with \*[lmbench].
.LP
Note that multiprocessor context switch times are frequently more expensive
than uniprocessor context switch times.  This is because multiprocessor
operating systems tend to have very complicated scheduling code. 
We believe that multiprocessor context switch times can be, and should be,
within 10% of the uniprocessor times.
.LP
Linux does quite well on context switching, especially on the more
recent architectures.  By comparing the Linux 2 0K processes to the
Linux 2 32K processes, it is apparent that there is something wrong
with the Linux/i586 case.  If we look back to Table \n[MEMTABLE], we can
find at least part of the cause.  The second level cache latency for the
i586 is substantially worse than either the i686 or the Alpha.  
.LP
Given the poor second level cache behavior of the PowerPC, it is surprising
that it does so well on context switches, especially the larger sized cases.
.LP
The Sun Ultra1 context switches quite well in part because of enhancements
to the register window handling in SPARC V9.
.NH 2
Interprocess communication latencies
.LP
Interprocess communication latency is important because many operations
are control messages to another process (frequently on another
system).  The time to tell the remote process to
do something is pure overhead and is frequently in the critical path
of important functions such as distributed applications (e.g.,
databases, network servers).
.LP
The interprocess communication latency benchmarks typically have the 
following form: pass a small message (a byte or so) back and forth between two
processes.  The reported results are always the microseconds needed
to do one round trip.  For one way timing, 
about half the round trip is right.  However, the CPU cycles tend to be
somewhat asymmetric for one trip: receiving is typically more
expensive than sending.  
.BU "Pipe latency" .
Unix pipes are an interprocess communication mechanism implemented as 
a one-way byte stream.  Each end of the stream has an associated file
descriptor; one is the write descriptor and the other the read
descriptor.
.LP
Pipes are frequently used as a local IPC mechanism.  Because of the 
simplicity of pipes, they are frequently the fastest portable 
communication mechanism.
.LP
Pipe latency is measured by creating a pair of pipes, forking a child process,
and passing a word back and forth.  This benchmark is identical to the 
two-process, zero-sized context switch benchmark, except that it includes
both the context switching time and the pipe overhead in the results.
.nr NTABLE \n[TABLE]+1
.nr LTABLE \n[TABLE]
Table \n[NTABLE] shows the round trip latency from process A to process B
and back to process A.
.TSTART
.so lat_pipe.tbl
.TEND "Pipe latency (microseconds)"
.LP
The time can be broken down to two context switches plus four system calls
plus the pipe overhead.  The context switch component is two of the small
processes in Table \n[LTABLE].
This benchmark is identical to the context switch benchmark in
.RN Ousterhout90 .
.BU "TCP and RPC/TCP latency" .
TCP sockets may be viewed as an interprocess communication mechanism similar
to pipes with the added feature that TCP sockets work across machine 
boundaries.
.LP
TCP and RPC/TCP connections are frequently used in low-bandwidth, 
latency-sensitive applications.  The default Oracle distributed 
lock manager uses TCP sockets, and the locks per second available 
from this service are accurately modeled by the TCP latency test.
.TSTART
.so lat_tcp.tbl
.TEND "TCP latency (microseconds)"
.LP
Sun's RPC is layered either over TCP or over UDP.
The RPC layer is responsible for managing connections (the port mapper), 
managing different byte orders and word sizes (XDR), and implementing a 
remote procedure call abstraction.
Table \n[TABLE] shows the same benchmark with and
without the RPC layer to show the cost of the RPC implementation.
.LP
TCP latency is measured by having a server process that waits for connections
and a client process that connects to the server.  The two processes then
exchange a word between them in a loop.  The latency reported is one 
round-trip time.  The measurements in Table \n[TABLE] are local 
or loopback measurements, 
since our intent is to show the overhead of the software.  The same benchmark
may be, and frequently is, used to measure host-to-host latency.
.LP
Note that the RPC layer frequently adds hundreds of microseconds of
additional latency.  The problem is not the external data
representation (XDR) layer \(em the
data being passed back and forth is a byte, so there is no XDR to be done.
There is no justification for the extra cost; it is simply
an expensive implementation.  DCE RPC is worse.
.TSTART
.so lat_udp.tbl
.TEND "UDP latency (microseconds)"
.BU "UDP and RPC/UDP latency" .
UDP sockets are an alternative to TCP sockets.  They differ in that UDP
sockets are unreliable messages that leave the retransmission issues to
the application.  UDP sockets have a few advantages, however.  They preserve
message boundaries, whereas TCP does not; and a single UDP socket may 
send messages
to any number of other sockets, whereas TCP sends data to only one place.
.LP
UDP and RPC/UDP messages are commonly used in many client/server applications.
NFS is probably the most widely used RPC/UDP application in the world.
.LP
Like TCP latency, UDP latency is measured by having a server process 
that waits for connections
and a client process that connects to the server.  The two processes then
exchange a word between them in a loop.  The latency reported is round-trip
time.  The measurements in Table \n[TABLE] are local or loopback measurements,
since our intent is to show the overhead of the software.
Again, note that the RPC library can add hundreds of microseconds of extra
latency.  
.\" .LP
.\" It is interesting to compare UDP latency with TCP latency.  In many cases the
.\" TCP latency is \fBless\fP than the UDP latency.  This flies in the face
.\" of conventional wisdom, which says that TCP is an inherently more expensive
.\" protocol than UDP.  The reasons that TCP may appear faster are: in this
.\" benchmark, the protocol costs are dwarfed by the other costs (context
.\" switching, system calls, and driver overhead); and TCP is frequently
.\" hand-tuned for performance, while UDP is rarely hand-tuned.
.TSTART
.so lat_ipc.tbl
.TEND "Remote latencies (microseconds)"
.BU "Network latency" .
We have a few results for over the wire latency included in Table \n[TABLE].
As might be expected, the most heavily used network interfaces (i.e., ethernet)
have the lowest latencies.  The times shown include the time on the wire,
which is about 130 microseconds for 10Mbit ethernet, 13 microseconds for 100Mbit
ethernet and FDDI, and less than 10 microseconds for Hippi.
.BU "TCP connection latency" .
TCP is a connection-based, reliable, byte-stream-oriented protocol.  As
part of this reliability, a connection must be established before any
data can be transferred.  The connection is accomplished by a ``three-way
handshake,'' an exchange of packets when the client attempts to connect
to the server.
.LP
Unlike UDP, where no connection is established, TCP sends packets
at startup time.  If an application creates a TCP connection to send
one message, then the startup time can be a substantial
fraction of the total connection and transfer costs.   
The benchmark shows that the connection cost is approximately half of
the cost.  
.LP
Connection cost is measured by having a server, registered using
the port mapper, waiting for connections.  The client figures out where the
server is registered and then repeatedly times a \*[connect] system call to
the server.  The socket is closed after each connect.  Twenty connects
are completed and the fastest of them is used as the result.  The time measured
will include two of the three packets that make up the three way TCP handshake,
so the cost is actually greater than the times listed.
.\" XXX Larry --- if a machine's clock granularity is on the order of
.\" 10 milliseconds, won't this benchmark run into granularity problems?
.TSTART
.so lat_connect.tbl
.TEND "TCP connect latency (microseconds)"
.LP
Table \n[TABLE] shows that if the need is to send
a quick message to another process, given that most packets get through,
a UDP message will cost a \f(CWsend\fP and a \f(CWreply\fP (if positive
acknowledgments are needed, which they are in order to have an apples-to-apples 
comparison with TCP).  If the transmission medium is 10Mbit Ethernet, the
time on the wire will be approximately 65 microseconds each way, or 130
microseconds total.  To do the same thing with a short-lived TCP 
connection would cost 896 microseconds of wire time alone.
.LP
The comparison is not meant to disparage TCP; TCP is a useful protocol.  Nor
is the point to suggest that all messages should be UDP.  In many cases,
the difference between 130 microseconds and 900 microseconds is
insignificant compared with other aspects of application performance.
However, if the application is very latency sensitive
and the transmission medium is slow (such as serial link or a message
through many routers), then a UDP message may prove cheaper.
.NH 2 
File system latency
.LP
File system latency is defined as the time required to create or delete
a zero length file.  
We define it this way because in many file systems,
such as the BSD fast file system, the directory operations are done
synchronously in order to maintain on-disk integrity.  Since the 
file data is typically cached and sent to disk at some later date,
the file creation and deletion become the bottleneck
seen by an application.  This bottleneck is substantial: to do
a synchronous update to a disk is a matter of tens of milliseconds.
In many cases, this bottleneck is much more of a perceived performance
issue than processor speed.
.LP
The benchmark creates 1,000 zero-sized files and then deletes them.
All the files are created in one directory and their names are
short, such as "a", "b", "c", ... "aa", "ab", ....
.TSTART
.so lat_fs.tbl
.TEND "File system latency (microseconds)"
.LP
The create and delete latencies are shown in Table \n[TABLE].
Notice that Linux does extremely well here, 2 to 3 orders of magnitude faster
than the slowest systems.  However, Linux does not guarantee
anything about the disk integrity; the directory operations are done in
memory.  Other fast systems, such as SGI's XFS, use a log to guarantee the 
file system integrity.
The slower systems, all those with ~10 millisecond file latencies, are
using synchronous writes to guarantee the file system integrity.
Unless Unixware has modified UFS substantially, they must be running in
an unsafe mode since the FreeBSD UFS is much slower and both file
systems are basically the 4BSD fast file system.
.NH 2
Disk latency
.\" XXX - either get more results for this benchmark or delete it.
.\" I'd really like to not delete it - lmdd is probably the most
.\" useful tool and it gets the least press.
.LP
Included with \*[lmbench] is a small benchmarking program useful for
measuring disk and file I/O.  \*[lmdd], which is patterned after 
the Unix utility \f(CWdd\fP, measures both sequential and random I/O,
optionally generates patterns on output and checks them on input, 
supports flushing the data from the buffer cache on systems that 
support \f(CWmsync\fP, and has a very flexible user interface.  
Many I/O benchmarks can be trivially replaced with a \f(CWperl\fP script
wrapped around \*[lmdd].  
.LP
While we could have generated both sequential and random I/O results as
part of this paper, we did not because those benchmarks are heavily
influenced by the performance of the disk drives used in the test.  We
intentionally measure only the system overhead of a SCSI command since
that overhead may become a bottleneck in large database configurations.
.LP
Some important applications, such as transaction processing, are
limited by random disk IO latency.  
Administrators can increase the number of disk operations per
second by buying more disks, until the processor overhead becomes
the bottleneck.
The \*[lmdd] benchmark measures the processor overhead associated with each
disk operation, and it can provide an upper bound on the number of
disk operations the processor can support.
It is designed for SCSI disks, and it assumes that most
disks have 32-128K read-ahead buffers and that they can read ahead
faster than the processor can request the chunks of data.\**
.FS
This may not always be true: a processor could be fast enough to make the
requests faster than the rotating disk.  
If we take 6M/second to be disk
speed, and divide that by 512 (the minimum transfer size), that is 12,288 IOs/second, or
81 microseconds/IO.  We don't know of any processor/OS/IO controller
combinations that can do an IO in 81 microseconds.
.FE
.LP
The benchmark simulates a large number of disks by reading 512byte
transfers sequentially from the raw disk device (raw disks are unbuffered
and are not read ahead by Unix).  
Since the disk can read ahead faster than the system can request
data, the benchmark is doing small transfers of data from the
disk's track buffer.  
Another way to look at this is that the benchmark 
is doing memory-to-memory transfers across a SCSI channel.
It is possible to generate loads of more than 1,000 SCSI
operations/second on a single SCSI disk.  For comparison, disks under
database load typically run at 20-80 operations per second.
.TSTART
.so lat_disk.tbl
.TEND "SCSI I/O overhead (microseconds)"
.LP
The resulting overhead number represents a 
\fBlower\fP bound on the overhead of a disk I/O.  
The real overhead numbers will be higher on SCSI systems because
most SCSI controllers will not disconnect if the request can be
satisfied immediately.
During the benchmark, the processor simply sends the request and
transfers the data, while 
during normal operation, the processor will send the request,
disconnect, get interrupted, reconnect, and transfer the data.
.LP
This technique can be used to discover how many drives a system can support
before the system becomes CPU-limited because it can produce the
overhead load of a fully configured system with just a few disks.
.NH 2
Parallelism
.LP
description of parallelism benchmarks with sample results.
.NH 2
Other benchmarks
.LP
description of other benchmarks with sample results.
.NH 1
Scaling Benchmarks
.LP
There are a number of issues associated with converting
single-process benchmarks with a single process to 
scalable benchmarks with several independent processes,
in addition to the various issues addressed by
the timing harness.
Many of the benchmarks consume or utilize system
resources, such as memory or network bandwidth,
and a careful assessment of the likely resource
contention issues is necessary to ensure that the
benchmarks measure important aspects of system performance
and not artifacts of artificial resource contention.
.LP
For example, the Linux 2.2 kernel uses a single lock to
control access to the kernel data structures for a file.
This means that multiple processes accessing that file
will have their operations serialized by that lock.
.NH 2
File System
.LP
A number of the benchmarks measure aspects of file system
performance, such as \*[bw_file_rd], \*[bw_mmap_rd], 
\*[lat_mmap], and \*[lat_pagefault].
It is not immediately apparent how these benchmarks should
be extended to the parallel domain.  For example, it may
be important to know how file system performance scales
when multiple processes are reading the same file, or
when multiple processes are reading different files.
The first case might be important for large, distributed 
scientific calculations, while the second might be more 
important for a web server.
.LP
However, for the operating system, the two cases are
significantly different.  When multiple processes
access the same file, access to the kernel data 
structures for that file must be coordinated and
so contention and locking of those structures can
impact performance, while this is less true when
multiple processes access different files.
.LP
In addition, there are any number of issues associated
with ensuring that the benchmarks are either measuring
operating system overhead (e.g., that no I/O is actually
done to disk), or actually measuring the system's I/O
performance (e.g., that the data cannot be resident in
the buffer cache).  Especially with file system related
benchmarks, it is very easy to develop benchmarks that
compare apples and oranges (e.g., the benchmark includes
the time to flush data to disk on one system, but only
includes the time to flush a portion of data to disk on
another system).
.LP
\*[lmbench3] allows the user to measure either case
as controlled by a command-line switch.  When measuring
accesses to independent files, the benchmarks first
create their own private copies of the file, one for
each child process.  Then each process accesses its
private file.  When measuring accesses to a single
file, each child simply uses the designated file
directly.
.NH 2
Context Switching
.LP
Measuring context switching accurately is a difficult
task.  \*[lmbench1] and \*[lmbench2] measured context
switch times via a "hot-potato" approach using pipes
connected in a ring.  However, this experimental
design heavily favors schedulers that do "hand-off"
scheduling, since at most one process is active at
a time.
Consequently, it is not really a good benchmark
for measuring scheduler overhead in multi-processor
machines.
.LP
The design and methodology for measuring context
switching and scheduler overhead need to be revisited
so that it can more accurately measure performance
for multi-processor machines.
.NH 1
New Benchmarks
.LP
\*[lmbench3] also includes a number of
new benchmarks.
.NH 2
Stream
.LP
\*[lmbench3] includes a new micro-benchmark which
measures the performance of John McCalpin's \*[stream]
benchmark kernels for \*[stream] versions 1 and 2.
This benchmark faithfully recreates each of the
kernel operations from both \*[stream] benchmarks,
and because of the powerful new timing harness it
can easily measure memory system scalability.
.TSTART 1
.TS
center box tab (|);
c s s s s
c | c | c s | c
l | l | l | l | l .
Stream
_
Kernel|Code|Bytes|FL
||rd|wr|OPS
_
COPY|$a[i]=b[i]$|8(+8)|8|0
SCALE|$a[i]=q times b[i]$|8(+8)|8|1
ADD|$a[i]=b[i]+c[i]$|16(+8)|8|1
TRIAD|$a[i]=b[i]+q times c[i]$|16(+8)|8|2
.TE
.TS
center box tab (|);
c s s s s
c | c | c s | c
l | l | l | l | l .
Stream2
_
Kernel|Code|Bytes|FL
||rd|wr|OPS
_
FILL|$a[i]=q$|0(+8)|8|0
COPY|$a[i]=b[i]$|8(+8)|8|0
DAXPY|$a[i]=a[i]+q times b[i]$|16|8|2
SUM|$sum=sum + a[i]$|8|0|1
.TE
.TEND "Stream operations"
.LP
Table \n[TABLE] shows the four kernels for each version
of the \*[stream] benchmark.  Note that the
.I read
columns include numbers in parenthesis, which
represent the average number of bytes read into 
the cache as a result of the write to that
variable.  Cache lines are almost invariably
bigger than a single double, and so when a
write miss occurs the cache will read the line
from memory and then modify the selected bytes.
Sometimes vector instructions such as SSE
and 3DNow can avoid this load by writing an 
entire cache line at once.
.NH 2
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
.DS
#define TEN(a) a a a a a a a a a a
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
}
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
Results
.LP
Some sample results
.LP
bw_mem_rd performance vs. scaling on an SMP machine
.LP

.NH 1
Unscalable benchmarks
.LP
There are a number of benchmarks which either
did not make sense for scalable load, such as
\*[mhz], or which could not
be extended to measure scalable load due to
other constraints, such as \*[lat_connect].
.LP
\*[mhz] measures the processor clock speed,
which is not a scalable feature of the system,
so it doesn't make any sense to create a
version of it that measures scalable performance.
.LP
More specifically, \*[lat_connect] measures
the latency of connecting to a TCP socket.
TCP implementations have a timeout on
sockets and there is generally a fixed size
queue for sockets in the TIMEOUT state.  
This means that once the queue has been 
filled by a program connecting and closing
sockets as fast as possible, then all new
socket connections have to wait TIMEOUT
seconds.  Needless to say, this gives no
insight into the latency of socket creation
per se, but is rather a boring artifact.
Since the \*[lmbench2] version of the
benchmark can run for very short periods
of time, it generally does not run into
this problem and is able to correctly
measure TCP connection latency.  
.LP
Any scalable version of the benchmark needs 
each copy to run for at least a second, and 
there are $N$ copies creating connections as 
fast as possible, so it would essentially be
guaranteed to run into the TIMEOUT problem.
Consequently, \*[lat_connect] was not
enhanced to measure scalable performance.
.NH 1
A brief tutorial on memory design
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
exactly the same size as the cache size, then
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
other word, every fourth word, every eigth word, ...
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
chain will start to pay TLB-miss costs.  Depending on
the TLB replacement policy, the fraction of requests
generating TLB-misses in the second chain can vary
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
of such caches is insufficient.  Most caches are 
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
.DS
while (iterations-- > 0) {
	p0 = (char**)*p0;
	p1 = (char**)*p1;
}
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
Conclusion
.LP
\*[lmbench] is a useful, portable micro-benchmark 
suite designed to measure important aspects of 
system performance.
\*[lmbench3] adds a number of important extensions,
such as the ability to measure system scalability.
.NH 1
Acknowledgments
.LP
Many people have provided invaluable help and insight into both the
benchmarks themselves and the paper.  The \s-1USENIX\s0 reviewers
were especially helpful.
We thank all of them
and especially thank:
Wayne Scott \s-1(BitMover)\s0,
Larry McVoy \s-1(BitMover)\s0,
and
Bruce Chapman \s-1(SUN)\s0.
.LP
We would also like to thank all of the people that have run the
benchmark and contributed their results; none of this would have been possible
without their assistance.
.LP
Our thanks to 
all of the free software community for tools that were used during this
project.
\*[lmbench] is currently developed on Linux, a copylefted Unix written by 
Linus Torvalds and his band of happy hackers.
This paper and all of the 
\*[lmbench] documentation was produced using
the \f(CWgroff\fP suite of tools written by James Clark.
Finally, all of the data processing of the results is done with
\f(CWperl\fP written by Larry Wall.  
.NH 1
Obtaining the benchmarks
.LP
The benchmarks are available at
.ft I
http://ftp.bitmover.com/lmbench
.ft
.\" .R1
.\" bibliography references-lmbench3
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
database references-userguide
label-in-text
label A.nD.y-2
bracket-label [ ] ", "
bibliography references-userguide
.R2
.\" .so bios
