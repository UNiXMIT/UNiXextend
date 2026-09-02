@ECHO OFF

"C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\bin\ccbl32" -lfo .\Maintenance\@.lst -ga -ps -sl -sp "C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\sample\def" -o .\maintenance\@.acu .\Maintenance\maintenance.sqb
"C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\bin\ccbl32" -lfo .\ATM\@.lst -ga -ps -sl -sp "C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\sample\def" -o .\ATM\@.acu .\ATM\ATM.sqb
"C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\bin\ccbl32" -lfo .\ATM\@.lst -ga -ps -sl -sp "C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\sample\def" -o .\ATM\@.acu .\ATM\processing.sqb