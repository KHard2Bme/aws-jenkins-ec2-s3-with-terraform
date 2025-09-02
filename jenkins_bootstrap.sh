#!/bin/bash

# Update all system packages to the latest version
sudo yum update -y

# Add Jenkins repository file 
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import the Jenkins repository key 
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade all packages again
sudo yum update -y

# Install Java 17 (Amazon Linux 2023 default supports java-17)
sudo dnf install java-17-amazon-corretto -y

# Install Jenkins
sudo yum install jenkins -y

# Enable and start Jenkins on system boot
sudo systemctl enable jenkins
sudo systemctl start jenkins

