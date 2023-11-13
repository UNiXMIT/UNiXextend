# Redis
### Pull and Run container
```
podman pull redis
podman run --name redis -p 6379:6379 -d redis
```

### Attach to container
```
podman exec -it redis bash
```

### Remove your container
```
podman stop redis
podman rm redis
```

### Source
https://dockr.ly/3HrYkJi