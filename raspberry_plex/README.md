# Plex for Raspberry Pi

Heavily based on the [LinuxServer.io image](https://store.docker.com/community/images/linuxserver/plex).

```
docker build . -t raspberry_plex
docker create --name=plex --net=host -v /home/pi/Videos/:/data/tvshows -v /home/pi/Videos/:/data/movies raspberry_plex
docker start plex
```
