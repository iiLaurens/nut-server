FROM python:latest

MAINTAINER marcel@marquez.fr

ARG branch_name=master

RUN apt-get update && apt-get -y install cron wget unzip python-pyqt5 libssl-dev libcurl4-openssl-dev
RUN wget https://github.com/blawar/nut/archive/master.zip && \
    unzip master -d /root && \
    cd /root/nut-master && \
    pip3 install -r requirements.txt

COPY /entrypoint.sh /
COPY conf /root/nut-master/conf

RUN chmod +x /entrypoint.sh

RUN touch /var/log/cron.log && touch /var/log/nut.log

EXPOSE 9000

ENTRYPOINT ["sh", "/entrypoint.sh"]

