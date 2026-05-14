terraform {
  backend "s3" {
    bucket                      = "mycompany-tfstate"
    key                         = "staging/terraform.tfstate"
    region                      = "eu-central-1"
    endpoint                    = "https://s3.eu-central-1.amazonaws.com"
    skip_credentials_validation = false
    skip_metadata_api_check     = false
  }
}
