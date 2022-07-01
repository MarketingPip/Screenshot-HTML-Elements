# A distroless container image with Python and some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/python3-debian10
RUN pip install requests chromedriver-autoinstaller selenium pyvirtualdisplay
CMD ["python main.py"]
