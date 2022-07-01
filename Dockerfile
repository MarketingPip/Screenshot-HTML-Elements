FROM python:3-slim AS builder
ADD . /app
WORKDIR /app

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium xvfbwrapper

# A distroless container image with Python and some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless


FROM markadams/chromium-xvfb-py3:latest-onbuild
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app

#RUN apt-get update
#RUN apt-get install -y xvfb
CMD ["/app/main.py"]
