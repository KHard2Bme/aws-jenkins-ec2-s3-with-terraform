resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-sg"
  description = "Allow SSH and Jenkins UI"


  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
 }


  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}


resource "aws_s3_bucket" "jenkins_artifacts" {
  bucket = "jenkins-artifacts-${random_string.bucket_suffix.result}"
  force_destroy = true


  tags = {
    Name = "JenkinsArtifacts"
  }
}


resource "aws_s3_object" "artifacts_folder" {
  bucket = aws_s3_bucket.jenkins_artifacts.id
  key    = "artifacts/"
}


resource "aws_s3_object" "builds_subfolder" {
  bucket = aws_s3_bucket.jenkins_artifacts.id
  key = "artifacts/builds/"
}


resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]


  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable java-openjdk11
              sudo yum install -y java-11-openjdk
              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              sudo yum install -y jenkins git aws-cli
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              EOF


  tags = {
    Name = "Jenkins-Server"
  }
}