from pyinfra.operations import server

server.reboot(
    name="Reboot the server",
    delay=5,
    interval=1,
    reboot_timeout=30,
    _sudo=True,
    _use_sudo_password=True
)
