FROM continuumio/miniconda3:4.9.2-alpine

RUN apk update && apk add --no-cache bash \
        alsa-lib \
        at-spi2-atk \
        atk \
        cairo \
        cups-libs \
        dbus-libs \
        eudev-libs \
        expat \
        flac \
        gdk-pixbuf \
        glib \
        libgcc \
        libjpeg-turbo \
        libpng \
        libwebp \
        libx11 \
        libxcomposite \
        libxdamage \
        libxext \
        libxfixes \
        tzdata \
        libexif \
        udev \
        xvfb \
        zlib-dev \
        chromium \
        chromium-chromedriver
RUN apk update
RUN apk add xvfb
RUN apk update
RUN apk add py-pip
RUN pip install chromedriver-autoinstaller selenium pyvirtualdisplay 
COPY main.py /opt/main.py
ENTRYPOINT ["python", "/opt/main.py"]
