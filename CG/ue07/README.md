## Run with docker

```sh
podman build . -t cg7 && podman run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri cg7
```
