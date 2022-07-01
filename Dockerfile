FROM debian:stable as display
ADD . /app
WORKDIR /app
RUN apt-get update && apt-get install  -y curl xvfb chromium
#COPY pin_nodesource /etc/apt/preferences.d/nodesource

ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser




FROM python:3-slim AS builder
ADD . /app
WORKDIR /app

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium xvfbwrapper

# A distroless container image with Python and some basics like SSL certificates



FROM gcr.io/distroless/python3-debian10



COPY --from=display /app /app
WORKDIR /app

COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["/app/main.py"]
 
