FROM ubuntu:16.04

RUN apt-get -yqq update \
&& apt-get install -yqq \
python-pip \
python-dev \
curl \
gnupg \
&& curl -sL https://deb.nodesource.com/setup_10.x | bash \
&& apt-get install -yqq nodejs

ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

RUN npm \
install \
run build \ 
&& pip install -r requirements.txt \
&& apt-get clean \
&& rm -rf \
/root/.cache \
/tmp/* \
/var/tmp/* \
/var/lib/apt/lists/*

EXPOSE 5000

CMD [ "python", "./app.py" ]