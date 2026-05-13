# Zig Master Toolchain Template

A high-performance Docker template providing a minimal, production-ready environment for the Zig development branch (master). This image is meticulously crafted to serve as the backbone for building modern systems, including the Spider Web Framework and the Grape Engine.

## Available on Docker Hub

The image is available on Docker Hub: [llllollooll/zig](https://hub.docker.com/repository/docker/llllollooll/zig/general)

## Key Features

- **Daily Updates**: Automatically rebuilt every night with the absolute latest Zig master commits.
- **Multi-arch Support**: Native builds for both `linux/amd64` and `linux/arm64` (including Hetzner CAX series).
- **Minimalist Architecture**: Designed specifically for multi-stage builds to produce ultra-small (sub-1MB) scratch containers.
- **Ecosystem Ready**: Fully compatible with the Spider Web Framework directory hierarchy.

## Build and Push

To build and push a multi-arch image to Docker Hub:

```bash
# Login to Docker Hub
docker login --username llllollooll

# Build and push multi-arch in one step
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg ZIG_VERSION=0.17.0-dev.93+76174e1bc \
  -t llllollooll/zig:master \
  --push .
```

Or use a specific version tag:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg ZIG_VERSION=0.17.0-dev.93+76174e1bc \
  -t llllollooll/zig:master \
  -t llllollooll/zig:0.17.0-dev \
  --push .
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

This image was created based on the excellent work from [ziglang/zig](https://codeberg.org/ziglang/zig) on Codeberg. We would like to express our gratitude to the maintainers for providing the foundation that made this specialized toolchain possible.
