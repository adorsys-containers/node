[![](https://img.shields.io/docker/pulls/adorsys/node.svg?logo=docker)](https://hub.docker.com/r/adorsys/node/)
[![](https://img.shields.io/docker/stars/adorsys/node.svg?logo=docker)](https://hub.docker.com/r/adorsys/node/)

# adorsys/node

https://hub.docker.com/r/adorsys/node/

## Description

Provides node. Should be used for runtime containers.

## Example Dockerfile

```dockerfile
FROM adorsys/node:12-ubi

COPY . .

CMD ["node", "server.js"]
```

If want to exclude files from your docker image, e.g. documentation, 
use a [`.dockerignore`](https://docs.docker.com/engine/reference/builder/#dockerignore-file) file.

## Memory limit auto configuration

Like Java, node has a virtual machine, too. The V8 VM which has a default heap space of
`1200M`. 

To avoid out of memory errors we auto configure the heapspace by 80% of the docker memory limited.
You can configure the ratio via environment variable `NODE_MEMORY_LIMIT_PERCENT` oder disable it via `ENABLE_AUTO_NODE_MEMORY_LIMIT`.

See [https://medium.com/@vuongtran/how-to-solve-process-out-of-memory-in-node-js-5f0de8f8464c](https://medium.com/@vuongtran/how-to-solve-process-out-of-memory-in-node-js-5f0de8f8464c) for more information.

## Environment variables

| Name | Description | Default |
| ---- | ----------- | ------- |
| ENABLE_AUTO_NODE_MEMORY_LIMIT | Enable Memory limit auto configuration | `true` |
| NODE_MEMORY_LIMIT_PERCENT | ratio of memory limit | `80` |

## Entrypoint hooks

If you need to run addition logic on container start just copy your shell script to `/docker-entrypoint.d/`.

## Tags

| Name | Description | Size |
| ---- | ----------- | ---- |
| `10` | Alias of `10-ubi-8` | ![](https://images.microbadger.com/badges/image/adorsys/node:10.svg) |
| `12` | Alias of `12-ubi-8` | ![](https://images.microbadger.com/badges/image/adorsys/node:12.svg) |
| `14` | Alias of `14-ubi-8` | ![](https://images.microbadger.com/badges/image/adorsys/node:14.svg) |
| `10-ubi-8` | UBI based image Node 10 | ![](https://images.microbadger.com/badges/image/adorsys/node:10-ubi.svg) |
| `12-ubi-8` | UBI based image Node 12 | ![](https://images.microbadger.com/badges/image/adorsys/node:12-ubi.svg) |
| `14-ubi-8` | UBI based image Node 14 | ![](https://images.microbadger.com/badges/image/adorsys/node:14-ubi.svg) |
