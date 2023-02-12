from multiprocessing.managers import RemoteError
from pyinfra.operations import server, files
import os

ssh_user = os.environ['ssh_user']
ssh_remote_user = os.environ['ssh_remote_user']

# TODO: .bashrc is not being created automatically (added something quickly below)
for user in [ ssh_user, ssh_remote_user ]:

    server.group(
        name=f"Create {user} group",
        group=user,
        present=True,
        _sudo=True
    ) # type: ignore

    server.user(
        name=f"Ensure user {user} is created",
        user=user,
        shell="/bin/bash",
        group=user,
        groups=["sudo"],
        home=f"/home/{user}",
        public_keys=os.environ["ssh_public_key"],
        _sudo=True,
        present=True
    )  # type: ignore

    password = os.environ['ssh_password']
    server.shell(
        name=f"Add password to {user}",
        commands=[f"usermod --password $(openssl passwd -6 '{password}') {user}"],
        _sudo=True
    )

    if user == ssh_user:
        server.shell(
            name=f"Copy .bashrc to {user}",
            commands=[f"cp /home/ubuntu/.bashrc /home/ubuntu/.profile /home/ubuntu/.bash_logout /home/{user}/"],
            _sudo=True
        )

    if user == ssh_remote_user:
        files.file(
            name="Create sudoers file",
            path=f"/etc/sudoers.d/{user}",
            touch=True,
            _sudo=True
        )
        sudoer_line = f"{user} ALL=(ALL) NOPASSWD: ALL"
        files.line(
            name=f"Add {user} to the sudoers file",
            path=f"/etc/sudoers.d/{user}",
            line=sudoer_line,
            present=True,
            _sudo=True
        )  # type: ignore
