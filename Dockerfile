FROM busybox AS base

LABEL maintainer "ziglings.org"

ENV ZIG_VERSION=master
ENV ZIG_PATH=/zig/${ZIG_VERSION}/files

RUN wget -q https://github.com/marler8997/zigup/releases/download/v2023_07_27/zigup.ubuntu-latest-$(uname -m).zip && \
    unzip zigup.ubuntu-latest-$(uname -m).zip -d /usr/bin \
    && chmod +x /usr/bin/zigup \
    && zigup --install-dir /zig $ZIG_VERSION \
    && chmod -R a+w ${ZIG_PATH} \
    && rm zigup.ubuntu-latest-$(uname -m).zip /usr/bin/zigup

FROM busybox AS build

COPY --from=base /zig/master/files/lib /lib
COPY --from=base /usr/bin/zig /bin/zig

CMD ["sh"]
