# NVidia/AMD lc0-server image

This docker image is based on the sonm/opencl image (only available in Github).

# Usage

## Running with NVidia GPUs
Requirements:
- NVidia Docker 2 installed

```bash
docker run --runtime=nvidia boldpawn/lc0-server
```

## Running with AMD GPUs
Requirements:
- AMD drivers installed

```bash
docker run --device /dev/dri:/dev/dri boldpawn/lc0-server
```

## Limitations
This images does not run on a macbook (because of the GPU drivers).
It does run on a linux docker host (tested with debian 9)
