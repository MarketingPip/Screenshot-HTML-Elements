FROM markadams/chromium-xvfb-py3

RUN apt-get update && apt-get install -y \
    python3 python3-pip curl unzip libgconf-2-4

RUN pip3 install install requests chromedriver-autoinstaller selenium xvfbwrapper


CMD python3 main.py
