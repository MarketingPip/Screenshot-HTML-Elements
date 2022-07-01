FROM python:3-slim AS builder
ADD . /app
WORKDIR /app

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium pyvirtualdisplay 

# A distroless container image with Python and some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless



FROM gcr.io/distroless/python3-debian10
CMD ["apt-get update"]
CMD ["apt-get install -y xvfb"]

COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["/app/main.py"]


