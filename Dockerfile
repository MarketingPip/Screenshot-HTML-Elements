FROM continuumio/miniconda3:4.9.2-alpine
RUN apk update
RUN apk add py-pip
RUN pip install chromedriver-autoinstaller selenium pyvirtualdisplay 
COPY main.py /opt/main.py
ENTRYPOINT ["python", "/opt/main.py"]
