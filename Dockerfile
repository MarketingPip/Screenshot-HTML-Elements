FROM continuumio/miniconda3:4.9.2-alpine

RUN apk purge google-chrome-stable
RUN pip install chromedriver-autoinstaller selenium pyvirtualdisplay 
RUN apk add install xvfb
COPY main.py /opt/main.py
ENTRYPOINT ["python", "/opt/main.py"]
