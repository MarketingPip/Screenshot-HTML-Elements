FROM alpine:3.15  
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
RUN pip3 install --target=/app install requests chromedriver-autoinstaller selenium pyvirtualdisplay


ADD xorg.conf /
ENV DISPLAY :1.0
ADD main.py /
RUN chmod +x main.py

## RUNNING A WEB PAGE ON FIREFOX
CMD ["python3","main.py"]
RUN ["python3","main.py"]
