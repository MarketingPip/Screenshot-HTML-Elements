FROM python:3.9
ENV PYTHONUNBUFFERED=1
# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y chromium-driver
RUN apt-get install -y xvfb

# set display port to avoid crash
ENV DISPLAY=:99

# upgrade pip
RUN pip install --upgrade pip

RUN pip install requests chromedriver_autoinstaller selenium pyvirtualdisplay pyscreenshot


ADD main.py /
RUN chmod +x main.py


## RUNNING A WEB PAGE ON FIREFOX
CMD ["python3","main.py"]
RUN ["python3","main.py"]
