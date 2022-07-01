FROM markadams/chromium-xvfb-py3


RUN pip3 install install requests chromedriver-autoinstaller selenium pyvirtualdisplay


CMD python3 main.py
