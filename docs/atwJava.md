# Java Registry Keys checked by ATW 11.0.0

```
reg add "HKLM\SOFTWARE\JavaSoft" /f
reg add "HKLM\SOFTWARE\JavaSoft\JDK" /v "CurrentVersion" /t REG_SZ /d "22" /f
reg add "HKLM\SOFTWARE\JavaSoft\JDK\22" /v "JavaHome" /t REG_SZ /d "C:\Program Files\OpenJDK\jdk-22.0.2" /f
reg add "HKLM\SOFTWARE\JavaSoft\JDK\22" /v "RuntimeLib" /t REG_SZ /d "C:\Program Files\OpenJDK\jdk-22.0.2\bin\server\jvm.dll" /f
```