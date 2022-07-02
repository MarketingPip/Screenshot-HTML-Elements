FROM python:3.6
ENV PYTHONUNBUFFERED=1
# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

RUN apt-get install -y xvfb


# upgrade pip
RUN pip install --upgrade pip

# We are installing a dependency here directly into our app source dir
RUN pip install requests webdriver-manager selenium pyvirtualdisplay pyscreenshot


ADD xorg.conf /
ENV DISPLAY :1.0
ADD main.py /
RUN chmod +x main.py
# set display port to avoid crash
ENV DISPLAY=:99

## RUNNING A WEB PAGE ON FIREFOX
CMD ["python3","main.py"]
RUN ["python3","main.py"]


