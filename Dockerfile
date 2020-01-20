FROM alpine:latest
MAINTAINER Christoph Dwertmann <christoph.dwertmann@vaultsystems.com.au>
RUN apk --update add ruby ruby-dev ruby-irb libxslt libxml2 curl ruby-webrick ruby-etc
COPY *.gem /
RUN apk --update add --virtual build-dependencies build-base libxml2-dev libxslt-dev curl-dev \
    && echo ":ssl_verify_mode: 0" > ~/.gemrc \
    && gem install fluent-plugin-fortigate-log-parser:0.2.1 fluent-plugin-swift:0.0.4rc2 fluent-plugin-elasticsearch fluent-plugin-multiprocess fluent-plugin-record-modifier json --no-document -- --use-system-libraries \
    && apk del build-dependencies \
    && rm /var/cache/apk/*
RUN mkdir /etc/fluent
CMD ["fluentd","-c","/etc/fluent/fluent.conf"]
