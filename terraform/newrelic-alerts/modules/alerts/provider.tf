terraform {
  required_version = "= 1.0.4"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "= 2.38.0"
    }
  }
}

