from pyinfra.operations import apt

apt.packages(
        name="Install nice to have packages",
        packages=[
            "htop",
            "jq",
            "bat",
            "cpu-checker",
            "magic-wormhole",
            "silversearcher-ag",
            "tree",
            "ripgrep"
        ],
        update=True,
        _sudo=True,
        cache_time=3600,
        present=True
    ) # type: ignore
