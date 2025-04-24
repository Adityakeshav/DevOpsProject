# DevOps Project: Flask App Deployment on Azure

This project demonstrates how to deploy a **Flask app** to **Azure** using **Docker**, **Terraform**, and **GitHub Actions**. The app is containerized using Docker, and the infrastructure is provisioned using Terraform. The deployment process is automated using GitHub Actions.

---

## **Project Overview**

### **Components**
1. **Flask App**:
   - A simple Flask app (`app.py`) that serves a "Hello, World!" message.
   - Containerized using Docker.

2. **Infrastructure as Code (IaC)**:
   - Terraform is used to provision the following resources on Azure:
     - Resource Group
     - Azure Container Instance (ACI)

3. **CI/CD Pipeline**:
   - GitHub Actions automates the build and deployment process:
     - Builds the Docker image.
     - Pushes the Docker image to Docker Hub.
     - Deploys the app to Azure using Terraform.

---

## **Prerequisites**

Before running this project, ensure you have the following:

1. **Azure Account**:
   - An active Azure subscription.
   - Azure CLI installed and configured (`az login`).

2. **Docker Hub Account**:
   - A Docker Hub account to store the Docker image.

3. **GitHub Repository**:
   - A GitHub repository to host the project and run the CI/CD pipeline.

4. **Terraform**:
   - Terraform installed locally (optional, for testing).
  
### **Access the Deployed App**

IP Address: http://20.235.226.56:5000/

Custom Domain: http://devops.adityakeshav.tech
  
   ## **Setup Instructions**

### **1. Clone the Repository**
Clone this repository to your local machine:

```bash
git clone git@github.com:Adityakeshav/devOps.git
cd devOps
