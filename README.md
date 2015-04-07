# docker-fluentd-swift
collect logs from docker containers and upload them to swift container

docker run -d -e "OS_AUTH_URL={{ os_auth_url }}" -e "OS_TENANT_NAME={{ os_tenant_name }}" -e "OS_USERNAME={{ os_username }}" -e "OS_PASSWORD={{ os_password }}" -v /var/lib/docker/containers:/var/lib/docker/containers --name fluentd-swift vault/fluentd-swift
