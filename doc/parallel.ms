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
.de draftPT
.\" .tl '\fBDRAFT\fP'Printed \\*(DY'\fBDRAFT\fP'
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
.de draftBT
.\" .tl '\fBDRAFT\fP'Page %'\fBDRAFT\fP'
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
.ds title Utilizing instruction-level parallelism
.ds author Carl Staelin
.ds lmbench \f(CWlmbench\fP
.ds lmbench3 \f(CWlmbench3\fP
.ds lmdd  \f(CWlmdd\fP
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
.ds memmove \f(CWmemmove\fP
.ds mmap \f(CWmmap\fP
.ds popen  \f(CWpopen\fP
.ds read \f(CWread\fP
.ds stream \f(CWstream\fP
.ds system  \f(CWsystem\fP
.ds uiomove \f(CWuiomove\fP
.ds write \f(CWwrite\fP
.ds yield  \f(CWyield\fP
.ds select  \f(CWselect\fP
.ds lat_ops  \f(CWlat_ops\fP
.ds benchmp  \f(CWbenchmp\fP
.ds lat_connect  \f(CWlat_connect\fP
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
\s(14Utilizing instruction-level parallelism\s0
.AU
\s+2\fR\*[author]\fP\s0
.AI
\fI\s+2Hewlett-Packard Laboratories Israel\s0\fP
.SP
.AB
Modern processors and systems provide a great deal of 
parallelism, even for traditional single-threaded
software.  
Often this parallelism is hidden, but the potential
performance benefits of restructuring software to allow
the hardware to utilize this parallelism can be striking.
For example, modern memory systems can usually support
at least two outstanding requests to main memory, and
as many as six or eight outstanding requests to cache
memory.  Since memory latencies can account for a
significant fraction of many program's runtime, 
restructuring data structures and algorithms so
strictly sequential memory accesses can be 
parallelized can greatly improve performance.
.AE
.if t .MC 3.05i
.NH 1
Introduction
.LP
Computer scientists are generally taught some basic computer
architectecture and a set of standard data structures and
algorithms, such as lists, hash tables, and binary search.  
These data structures and algorithms are commonly used and
in many programs their handling can consume a significant 
fraction of the overal runtime.
However, these data structures and algorithms were
designed over thirty years ago, when most processors had
no parallelism.
.LP
There has been a great deal of work by compiler writers
and computer architects on automatically discovering and
utilizing instruction-level parallelism in existing
software, but relatively little work has been done on
examining data structures and algorithms that can enable
increased instruction-level parallelism.
.LP
There has been a great deal of work focussing on 
developing parallel algorithms for multi-processor
machines, with explicit synchronization primitives
such as semaphores and barriers.  At this level of
parallelism, the overheads are generally so high
that the parallelism must be fairly coarse-grained,
or else the overhead costs consume any benefits
provided by the parallelism.
.LP
However, instruction-level parallelism is "free"; it
is managed by the hardware and incurs no additional
runtime costs.  
The main question is how to structure software algorithms
and data structures to maximize the available parallelism.
.NH 1
Prior work
.LP
Over the last few years, there has been some work on
improving the performance of critical software in a
architecture-sensitive manner.  
.LP
.RN Agarwal96
describes the design and implementation of a 
fast sorting algorithm for superscalar RISC machines.
.LP
The Automatically Tuned Linear Algebra System (ATLAS)
.RN Whaley98
contains a number of parametrized code generators
for matrix multiply operations, as well as a pluggable
architecture to allow developers to add hardware-specific
modules.
ATLAS then explores the parameter space to find the
optimal parameter settings for the particular system.
.LP
FFTW
.RN Frigo98
is another project which uses architecture-aware
optimizations.
.NH 1
Computer architecture primer
.LP
A processor architecture is generally defined by its
instruction set, but most computer architectures
incorporate a large number of common building blocks
and concepts, such as registers, arithmetic logic
units, and caches.
.NH 2
Traditional architecture
.LP
One view of a traditional architecture might be the
MIX system defined by Knuth in his classic work on
algorithms and data structures
.RN Knuth73 .
While the MIX instruction set and architecture does
not forbid parallelism, there is no explicit parallelism 
mentioned in the description.  
Consequently, none of the algorithms assumes any
instruction-level parallelism, or is structured to
explicitly utilize such parallelism had it existed.
.LP
The MIX system has a single arithmetic logic unit,
and no floating point unit, so there is no explicit
instruction-level parallelism specified in the 
architecture.
.NH 2
Modern Extensions
.LP
There are a number of modern extensions to computer
architecture that attempt to increase the processor's
ability to do several things at once.  Nearly all of
these enhancements, with the notable exception of
the EPIC work, are intended to be invisible to the
average programmer.  Most notably, they do not require
changing the instruction set.
.IP "Superscalar processors"
Superscalar processors have multiple processing
units which can operate simultaneously.  
.IP "Dynamic instruction reordering"
Dynamic instruction reordering allows the processor
to execute instructions whose operands are ready
before instructions which are stalled waiting for
memory or other instruction's completion.
.IP "Memory parallelism"
By allowing multiple outstanding memory requests,
processors allow the memory subsystem to service
multiple (independent) requests in parallel. 
Since memory accesses are a common performance
bottleneck, this can greatly improve performance.
.IP "Vector processing"
Vector processing allows the processor to execute
arithmetic operations on vector operands in 
parallel, and in modern commodity processors goes
by names such as MMX, SSE, and 3DNow.
.IP "Simultaneous multi-threading (SMT)"
SMT allows superscalar processors to simulatenously
execute instructions from several threads (contexts)
.RN Tullset96 .
SMT may include extensions which allow for very
lightweight inter-thread synchronization primitives
that enable much finer-grained thread-level 
parallelism than traditional synchronization
methods
.RN Tullsen99 .
.IP "Explicitly parallel instruction computers (EPIC)"
EPIC allows the compiler to explicitly issue $N$
instructions in parallel at each instruction, which
informs the hardware that these instructions are
independent and may be executed in parallel
.RN Schlansker00 .
It moves much of the burden regarding dependency
checking from the hardware to the compiler.
.NH 1
Conclusion
.LP
With the increasing proliferation of both explicit and
hidden parallelism in processor and memory system
designs, it is becoming important to revisit many data 
structures and algorithms to adapt them to the new 
hardware environment.
.NH 1
Acknowledgments
.LP
Many people have provided invaluable help and insight into both the
benchmarks themselves and the paper.  We thank all of them
and especially thank Larry McVoy \s-1(BitMover)\s0 for the
lively conversations and discussions regarding benchmarking
and experimental design.
.\" .R1
.\" bibliography references-parallel
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
database references-parallel
label-in-text
label A.nD.y-2
bracket-label [ ] ", "
bibliography references-parallel
.R2
.\" .so bios
