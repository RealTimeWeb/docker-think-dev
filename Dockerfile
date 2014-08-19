FROM tutum/apache-php
 
ENV DEBIAN_FRONTEND noninteractive
 
RUN apt-get update
 
# Ubuntu Helper Tools (add-apt-repository)
RUN apt-get install -y software-properties-common python-software-properties --no-install-recommends
 
# Common and Build Tools
RUN apt-get install -y vim curl wget build-essential git-core --no-install-recommends
 
# Python and Python Tools
RUN apt-get install -y python-pip python python-dev supervisor --no-install-recommends

WORKDIR /app

ONBUILD RUN virtualenv /env
ONBUILD ADD requirements.txt /app/requirements.txt
ONBUILD RUN /env/bin/pip install -r /app/requirements.txt
ONBUILD ADD . /app

EXPOSE 80

CMD ["/env/bin/python", "main.py"]

# Build with
# docker build --rm -t=comp-think .
# Run with 
# docker run --privileged -p 80:80 -i -t comp-think
# Debug with
# docker run --privileged -p 80:80 -i -t comp-think /bin/bash
# Go to 
# http://think-dev.cs.vt.edu:8080/



