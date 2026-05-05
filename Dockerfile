FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        beanstalk \
 && useradd \
        --home-dir /var/lib/beanstalkd \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        beanstalk

FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN apt-get download \
        beanstalkd
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN rm -rf \
        etc/default \
        etc/init.d \
        lib/systemd \
        usr/share

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY etc/ etc/

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8 \
	BEANSTALK_WAL_DIR=/var/lib/beanstalkd \
	BEANSTALK_LISTEN_ADDR=0.0.0.0 \
	BEANSTALK_LISTEN_PORT=11300

COPY --from=build /rootfs /

EXPOSE ${BEANSTALK_LISTEN_PORT:-11300}
