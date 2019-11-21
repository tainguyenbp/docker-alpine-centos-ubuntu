#FROM centos:6
FROM centos:7

RUN yum -yqq update \
    && yum install -yqq python-pip python-dev curl gnupg gcc-c++ make \
    # && curl -sL https://rpm.nodesource.com/setup_10.x | bash \
    # && curl -sL https://rpm.nodesource.com/setup_11.x | bash \
    && curl -sL https://rpm.nodesource.com/setup_12.x | bash \
    && yum install -yqq nodejs

ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

RUN cd /usr/src/app && npm install --no-bin-links && npm run build \ 
    && pip install -r requirements.txt \
    && apt-get clean \
    && rm -rf \
    /root/.cache \
    /tmp/* \
    /var/tmp/* \
    /var/cache/yum/* 

EXPOSE 5000

CMD [ "python", "./app.py" ]