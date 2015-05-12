FROM alpine
RUN apk --update add ruby ruby-dev libxslt libxml2
RUN apk add --virtual build-dependencies build-base libxml2-dev libxslt-dev libiconv-dev \
    && echo ":ssl_verify_mode: 0" > ~/.gemrc \
    && gem install fluentd fluent-plugin-record-reformer fluent-plugin-swift fluent-plugin-parser fluent-plugin-fortigate-log-parser fluent-plugin-elasticsearch --no-rdoc --no-ri -- --use-system-libraries \
    && apk del build-dependencies
RUN mkdir /etc/fluent
CMD ["fluentd","-c","/etc/fluent/fluent.conf"]
