# Usage

## Installation

1) Ensure you have terraform installed

   `brew install terraform` or

   If you prefer to use a version manager

    ```bash
    brew install tfenv

    tfenv install latest

    tfenv use latest
    ```

2) Install the required providers

    `terraform init`

3) Install the required modules (none as of now)

    `terraform get`

## Running the terraform

1) Double check the `terraform.tfvars` file to ensure the correct values are set

2) Double check the `ansible/server.yaml` file to ensure the correct values are set

3) Run the following commands to create the resource

`terraform plan` to see what will be created

`terraform apply` to create the resource

## Destroying the resources

`terraform destroy` to destroy the resource

## Notes

- The `terraform.tfvars` file is not checked into source control. You will need to create this file locally. The `terraform.tfvars.example` file can be used as a template. Be sure to remove the `.example` extension.

- The `terraform.tfstate` file is not checked into source control. This file is used by terraform to keep track of the state of the resources. This file should be kept locally. If we ever need to share state, then we can use a remote backend like S3 and DynamoDB.

- In order to use the version(s) of node listed in the playbook, you will need to run `nvm use [version]` the first time you access the server. Otherwise node will not be found.
-