FROM python:3-slim AS builder
ADD . /app
WORKDIR /app

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium pyvirtualdisplay 

# A distroless container image with Python and some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/python3-debian10
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
RUN wget http://security.ubuntu.com/ubuntu/pool/main/a/apt/apt_1.4_amd64.deb

RUN dpkg -i apt_1.4_amd64.deb
RUN apt-get update
RUN apt-get install -y xvfb
CMD ["/app/main.py"]


