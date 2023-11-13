# MiniCA
### Pull and Run container
```
podman pull golang:latest
podman run -itd --name minica -v /home/support/minica:/go golang:latest
```

### Install MiniCA
```
podman exec -it minica go install github.com/jsha/minica@latest
```

### Generate key and cert
Generate a root key and cert in minica-key.pem, and minica.pem, then  
generate and sign an end-entity key and cert, storing them in ./foo.com/  
```
podman exec -it minica minica --domains foo.com
```
Wildcard
```
podman exec -it minica minica --domains '*.foo.com'
```

### Install Root CA on Windows
```
certutil -user -addstore "Root" minica.pem
```

### Remove your container
```
podman stop minica
podman rm minica
```