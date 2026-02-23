FROM debian:bookworm-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    xz-utils \
    libpq-dev \
    && for f in /usr/include/postgresql/*.h; do ln -sf "$f" "/usr/include/$(basename $f)"; done \
    && rm -rf /var/lib/apt/lists/*

LABEL author="spider.org"
LABEL description="Minimal docker container for using the Zig toolchain for automated testing."

ENV ZIG_VERSION=master
ENV ZIG_PATH=/zig/${ZIG_VERSION}/files

RUN curl -L https://github.com/marler8997/zigup/releases/download/v2024_03_13/zigup.ubuntu-latest-x86_64.zip -o /tmp/zigup.zip && \
    unzip /tmp/zigup.zip -d /usr/bin \
    && chmod +x /usr/bin/zigup \
    && zigup $ZIG_VERSION --install-dir /zig \
    && chmod -R a+w ${ZIG_PATH} \
    && rm /tmp/zigup.zip /usr/bin/zigup

FROM debian:bookworm-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    && for f in /usr/include/postgresql/*.h; do ln -sf "$f" "/usr/include/$(basename $f)"; done \
    && rm -rf /var/lib/apt/lists/*

COPY --from=base /zig/master/files/lib /lib
COPY --from=base /zig/master/files/zig /bin/zig
RUN /bin/zig version

CMD ["sh"]
