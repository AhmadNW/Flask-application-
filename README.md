# DevOps End-to-End Project – AWS EKS Deployment

This repository contains a complete DevOps implementation that demonstrates how to provision cloud infrastructure, containerize an application, deploy it to Kubernetes, and automate everything using CI/CD pipelines.

The project is designed with **best practices** in mind, focusing on **security, performance, cost awareness, and automation**.

---

## 📌 Project Overview

This project includes:

- Infrastructure provisioning on AWS using **Terraform**
- Containerization of a **Flask** application using **Docker**
- Deployment to **AWS EKS** using **Helm**
- CI/CD automation using **GitHub Actions**
- (Bonus) Infrastructure deployment using GitHub Actions
- (Bonus) Application monitoring stack

---

## 🧱 Architecture

GitHub Repository
└── GitHub Actions (CI/CD)
├── Build Docker Image
├── Push Image to AWS ECR
├── Deploy to EKS using Helm
└── (Bonus) Provision Infrastructure with Terraform

AWS
├── S3 (Terraform Remote State)
├── VPC
│ ├── Public Subnet
│ └── Private Subnet
├── EKS Cluster
│ ├── Node Group (Public)
│ └── Node Group (Private)
├── ECR (Docker Image Registry)
└── IAM (Least Privilege Roles)

yaml
Copy code

---

## 📂 Repository Structure

.
├── terraform/ # Terraform infrastructure code
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── backend.tf
│ └── README.md
│
├── app/ # Flask application
│ ├── app.py
│ └── requirements.txt
│
├── docker/
│ └── Dockerfile
│
├── helm/
│ └── flask-app/
│ ├── Chart.yaml
│ ├── values.yaml
│ └── templates/
│
├── .github/
│ └── workflows/
│ ├── ci-cd.yaml
│ └── terraform-deploy.yaml # Bonus
│
└── README.md

markdown
Copy code

---

## 1️⃣ Infrastructure Provisioning with Terraform

### AWS Resources Created

- S3 bucket for Terraform remote state
- VPC with:
  - Public subnet
  - Private subnet
- AWS EKS cluster
- Two EKS node groups (one per subnet)
- AWS ECR repository
- IAM roles and policies (least privilege)

### Terraform Outputs

- EKS cluster name
- EKS cluster endpoint
- ECR repository URL
- IAM role ARN
- VPC ID
- Subnet IDs

### Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
📖 More details can be found in terraform/README.md.

2️⃣ Dockerizing the Flask Application
Build the Docker Image
bash
Copy code
docker build -t flask-app .
Authenticate to AWS ECR
bash
Copy code
aws ecr get-login-password --region <aws-region> \
| docker login --username AWS --password-stdin <account-id>.dkr.ecr.<aws-region>.amazonaws.com
Tag and Push the Image
bash
Copy code
docker tag flask-app:latest <ecr-repository-url>:latest
docker push <ecr-repository-url>:latest
3️⃣ Deploying the Application with Helm
Deploy to EKS
bash
Copy code
helm upgrade --install flask-app ./helm/flask-app \
  --set image.repository=<ecr-repository-url> \
  --set image.tag=latest
Access the Application
The application is exposed using a Kubernetes LoadBalancer service.

Retrieve the public endpoint:

bash
Copy code
kubectl get svc
4️⃣ CI/CD with GitHub Actions
CI/CD Pipeline Features
Triggered on every push to the main branch:

Build Docker image

Push image to AWS ECR

Deploy or update the application in EKS using Helm

Required GitHub Secrets
nginx
Copy code
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
EKS_CLUSTER_NAME
ECR_REPOSITORY
🎯 Bonus 1 – Terraform Deployment via GitHub Actions
A dedicated GitHub Actions workflow is included to:

Initialize Terraform

Run terraform plan

Apply infrastructure changes automatically

Remote state is managed using S3 (and optional DynamoDB locking).

🎯 Bonus 2 – Monitoring
Monitoring stack using Helm:

Prometheus

Grafana

Kubernetes metrics-server

Install monitoring:

bash
Copy code
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install monitoring prometheus-community/kube-prometheus-stack
🔐 Best Practices Implemented
Remote Terraform state

Least-privilege IAM roles

Private subnets for worker nodes

Helm-based Kubernetes deployments

Immutable Docker images

CI/CD automation

Cost-efficient AWS architecture

Security-aware configuration

🧪 Tested With
AWS

Terraform >= 1.5

Docker

Kubernetes (EKS)

Helm 3

GitHub Actions

👤 Author
Ahmad Wattad
DevOps Engineer
