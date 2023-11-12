# NodeJS

### Pull and Run container
```
podman pull node
podman run -dit --name node -p 8081:8081 node
```

### Attach to container
```
podman exec -it node bash
```

### Setup api.js
```
podman exec -it node curl -s -o /home/node/api.js https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/api.js
podman exec -it node npm install --prefix /home/node busboy
podman exec -it node node /home/node/api.js
```

### See Uploaded files in /tmp
```
podman exec -it node ls /tmp
```

### Run api.js as a service using Forever
```
podman exec -it node npm install forever -g
podman exec -it node forever start /home/node/api.js
podman exec -it node forever stop /home/node/api.js
podman exec -it node forever list
```

### Remove your container
```
podman stop node
podman rm node
```

### Source
https://dockr.ly/3a2xfkq  