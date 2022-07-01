FROM continuumio/miniconda3:4.9.2-alpine

RUN apk add --no-cache nginx
COPY main.py /opt/main.py
ENTRYPOINT ["python", "/opt/main.py"]
