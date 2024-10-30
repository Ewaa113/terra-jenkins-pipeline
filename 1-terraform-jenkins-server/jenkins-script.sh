#!/bin/bash

# Update packages and install common tools
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "amzn" ]]; then
        # Commands for Amazon Linux
        sudo yum update -y
        sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
        sudo yum upgrade -y
        sudo amazon-linux-extras install java-openjdk11 -y
        sudo yum install jenkins -y
        sudo systemctl enable jenkins
        sudo systemctl start jenkins

        # Install git, terraform, kubectl for Amazon Linux
        sudo yum install git -y
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
        sudo yum -y install terraform
        sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl"
        sudo chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl

    elif [[ "$ID" == "ubuntu" ]]; then
        # Commands for Ubuntu
        sudo apt update -y
        sudo apt install openjdk-11-jdk -y
        curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
            /usr/share/keyrings/jenkins-keyring.asc > /dev/null
        echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
            https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
            /etc/apt/sources.list.d/jenkins.list > /dev/null
        sudo apt update -y
        sudo apt install jenkins -y
        sudo systemctl enable jenkins
        sudo systemctl start jenkins

        # Install git, terraform, kubectl for Ubuntu
        sudo apt install git -y
        sudo apt install -y software-properties-common
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update -y && sudo apt install terraform -y
        curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl"
        sudo chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl
    fi
fi