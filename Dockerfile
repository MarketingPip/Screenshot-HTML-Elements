FROM alpine:3.15  AS builder
ADD . /app
WORKDIR /app

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN apk add --no-cache xvfb

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium pyvirtualdisplay


ADD xorg.conf /
ENV DISPLAY :1.0




# A distroless container image with Python and some basics like SSL certificates


FROM ubuntu:14.04
MAINTAINER Patrick Merlot <patrick.merlot@gmail.com>
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
RUN python main.py

# make some useful symlinks that are expected to exist ("/usr/local/bin/python" and friends)



