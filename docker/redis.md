# Redis
### Pull and Run container
```
podman pull redis
podman run --name REDIS -p 6379:6379 -d redis
```

### Attach to container
```
podman exec -it REDIS bash
```

### Remove your container
```
podman stop REDIS
podman rm REDIS
```

### Source
https://dockr.ly/3HrYkJi