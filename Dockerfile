FROM tutum/apache-php
 
ENV DEBIAN_FRONTEND noninteractive
 
RUN apt-get update
 
# Ubuntu Helper Tools (add-apt-repository)
RUN apt-get install -y software-properties-common python-software-properties --no-install-recommends
 
# Common and Build Tools
RUN apt-get install -y vim curl wget build-essential git-core --no-install-recommends
 
# Python and Python Tools
RUN apt-get install -y python-pip python python-dev --no-install-recommends

# ENV NGINX_DOC_ROOT /var/www
# ENV NGINX_LOG_ROOT /var/log/nginx
# ENV SERVER_NAME example.com

WORKDIR /app

ONBUILD RUN virtualenv /env
ONBUILD ADD requirements.txt /app/requirements.txt
ONBUILD RUN /env/bin/pip install -r /app/requirements.txt
ONBUILD ADD . /app

# RUN rm -f /etc/nginx/sites-enabled/default

EXPOSE 80

# CMD /usr/sbin/nginx -c /etc/nginx/nginx.conf

CMD ["/env/bin/python", "main.py"]

# Build with
# docker build --rm -t=book .
# Run with 
# docker run --privileged -p 80:80 -i -t book
# Debug with
# docker run --privileged -p 80:80 -i -t book /bin/bash
# Go to 
# http://think-dev.cs.vt.edu:8080/



