# Redist Versions

First, you need to make sure that the version of libraries required by the runtime.
To do this, open a library from the BIN (acme.dll or wrun32.dll) with an editor.
Then search for the word Manifest.

A few lines below shows the version:  
<assemblyIdentity type="win32" name="Microsoft.VC80.CRT" version="8.0.50727.4053" .....

Then, in the directory C:\Windows\WinSxS, you search for the folders with the correct version (beware of subversions, in this case 4053):

```
x86_Microsoft.VC80.CRT_1fc8b3b9a1e18e3b_8.0.50727.4053_x-ww_e6967989
x86_Microsoft.VC80.MFC_1fc8b3b9a1e18e3b_8.0.50727.4053_x-ww_b77cec8e
```

These folders must be copied to the BIN, renaming them as Microsoft.VC80.CRT and Microsoft.VC80.MFC

Therefore, the manifests should be searched in the folder C:\Windows\WinSxS\Manifests:

```
x86_Microsoft.VC80.CRT_1fc8b3b9a1e18e3b_8.0.50727.4053_x-ww_e6967989.manifest
x86_Microsoft.VC80.MFC_1fc8b3b9a1e18e3b_8.0.50727.4053_x-ww_b77cec8e.manifest
```

These must be copied to their newly created folders and then renamed to Microsoft.VC80.CRT.manifest and Microsoft.VC80.MFC.manifest.


---


MFC version -------> extend version  
8.0.50608 ---------> 8.0.0  
8.0.50608.0 -------> 8.1.0 (original)  
8.0.50727.762 -----> 8.1.0 (with patch) 8.1.1 (original)  
8.0.50727.4053 ----> 8.1.1 + ECN-3943 (Visual Studio 2005 SP1)  
8.0.50727.4053 ---> 8.1.2 (Visual Studio 2005 SP1)  
9.0.21022.08 -----> 8.1.1 AcuXDBC (Visual Studio 2008 no SP)  
9.0.21022.08 -----> 9.0.1 (Visual Studio 2008 no SP)  
10.00.30319.01 ---> 9.1.0 (Visual Studio 2010 no SP)  
10.0.40219.325 ---> 9.2.5 (Visual Studio 2010 SP1; mfc100.dll)  

11.0.51106.1 -----> 10.0.0 (Visual Studio 2012 Update 4; mfc110.dll)  
11.0.61030.0 -----> 10.0.0 (Visual C++ Redistributable for Visual Studio 2012 Update 4; mfc110.dll)  
11.0.61030.0 -----> 10.1.1 (Visual C++ Redistributable for Visual Studio 2012 Update 4; mfc110.dll)  
http://www.microsoft.com/en-sa/download/details.aspx?id=30679  
https://msdn.microsoft.com/en-us/library/windows/desktop/aa372856(v=vs.85).aspx  

12.0.21005.1 -----> (Visual Studio 2013)  
http://www.microsoft.com/en-us/download/details.aspx?id=5555  
http://support.microsoft.com/kb/2019667  

14.0.23506 -------> (Visual Studio 2015 Update 1)

14.10.25017 ------> 10.2.0 (Visual Studio 2017)
Visual Studio Downloads > Other Tools and Frameworks
https://www.visualstudio.com/downloads/

Microsoft Visual C++ 2017 Redistributable (x86) - 14.10.25017
https://aka.ms/vs/15/release/VC_redist.x86.exe

Microsoft Visual C++ 2017 Redistributable (x64) - 14.10.25017
https://go.microsoft.com/fwlink/?LinkId=746572

---

Microsoft Visual C++ 2010 Redistributable Package (x86)
http://www.microsoft.com/en-us/download/details.aspx?id=5555

(http://vleertechinfo.blogspot.co.uk/2011/05/visual-studio-version-list.html)

http://www.microsoft.com/downloads/details.aspx?familyid=32bc1bee-a3f9-4c13-9c99-220b62a191ee&displaylang=en


Shared Assemblies
http://msdn.microsoft.com/en-us/library/ms235531(VS.80).aspx
e private assemblies
http://msdn.microsoft.com/en-us/library/aa375674(VS.85).aspx


Troubleshooting Isolated C/C-Based Applications and Side-by-Side Assemblies
http://msdn.microsoft.com/it-it/library/ms235342%28VS.80%29.aspx

Troubleshooting Isolated C/C-Based Applications and Side-by-Side Assemblies (Visual Studio 2010)
http://msdn.microsoft.com/it-it/library/ms235342%28v=VS.100%29.aspx
