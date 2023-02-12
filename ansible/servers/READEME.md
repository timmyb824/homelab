# Commands reference (under construction..)

Run playbook with prompt for sudo password

`ansible-playbook -i inventory.ini roles/playbook.yml -K`

Ping all hosts

`ansible all -i inventory -m ping`

Install ansible collections

`ansible-galaxy install -r requirements.yaml`
