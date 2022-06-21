# Pull and Run container
podman pull node
podman run -d --name NODE -it -v "$PWD":/usr/src/app -w /usr/src/app -p 8888 node

# Attach to container
podman exec -it NODE bash

# Remove your container
podman stop NODE
podman rm NODE

# Source
https://dockr.ly/3OqzY5J