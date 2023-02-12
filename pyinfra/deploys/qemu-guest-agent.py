from pyinfra.operations import apt, systemd, server

apt.packages(
        name="Install qemu-guest-agent package",
        packages=["qemu-guest-agent"],
        update=True,
        _sudo=True,
        cache_time=3600,
        present=True
    ) # type: ignore

systemd.service(
    name="Enable qemu-guest-agent",
    service="qemu-guest-agent",
    running=True,
    enabled=True,
    _sudo=True,
    _use_sudo_password=True
) # type: ignore

server.reboot(
    name="Reboot the server",
    delay=5,
    interval=1,
    reboot_timeout=30,
    _sudo=True,
    _use_sudo_password=True
)