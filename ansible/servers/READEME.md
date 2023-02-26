# Usage

## Installation

1) Ensure you have ansible installed

   `pip install ansible`

2) Install the required roles

   `ansible-galaxy install -r requirements_roles.yaml`

3) Install the required collections

   `ansible-galaxy collection install -r requirements_collections.yaml`

## Running the playbook

The server playbook should be run automatically with terraform. If you want to run it manually, you can do so with the following command:

`ansible-playbook -i inventory.ini [server or any /playbooks].yaml`

**Note:** The `inventory.ini` file is not checked into source control. You will need to create this file locally. The `inventory.ini.example` file can be used as a template. Be sure to remove the `.example` extension.

## Notes

- Any playbooks listed under the `/playbooks` directory can be run independently of the server playbook. This is useful for using ansible to perform one off tasks such as periodically updating apt packages.

- In order to use the version(s) of node listed in the playbook, you will need to run `nvm use [version]` the first time you access the server. Otherwise node will not be found.

## Useful commands

Run playbook with prompt for sudo password

`ansible-playbook -i inventory.ini roles/playbook.yml -K`

Ping all hosts

`ansible all -i inventory -m ping`

