# Docker

## Disable buildkit

    export DOCKER_BUILDKIT=0

## Disable "new progress output"

    docker build --progress plain

Or:

    BUILDKIT_PROGRESS=plain 

https://stackoverflow.com/questions/67537349/enable-progress-plain-in-docker-compose-file
https://stackoverflow.com/questions/75763024/how-to-see-all-output-when-executing-docker-build

## Rebuild image without cache

https://www.howtogeek.com/devops/how-to-make-docker-rebuild-an-image-without-its-cache/

```
docker build --no-cache ...
```
