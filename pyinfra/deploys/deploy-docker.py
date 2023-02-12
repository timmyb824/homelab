from pyinfra import config
from pyinfra.operations import server

from docker_ce import deploy_docker

config.SUDO = True

deploy_docker(
    # config={
    #     "dns": ["8.8.8.8", "8.8.4.4"],
    #     "debug": True,
    # },
    config={
    "log-driver": "gelf",
    "log-opts": {
        "gelf-address": "udp://192.168.86.132:12201"
        }
    },
)  # type: ignore

server.service(
    name="Ensure docker service is running",
    service="docker",
    running=True,
    enabled=True,
) # type: ignore