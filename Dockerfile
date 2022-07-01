FROM python:3-slim AS builder
ADD . /app
WORKDIR /app

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium pyvirtualdisplay

# A distroless container image with Python and some basics like SSL certificates






FROM ubuntu:14.04
MAINTAINER Patrick Merlot <patrick.merlot@gmail.com>
COPY --from=builder /app /app
WORKDIR /app
## inspired from  https://linuxmeerkat.wordpress.com/2014/10/17/running-a-gui-application-in-a-docker-container/
##          and http://manpages.ubuntu.com/manpages/lucid/man1/xvfb-run.1.html


## TEST RUNNING FIREFOX
## INSTALL DEPENDENCIES
RUN apt-get update
RUN apt-get install -y \
    dbus-x11 \
    firefox \
    python-pip \
    xpra \
    xserver-xorg-video-dummy \
    xvfb

ADD main.py /
RUN chmod +x main.py
ADD setup.sh /
RUN chmod +x setup.sh
ADD xorg.conf /
ENV DISPLAY :1.0

## RUNNING A WEB PAGE ON FIREFOX
CMD ["bash","setup.sh"]
