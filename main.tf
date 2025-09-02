resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and Jenkins UI"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}


resource "aws_s3_bucket" "jenkins_artifacts" {
  bucket        = "jenkins-artifacts-${random_string.bucket_suffix.result}"
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
  key    = "artifacts/builds/"
}


resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data              = file("jenkins_bootstrap.sh")

  
  tags = {
    Name = "Jenkins-Server-ec2"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }
}