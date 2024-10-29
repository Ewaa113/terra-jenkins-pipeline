terraform {
  backend "s3" {
    bucket = "terra-jenkins-k8s"
    region = "eu-west-3"
    key = "eks/terraform.tfstate"
  }
}