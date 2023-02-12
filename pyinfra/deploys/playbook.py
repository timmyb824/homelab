from pyenv import deploy_python
from nvm import deploy_node
from zabbix_agent2 import deploy_zabbix
# from pyinfra import config

# config.SUDO = True

# TODO: need to create deploys for new user, docker, rsyslog
# deploy_python()
# deploy_node()
deploy_zabbix()
