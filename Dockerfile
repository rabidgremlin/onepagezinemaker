FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get -y install python3.6 python3-pip texlive-xetex

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . .

# Install production dependencies.
RUN pip3 install -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app