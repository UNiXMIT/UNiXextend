# Installation / Setup of AcuToWeb - LINUX

AcuToWeb on Linux doesn’t have a graphical control panel. The service is started using the acutoweb-gateway command. The AcuToWeb Gateway provides a method where the client specifies an AcuConnect alias to be run. The AcuToWeb Gateway sends the alias information to AcuConnect; therefore, in order to use AcuToWeb, the following are prerequisites:

1.	Install AcuConnect - http://bit.ly/2Gfolh1
2.	Establish system security - http://bit.ly/30LiI3v
3.	Create the required aliases - http://bit.ly/37nocnt

After performing the steps above (configuring the AcuAccess file, creating an alias in the acurcl.ini file, and starting the AcuConnect service), to start the gateway from the acutoweb directory, enter the following command at a terminal:

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
