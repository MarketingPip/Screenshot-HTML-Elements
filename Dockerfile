FROM docker.io/bitnami/minideb:bullseye
ENV OS_ARCH="amd64" \
    OS_FLAVOUR="debian-11" \
    OS_NAME="linux"


# Install required system packages and dependencies
RUN install_packages build-essential dbus-x11 ca-certificates  xvfb curl git gzip libbz2-1.0 libc6 libcom-err2 libcrypt1 libffi7 libgssapi-krb5-2 libk5crypto3 libkeyutils1 libkrb5-3  libkrb5support0 liblzma5 libncursesw6 libnsl2 libreadline8 libsqlite3-0 libsqlite3-dev libssl-dev libssl1.1 libtinfo6 libtirpc3 pkg-config procps tar unzip wget zlib1g
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/python-3.7.13-152-linux-amd64-debian-11.tar.gz && \
    echo "cfa4074f87f8ecb36b5d8d43b2e3cea1887327a0cb7430fb0f0e4e335afa37aa  /tmp/bitnami/pkg/cache/python-3.7.13-152-linux-amd64-debian-11.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/python-3.7.13-152-linux-amd64-debian-11.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/python-3.7.13-152-linux-amd64-debian-11.tar.gz
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
    
RUN apt-get update
RUN apt-get install -y \
    dbus-x11 \
    python3-pip \
    xserver-xorg-video-dummy \
    xvfb



ADD xorg.conf /
ENV DISPLAY :1.0
CMD [ "python main.py" ]

# make some useful symlinks that are expected to exist ("/usr/local/bin/python" and friends)



