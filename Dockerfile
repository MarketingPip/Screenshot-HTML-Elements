FROM continuumio/miniconda3:4.9.2-alpine

RUN apt purge google-chrome-stable
RUN pip install chromedriver-autoinstaller selenium pyvirtualdisplay 
RUN apt-get install xvfb
COPY main.py /opt/main.py
ENTRYPOINT ["python", "/opt/main.py"]
