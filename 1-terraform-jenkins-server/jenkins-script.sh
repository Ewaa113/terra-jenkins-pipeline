#!/bin/bash

# install jenkins

sudo apt update  
sudo apt install -y wget
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt-get install openjdk-21-jdk 
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# install git

sudo apt install -y git

# install terraform

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install -y terraform

# install kubectl

curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl  
