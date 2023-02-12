from pyinfra.operations import apt, server, files
from pyinfra.facts.files import Directory
from pyinfra import host
from pyinfra.api.exceptions import DeployError
from pyinfra.api.deploy import deploy

pythonVersion = "3.10.2"
userName = os.environ['ssh_user']

@deploy("Deploy python with pyenv")
def deploy_python():
    if host.get_fact(Directory, path=f"/home/{userName}/.pyenv") is None:

        apt.packages(
            name="install pyenv dependencies",
            packages=[
                "make",
                "build-essential",
                "libssl-dev",
                "zlib1g-dev",
                "libbz2-dev",
                "libreadline-dev",
                "libsqlite3-dev",
                "wget",
                "curl",
                "llvm",
                "libncursesw5-dev",
                "xz-utils",
                "tk-dev",
                "libxml2-dev",
                "libxmlsec1-dev",
                "libffi-dev",
                "liblzma-dev",
                "git"
                ],
            update=True,
            _sudo=True,
            cache_time=3600,
            present=True
            )  # type: ignore


        server.shell(
            name=f"Install pyenv",
            commands=["curl https://pyenv.run | bash"]
            )

        for line in [
            'export PYENV_ROOT="$HOME/.pyenv"',
            'export PATH="$PYENV_ROOT/bin:$PATH"',
            'eval "$(pyenv init -)"',
            'eval "$(pyenv virtualenv-init -)"',
            ]:
            files.line(
                name=f"Add paths to the bashrc file",
                path=f"/home/{userName}/.bashrc",
                line=line,
                present=True,
                backup=True
            )  # type: ignore

        # TODO: add check for python version already exists
        server.shell(
            name=f"Install python",
            commands=[f"/home/{userName}/.pyenv/bin/pyenv install {pythonVersion}"]
            )

        server.shell(
            name=f"Set global python version",
            commands=[f"/home/{userName}/.pyenv/bin/pyenv global {pythonVersion}"]
            )
    else:
        raise DeployError(
            (
                "pyenv already exists on this machine"
            ),
        )