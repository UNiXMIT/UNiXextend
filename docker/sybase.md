# Sybase

### Pull and Run container
```
podman pull datagrip/sybase
podman run -d -t -p 5000:5000 --name sybase datagrip/sybase
```

### Guest User

Environment variable	Default value  
SYBASE_USER	            tester  
SYBASE_PASSWORD	        guest1234  
SYBASE_DB	            testdb  


### Admin User
Environment variable	Default value  
SYBASE_USER	            sa  
SYBASE_PASSWORD         myPassword  


### Attach to container
```
podman exec -it sybase bash
```

### Remove your container
```
podman stop sybase
podman rm sybase
```

### Source
https://dockr.ly/2VofqCc  