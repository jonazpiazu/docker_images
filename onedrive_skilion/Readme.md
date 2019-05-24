# Onedrive client for Linux

Usage:

```bash
docker run -it \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -v ~/Onedrive/config:/config \
    -v ~/Onedrive/data:/onedrive \
    onedrive_skilion
```