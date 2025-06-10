terraform {
  backend "s3" {
    bucket = "terra-jenkins-k8s"
    region = "eu-west-3"
    key    = "jenkins-server/terraform.tfstate"
  }
}