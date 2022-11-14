terraform {
  backend "s3" {
    bucket = "aspire-hyd-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
    profile = "terraform-user"
  }
}