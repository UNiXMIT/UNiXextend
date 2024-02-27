# CJAVA-SETSYSTEMPROPERTY does not correctly set the CLASSPATH
## Environment
AcuCOBOL-GT extend  
Windows and Linux/UNIX  

## Situation  
Using CJAVA-SETSYSTEMPROPERTY to set the CLASSPATH environment variable does not appear to set it correctly.  
The class is not found at CALL "C$JAVA" USING CJAVA-NEW.  
Setting the CLASSPATH in the runtime configuration file variable JAVA_OPTIONS works as expected.  

## Resolution
CJAVA-SETSYSTEMPROPERTY function is working properly.   
However modifying the CLASSPATH with the System.setProperty method AFTER the JVM is started will have no effect.  
Each JVM instance has its own properties. The system class loader is initialized at a very early point in the start-up sequence.  
It copies the CLASSPATH into its own data structures, and the property is not read again, therefore changing it again using CJAVA-SETSYSTEMPROPERTY, once it has started, will have no effect. It needs to be set before the JVM is started.  