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
.\" .tl '\fBDRAFT\fP'\\*(DY'\fBDRAFT\fP'
.tl ''''
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
.tl ''Page %''
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
.ds micro \(*m
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
.ds close \f(CWclose\fP
.ds connect \f(CWconnect\fP
.ds dd \f(CWdd\fP
.ds execlp  \f(CWexeclp\fP
.ds execve  \f(CWexecve\fP
.ds exit \f(CWexit\fP
.ds fcntl \f(CWfcntl\fP
.ds fork \f(CWfork\fP
.ds fstat \f(CWfstat\fP
.ds gcc \f(CWgcc\fP
.ds get_n \f(CWget_n\fP
.ds getpid \f(CWgetpid\fP
.ds getppid \f(CWgetppid\fP
.ds gettime \f(CWgettime\fP
.ds gettimeofday \f(CWgettimeofday\fP
.ds kill \f(CWkill\fP
.ds lat_connect \f(CWlat_connect\fP
.ds lat_ctx \f(CWlat_ctx\fP
.ds lat_dram_page \f(CWlat_dram_page\fP
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
.ds lat_usleep \f(CWlat_usleep\fP
.ds line \f(CWline\fP
.ds lmdd  \f(CWlmdd\fP
.ds lmdd \f(CWlmdd\fP
.ds mb \f(CWmb\fP
.ds memmove \f(CWmemmove\fP
.ds mhz  \f(CWmhz\fP
.ds micro \f(CWmicro\fP
.ds mmap \f(CWmmap\fP
.ds nano \f(CWnano\fP
.ds nanosleep \f(CWnanosleep\fP
.ds open \f(CWopen\fP
.ds par_mem  \f(CWpar_mem\fP
.ds par_ops  \f(CWpar_ops\fP
.ds pipe  \f(CWpipe\fP
.ds popen  \f(CWpopen\fP
.ds pselect  \f(CWpselect\fP
.ds read \f(CWread\fP
.ds select  \f(CWselect\fP
.ds semop \f(CWsemop\fP
.ds setitimer \f(CWsetitimer\fP
.ds sh  \f(CW/bin/sh\fP
.ds stat \f(CWstat\fP
.ds stream \f(CWstream\fP
.ds system  \f(CWsystem\fP
.ds tlb \f(CWtlb\fP
.ds uiomove \f(CWuiomove\fP
.ds usleep \f(CWusleep\fP
.ds write \f(CWwrite\fP
.ds yield  \f(CWyield\fP
.\" References stuff
.R1
accumulate
sort A+DT
database references-lmbench3
label-in-text
bracket-label [ ] ", "
.R2
.EQ
delim $$
.EN
.TL
\s(14lmbench3: measuring scalability\s0
.AU
\s+2\fR\*[author]\fP\s0
.AI
\fI\s+2Hewlett-Packard Laboratories Israel\s0\fP
.SP
.AB
\*[lmbench3] extends the \*[lmbench2] 
system to measure a system's performance under scalable 
load to make it possible to assess parallel and 
distributed computer performance with the same
power and flexibility that \*[lmbench2] brought
to uni-processor performance analysis.
There is a new timing harness, \*[benchmp], designed 
to measure performance at specific levels of parallel 
(simultaneous) load, and most existing benchmarks have
been converted to use the new harness.
.SP
\*[lmbench] is a micro-benchmark suite designed to focus
attention on the basic building blocks of many
common system applications, such as databases, simulations, 
software development, and networking.  
It is also designed to make it easy for users to create
additional micro-benchmarks that can measure features, 
algorithms, or subsystems of particular interest to the
user.
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
Using this multi-dimensional performance analysis
approach, it is possible to better predict and 
understand application performance because
key aspects of application performance can often be
understood as linear combinations of the elements 
measured by \*[lmbench]
.[[
Brown97
.]].
.LP
\*[lmbench3] extends the \*[lmbench] suite to
encompass parallel and distributed system performance
by measuring system performance under scalable load.
This means that the user can specify the number of
processes that will be executing the benchmarked
feature in parallel during the measurements.
It is possible to utilize this framework to develop
benchmarks to measure distributed application
performance, but it is primarily intended to
measure the performance of multiple processes 
using the same system resource at the same time.
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
while he was at Sun Microsystems.
It focussed on two measures of system performance: 
latency and bandwidth.  
It measured a number of basic operating system 
functions, such as file system read/write bandwidth 
or file creation time.  
It also focussed a great deal of energy on measuring
data transfer operations, such as \*[bcopy] and
\*[pipe] latency and bandwidth as well as raw
memory latency and bandwidth.
.LP
Shortly after the \*[lmbench1] paper 
.[[
McVoy96
.]]
was published, Aaron Brown examined the \*[lmbench] 
benchmark suite and published a detailed critique 
of its strengths and weaknesses
.[[
Brown97
.]].
Largely in response to these remarks, development
of \*[lmbench2] began with a focus on improving the 
experimental design and statistical data analysis.  
The primary change was the development and adoption 
across all the benchmarks of a timing harness that 
incorporated loop-autosizing and clock resolution 
detection.  
In addition, each experiment was typically repeated 
eleven times with the median result reported to the 
user.
.LP
The \*[lmbench2]
.[[
Staelin98
.]]
timing harness was implemented through a new macro, 
BENCH(), that automatically manages nearly all aspects 
of accurately timing operations.
For example, it automatically detects the minimal timing 
interval necessary to provide timing results within 1% 
accuracy, and it automatically repeats most experiments 
eleven times and reports the median result.
.LP
\*[lmbench3] focussed on extending 
\*[lmbench]'s functionality along two dimensions:
measuring multi-processor scalability and measuring
basic aspects of processor micro-architecture.
.LP
An important feature of multi-processor systems is their
ability to scale their performance.  
While \*[lmbench1] and \*[lmbench2] measure various 
important aspects of system performance, they cannot
measure performance with more than one client process
active at a time.
Consequently, measuring performance of multi-processor
and clustered systems as a function of scalable load
was impossible using those tools.
.LP
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
SPEChpc96 
.[[
SPEChpc96
.]]
extends this approach to the
parallel and distributed domain by measuring
the performance of a selected parallel
applications built on top of MPI and/or PVM.
.\" .LP
.\" XXX Byte benchmark
.LP
Another variation takes the "kernel" of
an important application and measures its
performance, where the "kernel" is usually
a simplification of the most expensive
portion of a program.  
Dhrystone 
.[[
Weicker84
.]]
is an example of this type of
benchmark as it measures the performance
of important matrix operations and was often
used to predict system performance for
numerical operations.
.LP
Banga developed a benchmark to measure HTTP server
performance which can accurately measure
server performance under high load
.[[
Banga97
.]].
Due to the idiosyncracies of the HTTP protocol 
and TCP design and implementation, there are 
generally operating system limits on the rate 
at which a single system can generate 
independent HTTP requests.  
However, Banga developed a system which can 
scalably present load to HTTP servers in spite 
of this limitation
.[[
Banga98
.]].
.LP
John McCalpin's STREAM benchmark measures
memory bandwidth during four common vector
operations
.[[
McCalpin95
.]].
It does not measure memory latency, and
strictly speaking it does not measure raw
memory bandwith although memory bandwidth
is crucial to STREAM performance.
More recently, STREAM has been extended to
measure distributed application performance
using MPI to measure scalable memory subsystem
performance, particularly for multi-processor
machines.
.LP
Prestor
.[[
Prestor01
.]]
and Saavedra
.[[
Saavedra95
.]]
have developed benchmarks which analyze 
memory subsystem performance.
.LP
Micro-benchmarking extends the "kernel" 
approach, by measuring the performance
of operations or resources in isolation.
\*[lmbench] and many other benchmarks, such 
as nfsstone
.[[
Shein89
.]],
measure the performance of key operations so 
users can predict performance for certain 
workloads and applications by combining the 
performance of these operations in the right 
mixture.
.LP
Saavedra
.[[
Saavedra92
.]]
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
Seltzer
.[[
Seltzer99
.]]
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
.[[
Park90a
.]],
IOBench
.[[
Wolman89
.]],
and the Andrew benchmark
.[[
Howard88
.]]
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
.[[
Bray90
.]]
measures sequential, streaming I/O bandwidth
for a single process, and random I/O latency
for multiple processes.
.LP
Peter Chen developed an adaptive harness for
I/O benchmarking
.[[
Chen93d
.]]
.[[
Chen94a
.]],
which defines I/O load in terms of five parameters,
uniqueBytes, sizeMean, readFrac, seqFrac, and
processNum.  The benchmark then explores the
parameter space to measure file system performance
in a scalable fashion.
.LP
Parkbench
.[[
Parkbench
.]]
is a benchmark suite that can analyze parallel
and distributed computer performance.
It contains a variety of benchmarks that measure
both aspects of system performance, such as
communication overheads, and distributed application
kernel performance.
Parkbench contains benchmarks from both NAS
.[[
NAS
.]]
and Genesis
.[[
Glendinning94
.]].
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
Staelin
.[[
Staelin98
.]].
.LP
The new timing harness must also collect and process
the timing results from all the child processes so
that it can report the representative performance.
It currently reports the median performance over
all timing intervals from all child processes.  It
might perhaps be argued that it should report the
median of the medians.
.LP
When running benchmarks with more than one child,
the harness must first get a baseline estimate
of performance by running the benchmark in only
one process using the standard \*[lmbench] timing
interval, which is often 5,000 microseconds.
Using this information, the harness can compute
the average time per iteration for a single
process, and it uses this figure to compute the
number of iterations necessary to ensure that
each child runs for at least one second.
.NH 2
Clock resolution
.LP
\*[lmbench] uses the \*[gettimeofday] clock, whose 
interface resolves time down to 1 microsecond.  
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
most modern systems is 1 microsecond, so timing
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
.TSTART
.TS
box tab (/) box expand ;
c c
l l .
Parent/Child
T{
\(bu start up P child processes
T}/
T{
\(bu wait for P \fIready\fR signals
T}/T{
\(bu run benchmark operation for a little while
T}
\(da/T{
\(bu send a \fIready\fR signal
T}
T{
\(bu on reciept of \fIready\fR signals, sleep for \fIwarmup\fR \*[micro]s
T}/T{
\(bu run benchmark operation while polling for a \fIgo\fR signal
T}
T{
\(bu send \fIgo\fR signal to P children
T}/\(da
T{
\(bu wait for P \fIdone\fR signals
T}/T{
\(bu on receipt of \fIgo\fR signal, begin timing benchmark operation
T}
\(da/T{
\(bu send a \fIdone\fR signal
T}
T{
\(bu one receipt of \fIdone\fR signals, iterate through children 
sending \fIresults\fR signal and gathering results
T}/T{
\(bu run benchmark operation while polling for a \fIresults\fR signal
T}
T{
\(bu collate results
T}/T{
\(bu on receipt of \fIresults\fR signal, send timing results 
and wait for \fIexit\fR signal
T}
T{
\(bu send \fIexit\fR signal
T}/\(da
/T{
\(bu exit
T}
.TE
.TEND "Timing harness sequencing"
.nr TABLEseq \n[TABLE]
.LP
Table \n[TABLEseq] shows how the parent and child
processes coordinate their activities to ensure
that all children are actively running the
benchmark activity while any child could be
taking timing measurements.
.LP
The reason for the separate "exit" signal is
to ensure that all properly managed children
are alive until the parent allows them to die.
This means that any SIGCHLD events that occur
before the "exit" signal indicate a child 
failure.
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
The new timing harness must run benchmarked operations
long enough to ensure that timing intervals are longer
than a single scheduler time slice.
Otherwise, you can get results which are complete nonsense.  
For example, running several copies of an \*[lmbench2] 
benchmark on a uni-processor machine will often report 
that the per-process performance with $N$ jobs running in 
parallel is equivalent to the performance with a single 
job running!\**
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
.LP
Currently \*[lmbench] does not measure the scheduler
timeslice; the design blithely assumes that timeslices
are generally on the order of 10-20ms, so one second
timing intervals are sufficient.
Some schedulers may utilize longer time slices, but
this has not (yet) been a problem.
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
.nr FIGUREsig \n[FIGURE]
.LP
The design of the signals is shown in Figure \n[FIGUREsig].
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
.[[
Howard88
.]],
an average of several results
.[[
McCalpin95
.]],
or a trimmed mean
.[[
Brown97
.]].
.\" XXX UNKNOWN:
.\" .RN Weicker84,Shein89,Park,Wolman89,Banga97,Saavedra92,Chen94a,Bray90
.LP
Since \*[lmbench] is able to use timing intervals
that are often smaller than a scheduler time slice
when measuring single-process performance, the raw 
timing results are often severely skewed.
Often most results cluster around a single value
a small number of outliers with significantly
larger values.
The median is preferable to the mean when the data
can be very skewed
.[[
Jain91
.]].
Since the timing intervals are significantly longer
when the desired load is larger than a single
process, the results tend not to be as badly skewed.
In these cases we could use the \fImean\fR instead,
but we decide to use a uniform statistical framework,
so we usually use the median.
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
This is an enhancement under active consideration.
.NH 1
Interface
.LP
Unfortunately we had to move away from the
macro-based timing harness used in \*[lmbench2] 
and migrate to a function-based system
because the macros were too large for some
C pre-processors.
.TSTART 1
.DS L
\f(CWtypedef void (*bench_f)(iter_t iters,
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

extern uint64 gettime();
extern uint64 get_n();
extern void nano(char* s, uint64 n);
extern void micro(char* s, uint64 n);
extern void mb(uint64 bytes);\fP
.DE
.FEND "Programming interface" 1
.nr FIGinterface \n[FIGURE]
.LP
Figure \n[FIGinterface] shows the key elements
of the new timing harness and result reporting 
interface.
A brief description of the \*[benchmp] parameters:
.IP \fIenough\fR
Enough can be used to ensure that a timing interval is at
least 'enough' microseconds in duration.  For most benchmarks
this should be zero, but some benchmarks have to run for more
time due to startup effects or other transient behavior.
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
\*[gettime] returns the median timing
interval duration, while \*[get_n] returns
the number of iterations executed during
that timing interval.
.LP
\*[nano] and \*[micro] print the passed
string latency followed by the latency
in terms of nanoseconds and microseconds
respectively.
The latency is computed as $gettime()/n$,
where $n$ is the passed parameter.
The reason $n$ is passed as a parameter
is because the benchmark can actually
execute the operation of interest multiple
times during a single iteration.
For example, the memory latency benchmarks
typically repeat the memory load operation
a hundred times inside the loop, so the
actual number of operations is 
$100 times get_n()$, and it is this value
that should be passed to \*[nano] or \*[micro].
.LP
\*[mb] reports the bandwidth in MB/s
when given the total number of bytes
processed during the timing interval.
Note that for scalable benchmarks that
process $"size"$ bytes per iteration, the
total number of bytes processed is
$get_n() times parallel times "size"$.
.TSTART 1
.DS L
\f(CW#include "bench.h"

void
bench(iter_t iters, void* cookie)
{
	while (iters-- > 0) {
		getppid();
	}
}

int
main(int argc, char* argv[])
{
	benchmp(NULL, bench, NULL,
		0, 1, 0, TRIES, NULL);
	nano("getppid", get_n());
	return(0);
}\fP
.DE
.FEND "A sample benchmark" 1
.nr FIGsample \n[FIGURE]
.LP
Figure \n[FIGsample] shows a sample benchmark
that measures the latency of the \*[getppid]
system call using this timing harness.
Since there is no setup or cleanup needed
for this benchmark, the \fIinitialize\fR
and \fIcleanup\fR parameters are NULL.
The \fIbench\fR routine simply calls 
\*[getppid] as many times as requested,
and the rest of the parameters, \fIenough\fR,
\fIparallel\fR, \fIwarmup\fR, 
\fIrepetitions\fR, and \fIcookie\fR
are given with the default values.
.NH 1
Benchmarks
.LP
\*[lmbench] contains a large number of micro-benchmarks
that measure various aspects of hardware and operating
system performance.  The benchmarks generally measure
latency or bandwidth, but some new benchmarks also
measure instruction-level parallelism.
.TSTART
.TS
center box tab (&);
c c 
l & l .
Name&Measures
_
&\fBBandwidth\fR
\fIbw_file_rd\fR&T{
\*[read] and then load into processor
T}
\fIbw_mem\fR&T{
read, write, and copy data to/from memory
T}
\fIbw_mmap_rd\fR&read from \*[mmap]'ed memory
\fIbw_pipe\fR&\*[pipe] inter-process data copy
\fIbw_tcp\fR&TCP inter-process data copy
\fIbw_unix\fR&UNIX inter-process
_
&\fBLatency\fR
lat_connect&TCP connection
\fIlat_ctx\fR&T{
context switch via \*[pipe]-based ``hot-potato'' token passing
T}
lat_dram_page&T{
DRAM page open
T}
\fIlat_fcntl\fR&T{
\*[fcntl] file locking ``hot-potato'' token passing
T}
\fIlat_fifo\fR&T{
FIFO ``hot-potato'' token passing
T}
lat_fs&file creation and deletion
lat_http&http GET request latency
\fIlat_mem_rd\fR&memory read
\fIlat_mmap\fR&\*[mmap] operation
\fIlat_ops\fR&T{
basic operations (\fIxor\fR, \fIadd\fR, \fImul\fR, \fIdiv\fR, \fImod\fR)
on (relevant) basic data types (\fIint\fR, \fIint64\fR, \fIfloat\fR, 
\fIdouble\fR)
T}
\fIlat_pagefault\fR&page fault handler
\fIlat_pipe\fR&\*[pipe] ``hot-potato'' token passing
\fIlat_pmake\fR&T{
time to complete $N$ parallel jobs that each do $usecs$-worth of work
T}
\fIlat_proc\fR&T{
procedure call overhead and process creation using \*[fork],
\*[fork] and \*[execve], and \*[fork] and \*[sh]
T}
\fIlat_rand\fR&T{
random number generator
T}
\fIlat_rpc\fR&SUN RPC procedure call
\fIlat_select\fR&\*[select] operation
\fIlat_sem\fR&T{
semaphore ``hot-potato'' token passing
T}
\fIlat_sig\fR&T{
signal handle installation and handling
T}
\fIlat_syscall\fR&T{
\*[open], \*[close], \*[getppid], \*[write], \*[stat], \*[fstat]
T}
\fIlat_tcp\fR&TCP ``hot-potato'' token passing
\fIlat_udp\fR&UDP ``hot-potato'' token passing
\fIlat_unix\fR&UNIX ``hot-potato'' token passing
\fIlat_unix_connect\fR&UNIX socket connection
\fIlat_usleep\fR&T{
\*[usleep], \*[select], \*[pselect], \*[nanosleep], \*[setitimer] 
timer resolution
T}
_
&\fBOther\fR
disk&T{
zone bandwidths and seek times
T}
line&cache line size
lmdd&\fIdd\fR clone
par_mem&memory subsystem ILP
par_ops&basic operation ILP
\fIstream\fR&STREAM clones
tlb&TLB size
.TE
.TEND "\*[lmbench] micro-benchmarks"
.nr TABLEbench \n[TABLE]
.LP
Table \n[TABLEbench] contains the full list of micro-benchmarks
in \*[lmbench3].
Benchmarks that were converted to measure performance
under scalable load are shown in italics, while the
remaining benchmarks are shown with normal typeface.  
A detailed description of most benchmarks can be found in
.[[
McVoy96
.]].
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
For example, the Linux 2.2 and 2.4 kernels use a single lock to
control access to the kernel data structures for a file.
This means that multiple processes accessing that file
will have their operations serialized by that lock.
If one is interested in how well a system can handle
multiple independent accesses to separate files and
if the child processes all access the same file, then
this file sharing is an artificial source of contention
with potentially dramatic effects on the benchmark
results.
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
The design currently used in \*[lmbench3] is to
create $N$ \*[lmbench2]-style process rings and
to measure the context switch times with all $N$
rings running in parallel.
This does extend the \*[lmbench2] context switch
benchmark to a scalable form, but it still suffers
from the same weaknesses.
.LP
One approach that was considered was to replace
the ring with a star formation, so the master
process would send tokens to each child and
then wait for them all to be returned.  
This has the advantage that more than one process
is active at a time, reducing the sensitivity
to "hand-off" scheduling.
However, this same feature can cause problems
on a multi-processor system because several
of the context switches and working set accesses
can occur in parallel.
.LP
The design and methodology for measuring context
switching and scheduler overhead need to be revisited
so that it can more accurately measure performance
for multi-processor machines.
.NH 1
Stream
.LP
\*[lmbench3] includes a new micro-benchmark, 
\*[stream] which measures the performance of 
John McCalpin's STREAM benchmark kernels for 
both STREAM version 1 
.[[
McCalpin95
.]]
and version 2
.[[
McCalpin2002
.]].
This benchmark faithfully recreates each of the
kernel operations from both STREAM benchmarks,
and because of the powerful new timing harness it
can easily measure memory system scalability.
.TSTART
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
TRIAD|$a[i]=b[i]+q times c[i]$|16(+8)|8|2(-1)
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
DAXPY|$a[i]=a[i]+q times b[i]$|16|8|2(-1)
SUM|$sum=sum + a[i]$|8|0|1
.TE
.TEND "Stream operations"
.LP
Table \n[TABLE] is based on McCalpin's tables
.[[
McCalpin95
.]]
.[[
McCalpin2002
.]]
and shows the four kernels for each version
of the \*[stream] benchmark.  
Note that the
.I read
columns include numbers in parentheses, which
represent the average number of bytes read into 
the cache as a result of the write to that
variable\**.  
.FS
This number is independent of the cache
line size because the STREAM uses dense
arrays, so the cost is amortized over the
subsequent operations on the rest of the
line.
.FE
Cache lines are almost invariably
bigger than a single double, and so when a
write miss occurs the cache will read the line
from memory and then modify the selected bytes.
Sometimes vector instructions such as SSE
and 3DNow can avoid this load by writing an 
entire cache line at once.
.LP
In addition, some architectures support
multiply-add instructions which can do
both the multiply and add operations for
TRIAD and DAXPY in a single operation,
so the physical FLOPS count would be 1 
for these architectures on these
instructions.
The numbers in parenthesis in the
.I FLOPS
column reflect this reduction in
FLOPS count.
.LP
Following the STREAM bandwidth reporting
conventions, the \*[lmbench] STREAM benchmarks 
report their results as bandwidth results 
(MB/s) computed as a function of the amount 
of data explicitly read or written by the 
benchmark.  
For example, \fIcopy\fR and \fIscale\fR copy 
data from one array to the other, so the 
bandwidth is measured as a function of the 
amount of data read plus the amount of data 
written, or the sum of the two array sizes.
Similarly, \fIsum\fR, \fItriad\fR, and \fIdaxpy\fR
operate on three arrays, so the amount of data
transferred is the sum of the sizes of the three
arrays.
Note that the actual amount of data that is
transferred by the system may be larger 
because in the write path the cache may
need to fetch (read) the cache line before
a portion of it is overwritten by dirty data.
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
.LP
\*[lat_fs] has not yet been parallelized because
of the difficulty in measuring file creation and
file deletion times in the new timing harness.
The timing harness assumes that it can ask the
benchmarked operation to be repeated as many times
as necessary.
This would mean that the file creation benchmark
could create any number of new files of a given
size, which could well fill up the file system.
The real problem lies in the file deletion benchmark.
In order to delete files of a given size, they 
must have been created before the benchmark begins.
However, the number of files is not known in
advance, so the benchmark would have a difficult
time ensuring that it has created enough files.
.LP
The benchmarks that measure aspects of memory-subsystem 
micro-architecture, \*[lat_dram_page], \*[line], 
\*[par_mem], and \*[tlb], were not parallelized because 
the multiple processes' memory access patterns would 
likely interfere with one another.
For example, in \*[lat_dram_page], those accesses 
which were supposed to be to open DRAM pages could 
well be accessing closed DRAM pages, invalidating 
the benchmark.
.LP
\*[lmdd] was not parallelized because it is 
supposed to be a clone of \*[dd], and it
wasn't clear what a parallel form of \*[dd]
would look like.  
.NH 1
Results
.LP
The results presented here were obtained using
\*[lmbench] version 3.0-a2 under 
Linux 2.4.18-6mdk on a two processor 450MHz PIII 
running a stock Mandrake 8.2 Linux 2.4.18 kernel.
.TSTART
.TS
center box tab (&);
c | c   s
l | l | l.
Benchmark&Latency ($mu$s)
_
&1 process&2 processes
_
null call&0.79&0.81
null I/O&1.39&2.39
stat&9.26&25.9
open/close&11.7&27.1
select (TCP)&55.3&58.6
signal install&1.89&1.95
signal handler&6.34&7.21
fork process&793.&868.
exec process&2474&2622
sh process&24.K&25.K
pipe&17.7&23.3
unix socket&51.6&37.6
UDP&70.2&70.6
TCP&91.2&92.3
rpc (UDP)&120.0&120.4
rpc (TCP)&157.1&159.1
.TE
.TEND "Latency results"
.nr TABLElatency \n[TABLE]
.TSTART
.TS
center box tab (&);
c | c   s
l | l | l.
Benchmark&Bandwidth (MB/s)
_
&1 process&2 processes
_
pipe&155&268
unix socket&142&179
TCP&57.5&57.8
bcopy(libc)&134&175
bcopy(hand)&144&174
memory read&319&486
memory write&199&202
STREAM copy&288.68&367.99
STREAM scale&290.39&369.08
STREAM sum&337.75&415.54
STREAM triad&246.90&380.09
STREAM2 fill&198.96&276.28
STREAM2 copy&288.55&359.93
STREAM2 daxpy&318.98&493.79
STREAM2 sum&354.03&512.05
.TE
.TEND "Bandwidth results"
.nr TABLEbandwidth \n[TABLE]
.TSTART
.TS
center box tab (&);
c | c   s   s
l | l | l | l.
Benchmark&Load
_
&1&2&2clone
_
bw_file_rd&151.04&266.74&273.51
bw_mmap_rd&316.08&480.02&482.57
lat_mmap&615&878&786
lat_pagefault&2.9802&3.9159&3.4589
.TE
.TEND "File bandwidth results"
.nr TABLEfile \n[TABLE]
.LP
Table \n[TABLElatency] shows the latency of
various system and communication operations
for both 1 and 2 process loads, while 
Table \n[TABLEbandwidth] shows the bandwidth
of various data operations and
Table \n[TABLEfile] shows how various file
system operations scale.
Table \n[TABLEfile] shows system performance 
with one process, two processes sharing the 
same file, and two processes accessing their 
own files.
.TSTART 1
.G1
label left "Latency (ns)"
label bottom "Memory size (MB)"
coord x 0.0004,32 y 5,300 log x
draw solid
0.00049 6.680
0.00098 6.683
0.00195 6.680
0.00293 6.680
0.00391 6.681
0.00586 6.681
0.00781 6.681
0.00977 6.684
0.01172 6.683
0.01367 6.690
0.01562 6.725
0.01758 48.977
0.01953 49.051
0.02148 49.043
0.02344 49.025
0.02539 48.889
0.02734 48.880
0.02930 48.902
0.03125 49.020
0.03516 49.043
0.03906 48.904
0.04297 49.044
0.04688 49.027
0.05078 49.046
0.05469 48.889
0.05859 49.018
0.06250 49.012
0.07031 49.025
0.07812 49.030
0.08594 48.936
0.09375 49.042
0.10156 49.022
0.10938 48.889
0.11719 49.073
0.12500 48.998
0.14062 49.043
0.15625 49.125
0.17188 49.160
0.18750 49.113
0.20312 49.123
0.21875 48.991
0.23438 49.045
0.25000 49.184
0.28125 49.971
0.31250 57.735
0.34375 72.668
0.37500 79.106
0.40625 77.612
0.43750 78.764
0.46875 88.636
0.50000 104.024
1.00000 179.817
1.50000 182.297
2.00000 182.043
2.50000 182.902
3.00000 183.130
3.50000 184.333
4.00000 182.868
5.00000 183.319
6.00000 183.208
7.00000 183.688
8.00000 183.871
10.00000 183.659
12.00000 183.583
14.00000 183.773
16.00000 183.828
18.00000 183.894
20.00000 183.933
30.00000 183.971
new dashed
0.00049 6.811
0.00098 6.815
0.00195 6.825
0.00293 6.807
0.00391 6.803
0.00586 6.822
0.00781 6.826
0.00977 6.825
0.01172 6.922
0.01367 6.825
0.01562 6.866
0.01758 49.954
0.01953 49.989
0.02148 50.021
0.02344 50.019
0.02539 50.003
0.02734 50.085
0.02930 50.000
0.03125 50.187
0.03516 49.988
0.03906 50.032
0.04297 49.986
0.04688 50.186
0.05078 50.196
0.05469 50.107
0.05859 50.087
0.06250 49.983
0.07031 50.092
0.07812 50.135
0.08594 50.057
0.09375 50.188
0.10156 65.950
0.10938 55.614
0.11719 54.328
0.12500 61.700
0.14062 59.710
0.15625 52.637
0.17188 82.911
0.18750 74.304
0.20312 72.371
0.21875 78.124
0.23438 74.577
0.25000 96.374
0.28125 110.708
0.31250 97.832
0.34375 103.006
0.37500 129.292
0.40625 140.816
0.43750 165.255
0.46875 164.632
0.50000 170.912
1.00000 233.968
1.50000 285.445
2.00000 241.341
2.50000 263.436
3.00000 273.101
3.50000 269.926
4.00000 233.626
5.00000 222.305
6.00000 293.832
7.00000 238.863
8.00000 245.026
10.00000 282.297
12.00000 239.152
14.00000 274.218
16.00000 226.299
18.00000 284.183
20.00000 224.596
30.00000 236.416
"1 process" at 5,165
"2 processes" at 0.3,280
.G2
.FEND "Memory subsystem performance" 1
.nr FIGUREmem \n[FIGURE]
.LP
Figure \n[FIGUREmem] shows the memory latency
curves with 32 byte strides for one and two 
process loads versus memory size.
.NH 1
Conclusion
.LP
\*[lmbench] is a useful, portable micro-benchmark 
suite designed to measure important aspects of 
system performance.
\*[lmbench3] adds a number of important extensions,
such as the ability to measure system scalability.
.LP
The benchmarks are available via ftp from:
.IP
.I "http://ftp.bitmover.com/lmbench"
.NH 1
Acknowledgments
.LP
Many people have provided invaluable help and insight into the benchmarks.
We especially thank:
Eric Anderson \s-1(HP)\s0,
Bruce Chapman \s-1(SUN)\s0,
Larry McVoy \s-1(BitMover)\s0,
David Mosberger \s-1(HP)\s0,
Wayne Scott \s-1(BitMover)\s0,
John Wilkes \s-1(HP)\s0,
and
Mitch Wright \s-1(HP)\s0.
.LP
We would also like to thank all of the people that have run the
benchmark and contributed their results; none of this would have been possible
without their assistance.
.LP
Our thanks to 
all of the free software community for tools that were used during this
project.
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
.\" References
.[
$LIST$
.]
.\" .so bios
