# docker-fluentd-swift
run fluentd with a couple of plugins

    docker run -d -v /mnt/fluent:/etc/fluent -p 24224:24224 -p 24224:24224/udp -p 514:514 -p 514:514/udp --name fluentd-swift vault/fluentd-swift
