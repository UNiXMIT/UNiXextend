# NGiNX
### Pull and Run container
```
podman pull nginx:latest
podman run --name nginx -p 80:80 -p 443:443 -v /home/support/nginx:/config -e PUID=1000 -e PGID=1000 -e TZ=Europe/London -d lscr.io/linuxserver/nginx:latest
```

### Attach to container
```
podman exec -it nginx bash
```

### Remove your container
```
podman stop nginx
podman rm nginx
```