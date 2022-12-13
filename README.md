# owntone-docker
OwnTone Docker image

https://hub.docker.com/r/matthenning/owntone

You need to pass your desired admin password via environment variable `OWNTONE_PASSWORD` and map your media directory to `/srv/music`.
Additionally you can set `OWNTONE_UID` and `OWNTONE_GID` to change the owntone user's uid and gid. This can be useful to map the container users to a host user with permissions on the mapped media volume.

Example:

```
docker run -p 3689:3689 -e OWNTONE_PASSWORD='password' -e OWNTONE_UID='1234' -e OWNTONE_GID='1234' -v /media/music:/srv/music -d matthenning/owntone:latest
```
