from pyinfra.operations import apt, server

apt.upgrade(
    name="Upgrade apt packages",
    _sudo=True
)
