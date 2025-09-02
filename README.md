# 🚀 AWS Hands-on Project: Jenkins on EC2 with Private S3 Artifacts

## 📝 Overview
This project demonstrates how to deploy a Jenkins server on AWS EC2 with a private S3 bucket for storing build artifacts using Terraform.

---

## ✨ Features
- 💻 Deploys a Jenkins EC2 instance in your default VPC.
- ⚙️ Installs and starts Jenkins automatically using a bootstrap script.
- 🔒 Configures a Security Group to allow SSH (22) from your IP and Jenkins UI (8080) from anywhere.
- 🗄️ Creates a private S3 bucket to store Jenkins build artifacts with a predefined folder structure.
- 📤 Outputs the Jenkins EC2 Public IP and S3 bucket name after deployment.

---

## 🛠️ Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI configured with proper credentials:  
  ```bash
  aws configure
  ```
- IAM permissions to manage EC2, S3, and Security Groups.

---

## 📂 Project Structure
```
jenkins-project/
├── main.tf
├── providers.tf
├── variables.tf
└── outputs.tf
```

---

## 🚀 Deployment Steps
1. **Clone this repository:**
   ```bash
   git clone <your-repo-url>
   cd jenkins-project
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Apply the Terraform configuration:**
   ```bash
   terraform apply -auto-approve
   ```

4. **Get the Jenkins public IP:**
   ```bash
   terraform output jenkins_instance_public_ip
   ```

5. **Access Jenkins at:** `http://<PUBLIC_IP>:8080`

6. **Retrieve the initial admin password:**
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

---

## 📊 Outputs
After successful deployment, Terraform will display the following outputs:

Jenkins EC2 Public IP – 🌐 The public IP address of your Jenkins server.

Jenkins Website URL – 🔗 The full URL to access Jenkins (e.g., http://<PUBLIC_IP>:8080).

S3 Bucket Name – 📦 The private bucket where Jenkins stores build artifacts.

Security Group ID – 🛡️ The ID of the security group applied to the Jenkins EC2 instance.

---

## 🧹 Destroy the Infrastructure
To remove all resources (including emptying the S3 bucket automatically):
```bash
terraform destroy -auto-approve
```

---

## ✅ Verification
- Ensure Jenkins is reachable at port **8080**.
- Check S3 bucket contents:
  ```bash
  aws s3 ls s3://$(terraform output -raw jenkins_s3_bucket_name)
  ```

---

## 🖼️ Screenshot (Example)
Insert a screenshot of the Jenkins login screen after setup.

---

## 📜 License
This project is open-source and free to use for educational purposes.

