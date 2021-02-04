FROM python:latest

ARG branch_name=master

RUN apt-get update && apt-get -y install cron wget unzip python-pyqt5 libssl-dev libcurl4-openssl-dev
RUN wget https://github.com/blawar/nut/archive/v3.1.zip && \
    unzip v3.1.zip -d /root && \
    mv /root/nut-3.1 /root/nut-master && \
    cd /root/nut-master && \
    rm v3.1.zip && \
    rm -rf /root/nut-master/windows_driver && \
    pip3 install -r requirements.txt

COPY /entrypoint.sh /
COPY conf /root/nut-master/conf

RUN chmod +x /entrypoint.sh

RUN touch /var/log/cron.log

EXPOSE 9000

ENTRYPOINT ["sh", "/entrypoint.sh"]

