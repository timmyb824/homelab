from pyinfra.operations import apt, server

apt.update(
    name="Update apt repositories",
    cache_time=3600,
    _sudo=True
)
