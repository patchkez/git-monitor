FROM alpine:3.8

ARG GITMON_BRANCH
ENV CRON_HOME /home/cron

RUN apk --update add --no-cache python3 py-pip git && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install requests yacron gitpython ruamel.yaml

RUN adduser -u 9999 -S -h /home/cron yacron
RUN mkdir ${CRON_HOME}/volume && chown cron:cron ${CRON_HOME}/volume

ADD entrypoint.sh /usr/local/bin
ADD start-cron.sh /usr/local/bin
ADD crontab-example.yaml /var/tmp/

USER yacron
WORKDIR ${CRON_HOME}

# Recharge scripts
RUN git clone https://github.com/patchkez/git-monitor && \
    cd git-monitor && \
    git checkout ${GITMON_BRANCH}

ENV PATH="~/git-monitor/:${PATH}"

VOLUME ["/home/cron/volume"]

WORKDIR ${CRON_HOME}/volume
ENTRYPOINT ["entrypoint.sh"]
CMD ["start-cron.sh"]
