# Install and setup of AcuXDBC client and server on Linux
## Environment
All versions of AcuXDBC  
Linux  

## Situation 
How is AcuXDBC client and server installed and setup on Linux?  

 
## Resolution
**NOTE:** for Unix/Linux you will need to install the SHARED Library product.  
Execute the installation media and install into the desired directory on the machine where you would like AcuXDBC to run.  

#### Set Environment Variables
```
export PATH=/pathtotheinstallation/folder/bin:$PATH  
```

We also need to set the LD_LIBRARY_PATH and GENESIS_HOME  

```
export LD_LIBRARY_PATH=/pathtotheinstallation/folder/lib:$LD_LIBRARY_PATH  
export GENESIS_HOME=/pathtotheinstallation/folder  
```

#### Activate the license
Type ‘activator’ and press return. You will see the options to enter your product code and key.  

```
Activator Wizard 
Enter the product code []:
Enter the product key []:
```

These next steps must be accomplished to complete your installation/configuration of XDBC.  
1. [Configuration of AcuXDBC](#configuration-of-acuxdbc)
2. [Creation of a system catalog](#creation-of-a-system-catalog)
3. [Load an XFD file](#load-an-xfd-file)
4. [Test the system catalog directly (NO ODBC)](#test-the-system-catalog-directly-(no-odbc))
5. [Creation of an ODBC Data Source](#creation-of-an-odbc-data-source)
6. [Test the system catalog using ODBC](#test-the-system-catalog-using-odbc)
7. [Manage AcuXDBC Server](#Manage-AcuXDBC-Server)

#### Quick Start Demo Program
It is a good idea to run and inspect the quick start demo program before testing with your own data and setup. This way you can understand the process in a working environment first.  

extend Product Guides > AcuXDBC Version 10.4.1 User's Guide > Installation and Licensing > General Setup Procedures > Quick-start Demo Program  

Once you are happy with how it works, you can continue on to [Configuration of AcuXDBC](#configuration-of-acuxdbc) and test with your own data.   

#### Configuration of AcuXDBC

Change directory to the installation directory.  

```
cd /pathtotheinstallation/folder
```

This is where your acuxdbc.cfg config file must be located.  
If it's not present, enter the BIN directory and use the batch program genxconf.sh to generate it.  
When created, open acuxdbc.cfg with an editor to customize it.  
These are the two most important configuration variables:  
 
```
#  The path to your system catalog directory. This is a required variable
DICTSOURCE  "/any-path-you-like/syscat" 

#  The path to your data files.  You must prepend the line with a semi-colon, 
#  use either double backslashes ("\\") or forward slashes ("/"), 
#  and separate your paths by semi-colons. This is a required variable
FILE_PREFIX ";/any-path-you-like/data"
```
 
**Optional**  
There are other variables in this configuration file that can be useful to set the way values are read and written.  
For instance:  

```
FILE_SUFFIX             DAT
INVALID_NUMERIC_DATA	ZERO
READ_ONLY               YES
```

Each variable has a brief description in the file itself, so have a look at it before you run the first tests.   

#### Creation of a system catalog
Next step is to create the SYSTEM CATALOG and load xfd files in it.  

To create a syscat use ainit.sh (ainit.sh -help to show the usage)  

```
ainit.sh -d /any-path-you-like/syscat  
```

#### Load an XFD file
Use addfile.sh (addfile.sh -help to show the usage)  

```
addfile.sh -d /path-to-the/syscat -x /path-to-the/xfd-directory file-name
```

or, if you prefer to use the tool directly:  

```
xdbcutil –d /path-to-the/syscat –x /path-to-the/xfd-directory  -v -a file-name
```

Where file-name is the name of the Vision/XFD file that you want to load.  

**NOTE:** When the names of the Vision and XFD files are the same, you can use just its file-name without any extension.  
When you have different names or you want to use aliases, you can use this syntax:  

```
addfile.sh –d /path-to-the/syscat -x /path-to-the/xfd-directory  name-of-xfd-file-without-extension#alias#name-of-vision-file
```

Let's say you have a Vision file named TAB000001 with a xfd file named tabfields.xfd  

You can load a friendlier name in the syscat to use in your future query:  

```
addfile.sh -d /path-to-the/syscat -x /path-to-the/xfd-directory tabfields#CUSTOMERS#/data/TAB000001
```

**NOTE:** Please remember that Linux and Unix are case sensitive.  

If you need to load a list of xfd files, you can write a text file with the list of the xfd to load, which content is:  

```
TAB000001
TAB000002
TAB000003
tabfields#CUSTOMERS#/data/TAB000004 
TAB000005
```

Run this command line:  

```
addfile.sh -d /path-to-the/syscat -x /path-to-the/xfd-directory -f file-list.txt
```

**Update an XFD**  
To update an XFD that's been already loaded:  

```
xdbcutil -d /path-to-the/syscat -x /path-to-the/xfd-directory -u TAB000001
``` 

**How to load a table without the 'PUBLIC.' prefix**  
To load a table without the 'PUBLIC.' prefix:

```
xdbcutil -d /path-to-the/syscat -x /path-to-the/xfd-directory  -o " " -a TAB000001
```

AND activate this variable inside acuxdbc.cfg file:

```
IGNORE_OWNER	ON
``` 

**Load some useful views**  
To load some useful views, use this syntax and the file 'cview.sql' provided with your installation (this is automatically loaded by the 'ainit' script):  

```
asql -r "/pathtotheinstallation/folder/bin/cview.sql"
```

#### Test the system catalog directly (NO ODBC)
Now it's possible to test AcuXDBC using the tool asql.sh  
**NOTE:** This tool will NOT use ODBC libraries, but it will directly access the Vision files. It is very useful to test paths and the syscat.  

```
asql
```

or

```
xdbcquery /z /cacuxdbc04:system/manager/xvision:acuxdbc.cfg
```

```
SQL (/? for help) ==>
SQL (/? for help) ==> select * from CLIENTS;

Use /? to show the help.

Use /d to show the definition of the table, like: 
SQL (/? for help) ==> /d tCLIENTS
(Note the t near the name of the table)
```

Use this query to see the loaded aliases and owners:  

```
SQL (/? for help) ==> select t_owner, t_name from genesis_tables;
```

Use this query to see other information about the xfd loaded:  

```
SQL (/? for help) ==> select * from information_schema.tables;
```

To quit, use:  

```
SQL (/? for help) ==> /q
```

#### Creation of an ODBC Data Source (DSN)
**LINUX**
On LINUX you may use a 3rd party software called unixODBC. Please refer to their documentation on the setup and configuration of this software.  

**Windows**
Install the AcuXDBC Windows client driver from the AcuXDBC standalone installer.  
Create a Data Source Name from Control Panel, Administrative Tools, Data Sources (ODBC).  

**NOTE:**   
- Windows 32-bit uses 32-bit Data Source by default.  
- Windows 64-bit uses 64-bit Data Source by default.  

If you are on a Windows 64-bit and you need to work with AcuXDBC 32-bit and 32-bit Data Sources, the 32-bit “ODBC Data Source Administrator” panel can be opened launching:  

```
C:\Windows\SysWOW64\odbcad32.exe
```

In the ODBC Data Source Administrator, choose “Add…” and select your AcuXDBC driver.  
Note that the description has changed in 9.1.0 to describe whether it is a 32 or 64-bit driver.  

![1](images/xdbc1.png)

Fill in the information required:  

![2](images/xdbc2.png)

Remember to provide user "system" and password "manager" in the Database security fields.  
When connecting to a remote AcuXDBC Server, use the related fields Network driver, Hostname and Port.  
Click OK to save the DSN.  

#### Test the system catalog using ODBC
**LINUX**  
Try to access a sample Vision file using a utility that is installed with unixODBC:  

```
isql vision_sys system manager.
```

A successful connection looks like this:

```
+---------------------------------------+

Connected!

sql-statement
help [tablename]
quit

+---------------------------------------+
```

Now we will attempt to connect to a Vision file called “pets” that is physically located at $GENESIS_HOME/sample/acuxdbc/data

```
SQL> select * from pets
```

![3](images/xdbc-linux1.png)

**Windows**  
Start AcuXDBC Server on Linux - [Manage AcuXDBC Server](#Manage-AcuXDBC-Server)  
To test your Windows DSN use the script odbcsql.bat  

```
odbcsql –h
odbcsql -d my-dsn-name
SQL (/? for help) ==> select * from CLIENTS;
```

Or run the tool directly using:  

```
xdbcquery /cacuxdbc11:system/manager/my-dsn-name
```

If everything works fine, you can open MS Access or MS Excel and use AcuXDBC to link your Vision files.

#### Manage AcuXDBC Server
To manage AcuXDBC Server, use acuxdbcs.sh  

```
acuxdbcs.sh –h
Usage:
       acuxdbcs.sh –help
       acuxdbcs.sh -info [-n port] [server]
       acuxdbcs.sh -kill [-n port] [server]
       acuxdbcs.sh -start [-n port] [-l]
```

To start AcuXDBC Server  

```
acuxdbcs.sh –start –n 20222
```

To get info about AcuXDBC Server  

```
acuxdbcs.sh –info –n 20222 server
```

To stop AcuXDBC Server  

```
acuxdbcs.sh –kill –n 20222 server
```