# Lineten SRE Demo Project

This project demonstrates containerizing a sample application and deploying it to **Google Cloud Run** using **Terraform** and **Google Artifact Registry**.

---

## 🚀 Project Overview

**Workflow Summary:**

1. **Containerize** the application using Docker.
2. **Push** the image to Google Artifact Registry.
3. **Deploy** the containerized app to Cloud Run via Terraform IaC.

---

## 🧱 Prerequisites

Before starting, ensure you have the following installed locally:

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- A **GCP Project** with Artifact Registry and Cloud Run enabled

---

## ⚙️ Step 1: Build Docker Image

From the project root folder:

```bash
docker build -t lineten-sre-demo:latest .

docker images


#Authenticate Docker with GCP
 gcloud auth configure-docker us-central1-docker.pkg.dev

#Tag your image:
docker tag lineten-sre-demo:latest 

#Push to Artifact Registry:
 docker push us-central1-docker.pkg.dev/sre-assesment-demo/sre-demo-repo/lineten-sre-demo:latest

#Deploy to Cloud Run via Terraform

#Navigate to your Terraform folder:

cd infra


#Initialize Terraform:

terraform init


#Preview the plan:

terraform plan


#Apply the infrastructure changes:

terraform apply -auto-approve


#Terraform will:

#Create an Artifact Registry repository (if not already created)

#Deploy a Cloud Run service

#Use the pushed Docker image as the container source


#✅ Verification

#To verify deployment:

gcloud run services list --project sre-assesment-demo


#Then open the Service URL in your browser —

https://sre-demo-service-yoe3pbqlaq-uc.a.run.app/

#You should see your application running on Cloud Run 🎉
