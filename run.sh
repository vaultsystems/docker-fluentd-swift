#!/bin/bash
mkdir /etc/fluent
cat > /etc/fluent/fluent.conf <<EOF
<source>
  type tail
  path /var/lib/docker/containers/*/*-json.log
  pos_file /var/log/fluentd-docker.pos
  time_format %Y-%m-%dT%H:%M:%S
  tag docker.*
  format json
</source>
<match docker.var.lib.docker.containers.*.*.log>
  type record_reformer
  container_id \${tag_parts[5]}
  tag docker.all
</match>
<match docker.all>
  type swift

  auth_url $OS_AUTH_URL/tokens
  auth_user $OS_USERNAME
  auth_tenant $OS_TENANT_NAME
  auth_api_key $OS_PASSWORD
  swift_container docker_logs
  swift_object_key_format %{path}%{time_slice}_%{index}.%{file_extension}

  path logs/
  buffer_path /var/log/fluent/swift

  time_slice_format %Y%m%d-%H
  time_slice_wait 10m
</match>
EOF
fluentd -c /etc/fluent/fluent.conf