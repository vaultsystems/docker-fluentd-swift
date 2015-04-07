FROM kiyoto/fluentd:0.10.56-2.1.1
ADD run.sh /opt/
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-record-reformer", "fluent-plugin-swift", "--no-rdoc", "--no-ri"]
ENTRYPOINT ["/opt/run.sh"]
