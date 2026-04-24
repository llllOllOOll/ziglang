# Zig Master Toolchain Template

A high-performance Docker template providing a minimal, production-ready environment for the Zig development branch (master). This image is meticulously crafted to serve as the backbone for building modern systems, including the Spider Web Framework and the Grape Engine.

## Available on Docker Hub

The image is available on Docker Hub: [llllollooll/zig](https://hub.docker.com/repository/docker/llllollooll/zig/general)

## Key Features

- **Daily Updates**: Automatically rebuilt every night with the absolute latest Zig master commits.
- **PostgreSQL Ready**: Pre-installed libpq-dev with headers symlinked to standard paths (`/usr/include/libpq-fe.h`, etc.) - works out of the box with libpq.
- **Minimalist Architecture**: Designed specifically for multi-stage builds to produce ultra-small (sub-1MB) scratch containers.
- **Ecosystem Ready**: Fully compatible with the Spider Web Framework directory hierarchy.

## Build and Push

To build and push a new version to Docker Hub:

```bash
# Login to Docker Hub
docker login --username llllollooll

# Build the image
docker build -t llllollooll/zig:master .

# Push to Docker Hub
docker push llllollooll/zig:master
```

Or use the `:0.17.0` tag for a specific version:

```bash
docker tag llllollooll/zig:master llllollooll/zig:0.17.0
docker push llllollooll/zig:0.17.0
```

## Quick Integration

Use this image as a builder stage in your Dockerfile:

```dockerfile
FROM llllollooll/zig:master AS builder

WORKDIR /app
COPY . .
RUN zig build -Doptimize=ReleaseSmall -Dtarget=x86_64-linux-musl
```

## Credits

This image was created based on the excellent work from [ziglang/ziglang](https://codeberg.org/ziglang/ziglang) on Codeberg. We would like to express our gratitude to the maintainers for providing the foundation that made this specialized toolchain possible.