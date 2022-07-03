FROM debian:stable 
LABEL maintainer "Sean Pianka <pianka@eml.cc>"

## For chromedriver installation: curl/wget/libgconf/unzip
RUN apt-get update -y && apt-get install -y wget curl unzip libgconf-2-4
## For project usage: python3/python3-pip/chromium/xvfb
RUN apt-get update -y && apt-get install -y chromium xvfb python3 python3-pip 


# Download, unzip, and install chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/


# Create directory for project name (ensure it does not conflict with default debian /opt/ directories).
RUN mkdir -p /opt/app
WORKDIR /opt/app


## Your python project dependencies

RUN pip3 install requests chromedriver_autoinstaller selenium pyvirtualdisplay pyscreenshot


COPY main.py .


# Set display port and dbus env to avoid hanging
ENV DISPLAY=:99
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null


# Bash script to invoke xvfb, any preliminary commands, then invoke project
COPY run.sh .
RUN chmod +x  /bin/bash run.sh
