terraform {
  required_version = "= 1.0.4"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "= 2.38.0"
    }
  }

# Required values are passed as command line arguments
   backend "s3" {
   }
}

# Required values configured as environment variables
provider "newrelic" {
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}