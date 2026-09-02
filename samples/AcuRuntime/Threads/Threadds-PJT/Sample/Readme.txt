Readme.txt file

Read me file for Threadds program

Description of the program:

This program illustrates how COBOL can provide the user with the ability
to switch application screens by clicking on Taskbar buttons.  (The Taskbar
contains the Start Button and appears by default on the bottom of all
Windows OS screens.)  The demonstration program uses independent modeless
windows and threads.

From the main screen, start a thread by clicking the Admissions or the Student
Records buttons.  Once the thread has started, you can change screens by
clicking on the Taskbar icons.

Program name:   Threadds.cbl 

Compiler command line: ccbl32 -o .\object\@.acu -Ga -Zd threadds.cbl

Runtime command line: wrun32 threadds.acu

AcuBench version 6.0 project: Threadds.psf

---   End of Readme.txt   ---- 
