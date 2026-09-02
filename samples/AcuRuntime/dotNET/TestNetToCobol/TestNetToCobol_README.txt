1. Launch Visual Studio
2. Create a new project, choosing Windows Forms App
3. Once the project is created, replace the content of Program.cs with what's shown in the Documentation you reported (C# Source)
4. Rename the C# program and the target Assembly name (right click on the project, find the "Assembly name" field in the main page), from TestNetToCobol to MyNetToCobol.
5. Compile the COBOL program: ccbl32 --netdll -ga TestNetToCobol.cbl
6. Copy TestNetToCobol.dll and TestNetToCobol.dll in the Visual Studio target folder
7. Add both as Reference
8. In Program.cs, you may need to replace "testnettocobol" with "TestNetToCobol", as VS2019 is case sensitive
9. Correct line 102 "cblObj.RunPath =" with the correct value for the folder of your runtime
It should be something like:
cblObj.RunPath = "C:\\Program Files\\Micro Focus\\extend 10.4.0\\AcuGT\\bin";
10. Rebuild the project
11. Run it either using the green arrow or by double-clicking on the TestNetToCobol.exe