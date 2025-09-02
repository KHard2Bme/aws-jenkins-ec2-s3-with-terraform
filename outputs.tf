output "jenkins_ip_address" {
  value        = aws_instance.jenkins.public_ip
  description  = "The public IP address of the EC2 Server"
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins.public_ip}:8080"
  description =  "The Jenkins server website"
}

output "jenkins_security_group_id" {
  value = aws_security_group.jenkins_sg.id
  description =  "The Jenkins security group id"
}

output "artifacts_bucket_name" {
 value        = aws_s3_bucket.jenkins_artifacts.id
 description  = "The name of the private S3 bucket for artifacts"
}