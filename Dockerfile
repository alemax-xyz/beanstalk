FROM library/ubuntu:xenial AS build

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
RUN apt-get update && \
    apt-get install -y \
        python-software-properties \
        software-properties-common \
        apt-utils

RUN mkdir -p /build/image
WORKDIR /build
RUN apt-get download \
    beanstalkd \
    netbase \
    libsystemd0 \
    libgcrypt20 \
    liblzma5 \
    libgpg-error0
RUN for file in *.deb; do dpkg-deb -x ${file} image/; done

WORKDIR /build/image
RUN rm -rf \
        etc/default \
        etc/init.d \
        etc/network \
        lib/systemd \
        usr/share


FROM clover/base

WORKDIR /
COPY --from=build /build/image /

CMD ["beanstalkd", "-b", "/var/lib/beanstalkd"]

EXPOSE 11300
