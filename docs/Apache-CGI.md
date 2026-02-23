# How to setup AcuCOBOL-GT extend with Apache/CGI in RHEL 9

## Prerequisites
- Apache HTTP Server installed  
- AcuCOBOL-GT extend installed

## Configure Apache for CGI
Enable the CGI module:
This is usually in a dedicated .conf file '/etc/httpd/conf.modules.d/01-cgi.conf':
```
<IfModule !mpm_prefork_module>
   LoadModule cgid_module modules/mod_cgid.so
</IfModule>
<IfModule mpm_prefork_module>
   LoadModule cgi_module modules/mod_cgi.so
</IfModule>
```
The config file '/etc/httpd/conf.modules.d/01-cgi.conf' is loaded by default from '/etc/httpd/conf/httpd.conf' using the 'Include' directive:
```
Include conf.modules.d/*.conf
```
Restart Apache:
```
sudo systemctl restart httpd
```

## ScriptAlias Directive
The ScriptAlias directive maps a URL path (e.g., /cgi-bin/) to a filesystem directory (e.g., /var/www/cgi-bin). It tells Apache that files in this directory are CGI scripts and should be executed, not served as static files.  
Edit Apache's main configuration file at '/etc/httpd/conf/httpd.conf' and add or modify the ScriptAlias line:  
```
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
```
/cgi-bin/ (URL path): Clients access scripts via http://example.com/cgi-bin/script.sh.  
/var/www/cgi-bin/ (filesystem path): The actual location of scripts on the server.  

## Directory Block for cgi-bin
Add or modify a Directory block to enforce security and behaviour the cgi-bin directory:
```
<Directory "/var/www/cgi-bin">
    AllowOverride None  # Disables .htaccess files for security.
    Options +ExecCGI  # Enable CGI execution
    AddHandler cgi-script .sh  # File extensions treated as CGI scripts
    Require all granted  # Allow access from all clients (adjust for production)
</Directory>
```
Restart Apache:
```
sudo systemctl restart httpd
```

## CGI Script
Create oscars.sh in the '/var/www/cgi-bin/' directory
```
#!/bin/bash
export ACUCOBOL="/home/products/acu1101shx64"
export ACUSUP="/home/support/AcuSupport"
export TERM="xterm"
export PATH="/home/products/acu1101shx64/bin:$PATH"
export LD_LIBRARY_PATH="/home/products/acu1101shx64/bin:/home/products/acu1101shx64/lib:$LD_LIBRARY_PATH"
export A_TERMCAP="/home/products/acu1101shx64/etc/a_termcap"
RUNTIME=/home/products/acu1101shx64/bin/runcbl
exec $RUNTIME -f -b oscars.acu
```
Make it executable:
```
sudo chmod +x oscars.sh
```

## Setup the oscars sample files
Modify the oscars.html POST action URL:
```
<FORM method="post" action="http://example.com/cgi-bin/oscars.sh">
```
Compile the COBOL program:
```
ccbl oscars.cbl
```
Copy the oscars sample files to the appropriate locations:
```
sudo cp /home/products/acu1101shx64/sample/cgi/oscars.htm /var/www/html
sudo cp /home/products/acu1101shx64/sample/cgi/{header.htm,body.htm,footer.htm,oscars.acu} /var/www/cgi-bin
```

## Run the oscars sample
Now when the oscars form is submitted at 'http://example.com/oscars.htm', the results will be displayed at 'http://example.com/cgi-bin/oscars.sh'