#!/bin/bash
set -e

# Update system packages
sudo yum update -y

# Install Java (required for Jenkins)
sudo amazon-linux-extras enable java-openjdk11
sudo yum install -y java-11-openjdk

# Add the Jenkins repository and key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
sudo yum install -y jenkins

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Allow Jenkins port in firewall (if applicable)
if systemctl is-active firewalld >/dev/null 2>&1; then
  sudo firewall-cmd --permanent --add-port=8080/tcp
  sudo firewall-cmd --reload
fi

# Print Jenkins status
sudo systemctl status jenkins
