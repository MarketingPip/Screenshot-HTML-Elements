FROM continuumio/miniconda3:4.9.2-alpine

RUN apt-get update
COPY main.py /opt/main.py
ENTRYPOINT ["python", "/opt/main.py"]
