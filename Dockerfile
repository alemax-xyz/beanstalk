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

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/common:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN rm -rf \
        etc/default \
        etc/init.d \
        lib/systemd \
        usr/share

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY rootfs/ .

WORKDIR /

FROM clover/common

ENV LANG=C.UTF-8 \
	BEANSTALK_WAL_DIR=/var/lib/beanstalkd \
	BEANSTALK_LISTEN_ADDR=0.0.0.0 \
	BEANSTALK_LISTEN_PORT=11300

COPY --from=build /rootfs /

EXPOSE ${BEANSTALK_LISTEN_PORT:-11300}
