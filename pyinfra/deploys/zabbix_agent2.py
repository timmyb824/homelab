from pyinfra.operations import server, files, apt
from pyinfra import host
from pyinfra.facts.files import Directory
from pyinfra.api.exceptions import DeployError
from pyinfra.api.deploy import deploy

agentVersion = "6.2"

@deploy("Deploy zabbix agent")
def deploy_zabbix():
    if host.get_fact(Directory, path=f"/etc/zabbix") is None:

        server.shell(
            name=f"Download Zabbix release file",
            commands=[f"wget https://repo.zabbix.com/zabbix/{agentVersion}/ubuntu/pool/main/z/zabbix-release/zabbix-release_{agentVersion}-4%2Bubuntu20.04_all.deb"]
            )

        server.shell(
            name=f"Install from package",
            commands=[f"dpkg -i zabbix-release_{agentVersion}-4+ubuntu20.04_all.deb"],
            _sudo=True
            )

        # apt.update(
        #     name="Update apt repositories",
        #     _sudo=True
        # )

        apt.packages(
                name="Install zabbix packages",
                packages=[
                    "zabbix-agent2",
                    "zabbix-agent2-plugin-*"
                ],
                _sudo=True,
                present=True,
                update=True
            )

        server.service(
            name="Restart agent service",
            service="zabbix-agent2",
            enabled=True,
            running=True,
            _sudo=True,
            _use_sudo_password=True
        )

        files.file(
            name="Remove current config file",
            path="/etc/zabbix/zabbix_agent2.conf",
            present=False,
            _sudo=True
        )

        files.template(
            name="Create new config file",
            src="../templates/zabbix_agent2.conf.j2",
            dest="/etc/zabbix/zabbix_agent2.conf",
            hostName="vm300",
            zabbixServer="192.168.86.203", #192.168.86.202 for proxy
            statusPort="9999",
            _sudo=True
        )

        server.shell(
            name=f"Add zabbix user to docker group",
            commands=[f"sudo usermod -aG docker zabbix"]
            )

        server.service(
            name="Restart agent service",
            service="zabbix-agent2",
            restarted=True,
            _sudo=True,
            _use_sudo_password=True
        )

    else:
        raise DeployError(
            (
                "Agent already exists on this machine"
            ),
        )
