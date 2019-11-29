# Dynamic Runtime Tracing - ECN-4304

#### DESCRIPTION of problem or enhancement:
There is a new way to get information about a running runtime.

#### INSTRUCTIONS for use:
There are a number of steps required to get information from a running runtime.

First is to prepare the COBOL program for tracing. Some options require that you compile the COBOL
program with particular options. Those will be detailed below.

Next is to start the runtime to be traced. You must start the runtime with the new --analyze switch.

This causes the runtime to listen for the signal / event that turns tracing on or off. For example:
 ```
 runcbl -14 --analyze verify 
 ```
Without this switch, the runtime will either ignore the signal / event, or may even terminate when it
is sent.

Next is to create a configuration file (separate from the runtime configuration file) to specify what
information to capture. The name of the configuration file is 'analyze.<PID>.cfg', where PID is the
process ID of the running runtime. This file is located in either the current directory, or a common
directory. On UNIX, the common directory is /etc. On Windows, the common directory is
%PUBLIC%\etc. Note that etc is not normally a subdirectory of %PUBLIC%, so it will need to be
created. Note that the value of %PUBLIC% depends on the version of Windows, but is usually
something like C:\Users\Public.
 
Next is to turn tracing on or off.

On UNIX, the way to turn tracing on (or to turn tracing off, if it is currently on) is to send a SIGUSR2
signal to the runtime, using the Operating System 'kill' command. See your OS documentation for
details about how to do this.

Alternately, on both Windows and UNIX, you can use the cblutil utility to turn tracing on and off. The
syntax is
 ```
 cblutil -analyze PID ...
 ```
where PID is the process ID of the runtime you want to trace. You can multiple PIDs on a single
invocation of cblutil, for example:
 ```
 cblutil -analyze 123 874
 ```
will toggle tracing on both runtime processes.

On UNIX, cblutil is unable to determine whether the specified process is a runtime that was started
with the --analyze option. The only failure reported will be if the process does not exist, or if you do
not have permission to send a signal to that process. On Windows, cblutil is able to determine that
(by the presence of an Event with a specific name). In both cases, if cblutil is unable to send the
signal, it will display an error message with an error code. And the return code of cblutil will be the
number of failures, so that if cblutil returns 0, then all processes were signaled.
Note that this toggles tracing in the specified runtime. Execute cblutil once to turn tracing on, and
then again to turn tracing off.

The options you can set in the configuration file are as follows:

---

**OUTPUT-FILENAME-PATTERN** (default 'analyze.<PID>.rpt'). This pattern has the same format as the
crash dump filename given by the standard configuration variable ACU_DUMP_FILE, including the
ability to append to an existing file by preceding the name with +.
 
---
 
**FILE-IO** (default 0). This specifies which file operations to trace. Valid values are a combination of
MAKE, OPEN, CLOSE, READ, NEXT, PERVIOUS, START, WRITE, REWRITE, DELETE, and UNLOCK. For
example, to trace all OPEN and CLOSE operations, use
 ```
 FILE-IO OPEN CLOSE
 ```
Setting this variable to TRUE or ON or ALL will cause all file operations to be traced.

---

**PROGRAM-INFO** (default 0). This specifies which program operations to trace. Valid values are a
combination of CALL, CALLSUB, EXIT, CANCEL, PERFORM, ENTER, and LEAVE. The latter three are for
paragraphs. For example, to trace all CALLs and CANCELs, use
 ```
 PROGRAM-INFO CALL CANCEL
 ```
Setting this variable to TRUE or ON or ALL will cause all program operations (except CALLSUB) to be
traced.

**CALLSUB** is separate because it is an unlikely case, but if you use such things you might want to track
them. This option is used to track called programs in the sub() function, or one of the ways an
external sub() function can be called.

Tracing CALL, CALLSUB, EXIT, and CANCEL requires no special compile options. Tracing PERFORM,
ENTER, and LEAVE requires symbolic debugging (-Gs).

---

**COLLECT-STATS** (default TRUE). This specifies to dump the counts of all FILE-IO and PROGRAM-INFO
operations done while tracing. This dump is done at the end of the trace. If both FILE-IO and
PROGRAM-INFO are off, then this variable has no effect (there are no counts to report).

--- 

**DUMP-RUNTIME-STATE** (default TRUE). This specifies whether to start the trace with the current
state of the COBOL program. Valid values are TRUE (or ON, or YES, or 1) or FALSE (or OFF, or NO, or
0). This dump is the same as a crash dump, and requires the same compile options as when creating
that crash dump. In order to get the most information from this option, the COBOL program should
be compiled with line number (-Gl) and symbol table (-Gs) information. Note that -Ga includes both
of these.

Note that ACU-DUMP-WIDTH and ACU-DUMP-TABLE-LIMIT will have the same effect on this current
state report as they do on a crash dump. 
