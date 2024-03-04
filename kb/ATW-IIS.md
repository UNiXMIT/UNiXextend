# How to configure IIS with AcuToWeb
## Environment
AcuToWeb  
Windows  
 
## Situation
It's not 100% clear what exact steps to take to setup IIS with AcuToWeb so that traffic is routed through IIS correctly. What needs to be done?  

## Resolution
- [Prerequisites](#Prerequisites)
    - [Install and Setup AcuToWeb](#install-and-setup-acutoweb)
    - [Install IIS with Websocket support](#install-iis-with-websocket-support)
    - [Install ARR](#install-arr)
    - [Install URL Rewrite](#install-url-rewrite)
    - [Create and Import Server Certificates in IIS](#create-and-import-server-certificates-in-iis)
    - [OPEN ports 443 and 8080](#open-ports-443-and-8080)
- [Rewrite Rules](#rewrite-rules)
- [SSL Setup and Binding](#ssl-setup-and-binding​​​​)
- [Optional](#optional) ​​​​​​​
    - [Short URL](#short-url) ​​​​​​​

#### Prerequisites
##### Install and Setup AcuToWeb
General installation and setup of AcuToWeb instructions are not included in this guide but they should be done before continuing.    
Take note of the WebServer port and TCP port you assigned when creating the service. You will need it later.    
​​​​​​​
**IMPORTANT:** Due to a limitation of ARR 3.0, this component does not support compressed WebSocket frames; therefore, IIS is not capable of routing them. To make the WebSocket Proxy rule work, compression must not be enabled in AcuToWeb. Add the following to your gateway configuration file:  

In 10.4.1 and previous versions, add the following in your gateway.conf:  
```
WS_COMPRESSION 0
```

In 10.5.0 onward, add the following in your gateway.toml under the [gateway] section:  
```
ws_compression = true
```

##### Install IIS with Websocket support
**NOTE:** You must use IIS version 8 or later, as this provides WebSocket support; IIS version 8 is supported on Windows Server 2012 and later.
For more information, visit http://www.iis.net/learn/get-started/whats-new-in-iis-8/iis-80-websocket-protocol-support.  

1. On the Start page, click the Server Manager tile, and then click OK.  

2. In Server Manager, select Dashboard, and click Add roles and features.  

3. In the Add Roles and Features Wizard, on the Before You Begin page, click Next.  

4. On the Select Installation Type page, select Role-based or Feature-based Installation and click Next.  

5. On the Select Destination Server page, select a server from the server pool, select your server, and click Next.  

6. On the Select Server Roles page, select Web Server (IIS).  

    ![1](images/atw-iis1.png)

7. Click Next 3 times to reach the 'Role Services' section. This is where you enable Websocket support. It can be found in the tree view under WebServer -> Application Development -> then check the option for 'Websocket Protocol'.  

8. Click Next and then Install.  

9. On the Installation Progress page, confirm that your installation of the Web Server (IIS) role and required role services completed successfully, and then click Close.  

10. To verify that IIS installed successfully, type the following into a web browser:  

    ```
    http://localhost
    ```

    You should see the default IIS Welcome page.  

##### Install ARR

1. Download and install Application Request Routing (ARR 3.0) - http://www.iis.net/downloads/microsoft/application-request-routing  

2. Configure ARR as a forward proxy:  

    1. Double-click Application Request Routing Cache  

    ![2](images/atw-iis2.png)

    2. Click Server Proxy Settings.  

    3. Select Enable Proxy, then click Apply.  

##### Install URL Rewrite  
Download and install URL Rewrite: http://www.iis.net/downloads/microsoft/url-rewrite  

##### Create and Import Server Certificates in IIS

If you plan to secure the ports with SSL, make sure you have created and/or imported your Server certificates in IIS for the domain you have asigned to your Server IP. We need these to be available when binding ports to the sites we will setup.  
You could use a 3rd party tool like [Certify The Web](https://certifytheweb.com/) to help you install, manage and renew your certificates on IIS.  

##### OPEN port 443
You must ensure that the ports you are assigning in IIS are OPEN in order to allow IIS to receive the traffic that is being routed to AcuToWeb. In this setup I opened port 443 in the Windows firewall.  

#### Rewrite Rules
1. In IIS, under the section 'Sites' on the left hand side, select 'Default Web Site', then double-click URL Rewrite.  

    ![3](images/atw-iis3.png)

2. Click Add Rule in the Actions section on the right side, then click Blank rule.

    1. In the Edit Inbound Rule dialog box, type 'Websockets' in the Name field.

    2. Select 'Regular Expressions' in the Using field.

    3. Enter 'websocket(.*)' in the Pattern field.

    4. In the Action section, select Rewrite in the Action Type field.

    5. Type http://127.0.0.1:8000/websocket{R:1} in the Rewrite URL field (In my example I am using AcuToWeb TCP port 8000 but yours may be different).

    6. Check Stop Processing, the click Apply.

    ![4](images/atw-iis4.png)

3. Click Add Rule again, then click Blank rule.

    1. In the Edit Inbound Rule dialog box, type 'HTTP Proxy' in the Name field.

    2. Select 'Regular Expressions' in the Using field.

    3. Enter '(.*)' in the Pattern field.

    4. In the Action section, select Rewrite in the Action Type field.

    5. Type http://127.0.0.1:3000/{R:1} in the Rewrite URL field (In my example I am using AcuToWeb WebServer port 3000 but yours may be different).

    6. Check Stop Processing, the click Apply.

    ![5](images/atw-iis5.png)

4. IIS should now route your request through port 443 assigned via IIS to AcuToWeb on the server. HTTP requests route from port 80 on IIS to port 3000 in AcuToWeb. Websocket requests route from port 80 on IIS to port 8000 in AcuToWeb.  

**IMPORTANT:** With this configuration, the AcuToWeb Gateway is hidden behind IIS and it is only reachable via the port bound in IIS; therefore, it is mandatory to use the portgw and hostgw parameters to override the gateway configuration; for example:  

```
http://12.345.678.912?hostgw=12.345.678.912&portgw=80&alias=tour 
```

#### SSL Setup and Binding
If you want to use SSL certificates to secure the connection in IIS, you need to modify the bindings on the site we have already created and assign the SSL certificate to port 443.

1. In IIS click Default Web Site -> Bindings -> then click Add in the new window.

    1. Change the Type to HTTPS.

    2. Set Port to 443. This is the default secure port number. Notice that it's no longer port 80 as we set before for non secure connections.

    3. In the SSL Certificate box select the SSL certificates, which you should have already created and imported in IIS, then click OK.

    4. Port 443 is now secure with SSL.  
    ![6](images/atw-iis6.png)

2. IIS should now route your requests through port 443 assigned via IIS to AcuToWeb on the server. HTTPS requests route from port 443 on IIS to port 3000 in AcuToWeb. Secure Websocket requests route from port 443 on IIS to port 8000 in AcuToWeb.

**IMPORTANT:** With this configuration, the AcuToWeb Gateway is hidden behind IIS and it is only reachable via the port bound in IIS; therefore, it is mandatory to use the portgw and hostgw parameters to override the gateway configuration; for example:

```
http://example.com/?hostgw=example.com&portgw=443&alias=tour  
```

#### Optional
##### Short URL
You can configure the URL Rewrite to proxy a short URL rather than using the URL with a long query string. For example:  

```
http://example.com/?id=tour
```

will be proxied to  

```
http://example.com/?portgw=443&hostgw=example.com&alias=tour&theme=tour
```

and 'tour' can be dynamically replaced with any alias you have setup.    

**HTTP web.config example**  
```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <clear />
                <rule name="ShortURL" stopProcessing="true">
                    <match url="(.*)" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                        <add input="{QUERY_STRING}" pattern="^id=([A-Za-z0-9-]+)$" />
                    </conditions>
                    <action type="Redirect" url="http://example.com/{R:1}?portgw=443&amp;hostgw=example.com&amp;alias={C:1}&amp;theme={C:1}" appendQueryString="false" />
                </rule>
                <rule name="Websocket" stopProcessing="true">
                    <match url="websocket(.*)" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="false" />
                    <action type="Rewrite" url="http://127.0.0.1:8000/websocket{R:1}" appendQueryString="true" />
                </rule>
                <rule name="HTTP/S" enabled="true" stopProcessing="true">
                    <match url="(.*)" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="false" />
                    <action type="Rewrite" url="http://127.0.0.1:3000/{R:1}" appendQueryString="true" logRewrittenUrl="false" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```

**NOTE:** Notice how the new ShortURL rule preceeds the original catch all rule that we created 'HTTP Proxy'. It is required to be this way otherwise the original rule will match everything and the ShortURL rule will not be used.  
The ShortURL rule will only be used when the condition is matched i.e. when the URL contains the query string 'id=AliasName'.  