FROM markadams/chromium-xvfb-py3


RUN pip3 install install requests chromedriver-autoinstaller selenium xvfbwrapper


CMD python3 main.py
