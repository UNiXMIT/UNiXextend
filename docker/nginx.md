# NGiNX
### Pull and Run container
```
podman pull nginx:latest
podman run --name nginx -p 8080:80 -v /some/content:/usr/share/nginx/html:ro -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx:latest
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