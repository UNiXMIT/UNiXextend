AcuCOBOL-GT ActiveX SpellChecker sample program README
======================================================

Readme Contents:
----------------
I.   Introduction

II.  What's Included

III. Developing with ActiveX Controls

IV.  Running the ActiveX SpellChecker Sample


I. Introduction
---------------
AcuCobol-GT can now make use of ActiveX controls on Windows
platforms.  They can be coded manually, or more easily with
the Acubench Integrated Development Environment.  This
sample program demonstrates the use of an ActiveX control by
way of Acubench.


II. What's included:
--------------------
Included in the ActiveX SpellChecker sample are:

   1) AcuCobol Workbench project code to invoke the 
      SpellChecker app (see section IV, below)
   2) Polar software Spell Checker control install package

For a specific list of these files, and many others, please
see the Acu "Read_me.32" file:

        YourInstallDirectory\AcuGT\Read_me.32

     Typically:
 
        c:\Acucorp\Acucbl700\AcuGT\Read_me.32


III. Developing with ActiveX controls
-------------------------------------
Before you can develop a program with an ActiveX control, that
control must be installed on your computer.  During installation,
more files may be installed than are necessary to deploy your 
application, as tools for the programmer are often included.  
For details on deploying an application which uses an ActiveX 
control, see the documentation for the specific control used.  

For specific information on installed files, and on deploying
an application with the Polar Software Spell Checker control,
see the Polar Software Readme.txt file:

      YourInstallDirectory\AcuGT\Sample\ActiveX\Polar\Readme.txt

   Typically:
 
      c:\Acucorp\Acucbl700\AcuGT\Sample\ActiveX\Polar\Readme.txt


IV. The AcuCOBOL-GT/ActiveX SpellChecker Sample
-------------------------------------------
In order to run the AcuCOBOL-GT/ActiveX sample, you need to do 2 things:

1) Install the Polar Software SpellChecker control onto your
   system.  To do this, simply run the SETUP program for the
   Polar Spell Checker.  It is located, depending on your choice
   of install directories, as follows:

      YourInstallDirectory\AcuGT\Sample\ActiveX\Polar\Setup.exe

   Typically:
 
      c:\Acucorp\Acucbl700\AcuGT\Sample\ActiveX\Polar\Setup.exe

2) Run the SpellChecker app in one of two ways:

   a) if you have the Acucorp Workbench 6.0 installed, open the project for the 
      SpellChecker:

         YourInstallDirectory\AcuGT\Sample\ActiveX\SpellChecker.pjt
      
      Typically:
 
         c:\Acucorp\Acucbl700\AcuGT\Sample\ActiveX\SpellChecker.pjt

      and then run the application from there with any of the Workbench's Execute
      options;

   or

   b) as you would run any AcuGT app with a command line or Windows shortcut:

      Typical command line (assuming path to runtime is defined):

      wrun32 c:\Acucorp\Acucbl700\Acugt\Sample\ActiveX\Object\SpellChecker.acu
