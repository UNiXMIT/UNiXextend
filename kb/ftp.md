# How to use Rocket SFTP to upload and download files

## Solution
Rocket SFTP can be used to upload/download large files.  
- Uploading Large Files: Use Rocket SFTP to send large files that exceed the case upload limit (e.g. Enterprise Server diagnostics, sample projects).  
- Downloading Large Files: Rocket SFTP is used to deliver large files (e.g. product installers, patch updates).  

The hostname and credentials, to access the SFTP server, will be sent by the support engineer assigned to the case.  
The credentials for uploading and downloading are different, so ensure too use the credentials sent by the engineer and not credentials that have been sent previously.  
The SFTP server is accessible using an SFTP client (e.g. WinSCP, FileZilla, Cyberduck) or using the sftp commands in a command terminal.   

#### Upload
It is a good idea to compress all necessary files into one archive (.zip or .tar.gz etc.) and rename that archive file to include the case number that the files relate to (i.e. 12345678.zip).  
Files remain in Rocket SFTP for 90 days.  
After uploading the files to Rocket SFTP, please update the case and provide the names of the uploaded files for the support engineers reference.  

#### Download
Files made available to download will be available for 14 days after they were uploaded.  

### Using an SFTP Client  
Open your SFTP client and locate the session manager or connection dialog.  
Enter your credentials in the appropriate fields.  
Use the credentials sent by the support engineer, ensure the protocol is SFTP and port is 22.  

Once connected, most clients display a dual-pane interface:  

- Local Pane (Local Computer): Shows files and folders on the local machine.  

- Remote Pane (The Server): Shows files and folders on the remote server once connected.  

Navigate these panes just like a computer's file explorer.  

#### Core Actions  

- Uploading: Select file(s) on the local pane and drag them to the remote pane.  

- Downloading: Select file(s) in the remote pane and drag them to the local pane.  

For detailed, software-specific instructions, menus, and advanced features, always refer to the official documentation for your chosen SFTP client.  

### Using the sftp commands in a command terminal 
To connect, type the sftp command followed by the username and server's hostname, separated with an @:  
```
sftp <username>@<hostname>
```

After connecting, it will prompt for the password:  
```
username@hostname's password: <password>
```

To go to another directory, use the cd command:  
```
sftp> cd <directory-name>
```

To see all files and folders where you are, use the dir command:  
```
sftp> dir
```

To download a file from the server, use the get command with the file name:  
```
sftp> get <file-name>
```

To download multiple files from the current directory, use the mget command with a wildcard:  
```
sftp> mget *
```

To send a file to the server, use the put command with the file name:  
```
sftp> put <file-name>
```

To leave the SFTP client, type the quit command:
```
sftp> quit
```