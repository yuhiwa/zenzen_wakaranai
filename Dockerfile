FROM jjanzic/docker-python3-opencv

RUN apt-get update \
    && apt-get install -y \
        golang nodejs npm awscli

RUN pip install slackbot Pillow
RUN npm install -g tanzaku

RUN go get -u github.com/greymd/ojichat; \
    go get -u github.com/gyozabu/himechat-cli

RUN mkdir -p slackbot/plugins
COPY run.py slackbot
COPY slackbot_settings.py slackbot
WORKDIR slackbot

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
 && ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "python3", "run.py" ]

