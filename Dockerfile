# Get the python 3.8 base docker image
FROM python:3.8 as builder
# Install pipenv
RUN pip install pipenv
# Copy your Pipfile and Pipfile.lock in your container
COPY Pipfile .
COPY Pipfile.lock .
# Install all the dependencies from your lock file directly into the # container
RUN pipenv install — system — deploy
RUN pip install --target=/app install requests chromedriver-autoinstaller selenium pyvirtualdisplay 

# A distroless container image with Python and some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless



FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root
CMD ["apt-get update"]
CMD ["apt-get install -y xvfb"]
# Define default command.
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["python3.8 /app/main.py"]




