# When using AcuToWeb, require.js times out and the program won't load
## Environment
AcuCOBOL-GT extend 10.1.0 +  
All Platforms  

## Situation
When on the AcuToWeb Connection Setup screen, the connect button does nothing. Refreshing the page fixes the issue for now. When checking the browser console log it shows:  

```
Uncaught Error: Load timeout for modules: main  
http://requirejs.org/docs/errors.html#timeout  
```

What causes require.js to load so slowly that it times out?  
What can be done to make sure that this does not timeout, can we increase the timeout value?  

## Resolution
If the latency of the client is high or if the network connection of the server is slow, require.js does not load in time. It has the default value of 7 seconds. This means that AcuToWeb will not work until you refresh the browser to load the rest of its dependencies.   

In 10.5.0 this timeout has been increased to 20 seconds. This timeout value should be more than enough for high latency connections (tested with a very high latency of 1000ms).  

If the timeout value needs to be increased, modify the acutoweb/Web/js/config.js file to increase the default timeout to something higher:  

<pre>
requirejs.config({baseUrl:"js",urlArgs:myManifest.getUrlArg(),<b>waitSeconds:20,</b>paths:{...
</pre>

The changes are in bold.  

From 10.5.0 onwards, the config.js filename will contain a hash value i.e. config.hashValue.js  

The AcuToWeb service does not need to be restarted after making the change but the browser cache will need to be cleared.  