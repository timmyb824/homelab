# Summary

*Note: This folder is an exact copy of my repo: https://github.com/timmyb824/terraform-newrelic-alerting-modules. I include it here for convenience.*

Provision New Relic alerting using Terraform. We should strive to create all New Relic alerts using Terraform otherwise manually created alerts will need to be imported so Terraform can manage them.

manually created alerts with needed to imported into Terrafrom so it is aware of the current state and can manage the resources.

## Installation

Install terraform:

- https://learn.hashicorp.com/tutorials/terraform/install-cli
- https://www.terraform.io/downloads.html

### Terraform Requirement

| Name      | Version |
| --------- | ------- |
| terraform | = 1.0.2 |

### Provider Requirement

| Name     | Version  |
| -------- | -------- |
| newrelic | = 2.23.0 |

### Provider Variables

These must be set as environment variables

| Variable      | Description                                           |
| ------------- | ----------------------------------------------------- |
| nr_api_key    | The New Relic API key                                 |
| nr_account_id | Your New Relic Account Id                             |
| nr_region     | Your New Relic Accounts data center region. US or EU. |

## Folder Structure

Below is a visual representation of the Terraform folder structure:

```bash
├── 001-alerts
│   ├── main.tf
│   ├── modules
│   │   └── alerts
│   │       ├── main.tf
│   │       ├── provider.tf
│   │       └── variables.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variables.tf
```

### Modules

The folder structure currently consists of Modules which are the main way to package and reuse resource configurations with Terraform. The Modules are as follows:

| Module Name | Description                                                                                                 |
| ----------- | ----------------------------------------------------------------------------------------------------------- |
| alerts      | Module to create an alert policy, alert conditions, and subscribe notification channels to the alert policy |

## State

The state file used by Terrform to manage resources and configurations is hosted using an S3 backend with dynamodb as the locking mechanism. This ensures consitency and prevents conflicts when there are multiple collaborators.

## Inputs

The following is a list of required and recommended TFVARS input values. This is not an all inclusive list of values. For a list of all possible resource inputs refer to the [New Relic Provider documentation](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs).

### [NRQL conditions](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition)

| Field                        | Description                                                                                                         | Default          | Required         |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------- | ---------------- |
| policy_id                    | The ID of the policy where this condition should be used                                                            |                  | yes              |
| name                         | The title of the condition                                                                                          |                  | yes              |
| enabled                      | Whether the condition is turned on or off                                                                           | true             | no               |
| type                         | The type of condition (static, baseline, or outlier)                                                                | static           | yes              |
| value_function               | Open violation when the "query returns a value" or "sum of query results is". Valid values are single_value or sum. |                  | if type = static |
| violation_time_limit_seconds | Sets a time limit, in seconds, that will automatically force-close a long-lasting violation                         | 2592000 (30days) | yes              |
| nrql                         | A NRQL query block (See NRQL below for details)                                                                     |                  | yes              |
| critical                     | A list containing the critical threshold values (See Critical below for details)                                    |                  | yes              |

#### NRQL

| Field             | Description                                                                                                                             | Default | Required |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------- | -------- |
| query             | The NRQL query to execute for the condition                                                                                             |         | yes      |
| evaluation_offset | NRQL queries are evaluated in one-minute time windows. The start time depends on this value. It's recommended to set this to 3 minutes. | 3       | yes      |

#### Critical

| Field              | Description                                                                              | Default | Required |
| ------------------ | ---------------------------------------------------------------------------------------- | ------- | -------- |
| operator           | Valid values are above, below, or equals                                                 | above   | yes      |
| threshold          | The value which will trigger a violation                                                 | 90      | yes      |
| threshold_duration | The duration, in seconds, that the threshold must violate in order to create a violation | 300     | yes      |

### [Infra conditions](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/infra_alert_condition)

| Field                | Description                                                                                                 | Default | Required                                        |
| -------------------- | ----------------------------------------------------------------------------------------------------------- | ------- | ----------------------------------------------- |
| policy_id            | The ID of the alert policy where this condition should be used                                              |         | yes                                             |
| name                 | The Infrastructure alert condition's name                                                                   |         | yes                                             |
| enabled              | Whether the condition is turned on or off                                                                   | true    | no                                              |
| type                 | Type of alert condition. Valid values are infra_process_running, infra_metric, and infra_host_not_reporting |         | yes                                             |
| event                | The metric event e.g. SystemSample                                                                          |         | if type = infra_metric                          |
| select               | The attribute name to identify the metric being targeted e.g. cpuPercent                                    |         | if type = infra_metric                          |
| comparison           | The operator used to evaluate the threshold value. Valid values are above, below, equal                     |         | if type = infra_metric or infra_process_running |
| where                | This identifies any Infrastructure host filters used e.g. hostname LIKE '%cassandra%'                       |         | no                                              |
| process_where        | Any filters applied to processes e.g. processDisplayName = 'splunkd'                                        |         | if type = infra_process_running                 |
| integration_provider | For alerts on integrations, use this instead of event. Supported by type = infra_metric                     |         | no                                              |
| critical             | A list containing the critical threshold values (See Critical below for details)                            |         |                                                 |

#### Critical

| Field         | Description                                                                                                                  | Default | Required                                        |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------- | ------- | ----------------------------------------------- |
| duration      | Identifies the number of minutes the threshold must be passed or met for the alert to trigger. Must be between 1-60 minutes. | 5       | yes                                             |
| value         | Threshold value, computed against the comparison operator                                                                    |         | if type = infra_metric or infra_process_running |
| time_function | Indicates if the condition needs to be sustained or to just break the threshold once; all or any                             |         | if type = infra_metric                          |
