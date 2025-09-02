#!/bin/bash
set -e

# Update system packages
sudo yum update -y

# Install Java 17 (Amazon Linux 2023 default supports java-17)
sudo dnf install -y java-17-amazon-corretto

# Add Jenkins repo and key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
sudo dnf install -y jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

