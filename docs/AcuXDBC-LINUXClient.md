# AcuXDBC Linux Client Setup

**ODBC driver installation instructions**

- Download unixODBC from http://www.unixodbc.org/unixODBC-2.2.11.tar.gz 
- Copy the unixODBC*.tar.gz file to somewhere you have permissions create files and directories 
- Type ‘gunzip unixODBC*.tar.gz’
- Type ‘tar xvf unixODBC*.tar’
- Start with README file located in the directory where the package was extracted and any other README files with a suffix that describes your OS: example README.AIX for IBM AIX. For the purposes of this document, the directions are provided for a basic 32-bit Linux (Intel x86) installation.
- Next read the INSTALL file for prerequisites and installation instructions
- Type ‘configure’ and wait while features on your system are being checked for
- Type ‘make’ and wait while for the package to be compiled
- Type ‘make install’ to install programs, data, and documentation

**AcuXDBC Setup** (Note: An installable package was not yet available for AcuXDBC so the default installation directory will be different and the need to manually set environment variables will likely be replaced by scripts.) 

1.	Type ‘odbcinst –j’ to find out where your SYSTEM and USER data sources are located. Here is the location information from our Linux system.

```
DRIVERS............: /usr/local/etc/odbcinst.ini
SYSTEM DATA SOURCES: /usr/local/etc/odbc.ini
USER DATA SOURCES..: /home/techsup/.odbc.ini                       
```

2.	Add the following to the file where your SYSTEM data sources are located: example /usr/local/etc/odbc.ini:

```
[ODBC Data Sources]
vision_sys = VORTEXodbc to VISION

[vision_sys]
Driver = /usr2/lib/acuxdbc.so
Description = VORTEXodbc to VISION
LoginID = system
```

3.	Set two operating environment variables called VORTEX_HOME and GENESIS_HOME. These environment variables should be set to the root installation directory of acuxdbc. On our Linux system that location is /usr2/acuxdbc. The following is an example how to set this variable:

```
export VORTEX_HOME=/usr2/acuxdbc
export GENESIS_HOME=/usr2/acuxdbc
```

**Note:** the value assigned to the environment variable should not have a ‘/’ as the last character as this can play havoc with our installation and configuration scripts

4.	Add an in entry in $VORTEX_HOME/lib/odbc.ini with the following information. Please create this file if it does not already exist.

```
rem -------------- VORTEXodbc
fetch_buffer_size 	8192 	--fetch buffer size (in bytes)

columns 		256 	-- max # of database columns

logical_cursors 		1024 	-- max # of logical cursors

db_cursors 		64 	-- max # of DB cursors
```

If the information above is for use on a local machine, enter:

```
dsn_vision_sys "acuxdbc04:%s/%s/xvision:acuxdbc.cfg"
```

If the information above is for use on a server, enter:

```
dsn_vision_sys "acuxdbc03:%s/%s/xvision:acuxdbc.cfg@20222:servername!acuxdbc04"
```

5.	Additionally, environment variables need to be set or modified that point the location of the acuxdbc executables and to tell the operating system where to find the acuxdbc shared libraries: PATH and LD_LIBRARY_PATH respectively on our Linux system. For example, our Linux system we would set the following: 

```
export PATH=/usr2/acuxdbc/bin
export LD_LIBRARY_PATH=/usr2/acuxdbc/bin
```

6.	Next modify the acuxdbc configuration file, acuxdbc.cfg. It should be located at $GENSIS_HOME, which on our Linux system is /urs2/acuxdbc. There are two variables that are required, although other may be needed depending on your situation: DICTSOURCE and FILE_PREFIX. 

```
#  The path to your system catalog directory
DICTSOURCE      /usr2/acuxdbc/syscat

#  The path to your data files.  You must prepend the line with a semi-colon,
#  use either double backslashes ("\\") or forward slashes ("/"),
#  and separate your paths by semi-colons.
FILE_PREFIX     ;/usr2/acuxdbc/data;/usr2/acuxdbc/sample/acuxdbc/data
```

**Note:** although it is clearly stated in the comments for FILE_PREFIX that the delimiting character is a semi-colon, long time UNIX users know to use a colon as is supported on our other products that run on UNIX.  However, for this product only supports the semi-colon as a separator, thus this is a break from our other products that support the usage of a colon or a space

7.	Verify that the AcuXDBC license file, xvision.alc, is located in the bin directory. 

8.	Run setup script demo.sh located at $GENESIS_HOME/bin.

9.	Try to access a sample Vision file using a utility that came with unixODBC. To run the test, type isql vision_sys system manager.

A successful connection looks like this:

+---------------------------------------+  

  Connected!

  sql-statement  
  help [tablename]   
  quit    

+---------------------------------------+  


Now we will attempt to connect to a Vision file called “pets” that is physically located at $GENESIS_HOME/sample/acuxdbc/data

```
SQL> select * from pets
```

![1](images/xdbc-lc-1.png)