# New Activator Wizard README  

If you are activating licenses generated and issued by Micro Focus after January 2021, please download and use the NEW activator.  

If you are activating old licenses issued prior to January 2021, you can continue to use the original Activator that is installed with the product.  

From 10.4.0 onwards, the activator that is installed with the product can be used to activate licenses.  

- [Windows](#Windows) 
- [Linux/UNIX](#Linux/UNIX) 
- [Directory Information](#Directory-Information-for-license-locations) 
  - [Version 9.0](#90) 
  - [Version 9.1](#91)
  - [Version 9.2](#92)
  - [Version 10.0](#100)
  - [Version 10.1](#101)
  - [Version 10.2](#102)
  - [Version 10.3](#103)

## Windows  

1. Extract all the contents of the zip file to a directory on your machine.  

2. Once all files are extracted, run the activator.exe, for the version you are using and follow the steps detailed in the wizard.  

3. After you have finished using the Activator Wizard, your licenses will be expanded to a version specific directory.  

4. The directory will change depending on the version you are activating (see the [Directory Information](#Directory-Information-for-license-locations) section below). 

## Linux/UNIX  

1. Extract all the contents of the zip file to a directory on your Windows machine.  

2. Once all files are extracted, run the activator.exe, for the version you are using and follow the steps detailed in the wizard.  

3. After you have finished using the Activator Wizard, your licenses will be expanded to a version specific directory.  

4. The directory will change depending on the version you are activating (see the [Directory Information](#Directory-Information-for-license-locations) section below).  

5. Copy the files from your Windows machine to the target Linux/UNIX machine, into the Acu installations bin directory, or wherever the runcbl executable is.  

6. If necessary, you can use dos2unix tool to avoid any conflict with the DOS format of the license files.   

7. Launch runcbl -v to verify the new licenses are correctly installed.  

## Directory Information for license locations  

### 9.0    
The location where the licenses are expanded is:   
```
C:\ProgramData\Micro Focus\extend\9.0.0\x86-or-X64\product-license.alc   
```

---

### 9.1  
The location where the licenses are expanded is:   
```
C:\ProgramData\Micro Focus\extend\9.1.2\x86-or-X64\product-license.alc  
```

If you are expanding licenses for 9.1.0, 9.1.1, 9.1.2.1 then you need to move the expanded licenses to the appropriate directory:  
```
C:\ProgramData\Micro Focus\extend\9.1.x\x86-or-X64   
```
or the AcuGT\bin directory.  

---

### 9.2  
The location where the licenses are expanded is:   
```
C:\ProgramData\Micro Focus\extend\9.2.5\x86-or-X64\product-license.alc  
```

If you are expanding licenses for 9.2.0, 9.2.1, 9.2.2, 9.2.3, or 9.2.4 then you need to move the expanded licenses to the appropriate directory:  
```
C:\ProgramData\Micro Focus\extend\9.2.x\x86-or-X64   
```
Or the AcuGT\bin directory.   

---

### 10.0  
The location where the licenses are expanded is:  
``` 
C:\ProgramData\Micro Focus\extend\10.0.1\x86-or-X64\product-license.alc  
```

If you are expanding licenses for 10.0.0 then you need to move the expanded licenses to the appropriate directory:  
```
C:\ProgramData\Micro Focus\extend\10.0.0\x86-or-X64   
```
Or the AcuGT\bin directory.  

---

### 10.1  
The location where the licenses are expanded is:  
```
C:\ProgramData\Micro Focus\extend\10.1.1\x86-or-X64\product-license.alc   
```

If you are expanding licenses for 10.1.0 then you need to move the expanded licenses to the appropriate directory:   
```
C:\ProgramData\Micro Focus\extend\10.1.0\x86-or-X64   
```
Or the AcuGT\bin directory.  

---

### 10.2  
The location where the licenses are expanded is: 
```
C:\ProgramData\Micro Focus\extend\10.2.1\x86-or-X64\product-license.alc  
```

If you are expanding licenses for 10.2.0 then you need to move the expanded licenses to the appropriate directory 
``` 
C:\ProgramData\Micro Focus\extend\10.2.0\x86-or-X64  
```
Or the AcuGT\bin directory.  

---

### 10.3  
The location where the licenses are expanded is:  
``` 
C:\ProgramData\Micro Focus\extend\10.3.1\x86-or-X64\product-license.alc  
```

If you are expanding licenses for 10.3.0 then you need to move the expanded licenses to the appropriate directory:  
```
C:\ProgramData\Micro Focus\extend\10.3.0\x86-or-X64   
```
Or the AcuGT\bin directory.  

---

Your product is now licensed.  

If you encounter and problems then please contact Micro Focus Support - https://portal.microfocus.com  