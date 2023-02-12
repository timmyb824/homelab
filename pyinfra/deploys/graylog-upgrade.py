from pyinfra.operations import apt, server


apt.packages(
        name="Update and install latest graylog-server packages",
        packages=["graylog-server", "graylog-enterprise-plugins", "graylog-integrations-plugins", "graylog-enterprise-integrations-plugins"],
        update=True,
        _sudo=True,
        cache_time=3600,
        present=True
    ) # type: ignore

server.service(
    name="Restart graylog-server service",
    service="graylog-server",
    restarted=True
) # type: ignore