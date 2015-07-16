FROM alpine:2.7
RUN apk --update add ruby ruby-dev libxslt libxml2
RUN apk --update add --virtual build-dependencies build-base libxml2-dev libxslt-dev \
    && echo ":ssl_verify_mode: 0" > ~/.gemrc \
    && gem install fluentd fluent-plugin-record-reformer fluent-plugin-swift fluent-plugin-parser fluent-plugin-fortigate-log-parser fluent-plugin-elasticsearch fluent-plugin-multiprocess --no-rdoc --no-ri -- --use-system-libraries \
    && apk del build-dependencies
RUN setup-timezone -z /usr/share/zoneinfo/Australia/Sydney
RUN mkdir /etc/fluent
CMD ["fluentd","-c","/etc/fluent/fluent.conf"]
