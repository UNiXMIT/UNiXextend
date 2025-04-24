# Installation / Setup of AcuToWeb - LINUX

AcuToWeb on Linux doesn’t have a graphical control panel. The service is started using the acutoweb-gateway command. The AcuToWeb Gateway provides a method where the client specifies an AcuConnect alias to be run. The AcuToWeb Gateway sends the alias information to AcuConnect; therefore, in order to use AcuToWeb, the following are prerequisites:

1.	[Install AcuConnect](https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKCNCNSERVCN22.html)
2.	[Establish system security](https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKCNCNSERVCN23.html)
3.	[Create the required aliases](https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKCNCNSERVCN24.html)

**N.B.** Starting with AcuToWeb 10.3.0 a minimum GCC version is now required:

```
Linux	-   GCC 4.8.0  
```

Because AcuToWeb is only 32 bit, even in the 64 bit version of 10.3.0, you will need to make sure you have installed the 32 bit libraries on your server to allow it to run 32 bit applications. For instance on RHEL/CentOS this can be achieved by running the following command:

```
yum install libstdc++.i686
zlib.i686
libgcc.i686
glibc.i686 
```

After performing the steps above (configuring the AcuAccess file, creating an alias in the acurcl.ini file, and starting the AcuConnect service), you can modify the Gateway configuration file 'gateway.toml'. This is found in the 'acutoweb/conf' directory of the installation.  
An example gateway.toml can be found in the [documentation](https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/GUID-F17A95F4-172C-43B3-8C22-915643243CED.html). Amend it to fit your needs and make sure acurcl_port matches the port you selected when you created the AcuConnect service earlier. If you are not planning on using SSL then be sure to set use_ssl to false.  

To start the gateway from the acutoweb directory, enter the following command in the terminal:  

```
./acutoweb-gateway –start
```

When the Gateway service is up and running, Open a browser and navigate to the AcuToWeb start page using the syntax: http://[server ip]:[configured port] The default value is http://127.0.0.1:3000. The Connection Setup dialog box appears, which confirms that the Gateway is running:

![1](images/atw-l-1.png)

The Alias entry field specifies the alias of the AcuConnect to be executed. You can populate a list of values by adding them to the fillCombo.js file, which is located in the AcuToWeb\Web\js sub-directory of your installation path.

The following excerpt adds aliases for the Calculator and Tour applications:

```
[
{"type": "category", "text": "Main Applications"},
{"type": "elem", "text": "Calculator", "value": "calc-alias"},
{"type": "elem", "text": "Tour", "value": "tour-alias"}
]
```

You can also type an alias name into the field, then click Make URL, which will generate a URL that you can distribute to customers, which will allow them to paste into their browser and connect to the gateway directly.
