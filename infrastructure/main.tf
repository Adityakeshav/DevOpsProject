name: DevOps CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build-and-push-docker:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Log in to Docker Hub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v2
        with:
          context: ./app
          push: true
          tags: ${{ secrets.DOCKER_HUB_USERNAME }}/devops-flask-app:latest

  deploy-infrastructure:
    runs-on: ubuntu-latest
    needs: build-and-push-docker
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        working-directory: ./infrastructure
        run: terraform init

      - name: Check if Resource Group Exists and Import
        working-directory: ./infrastructure
        env:
          ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
          ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
          ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}
        run: |
          # Check if the resource group exists
          if az group show --name devops-project-rg --subscription $ARM_SUBSCRIPTION_ID > /dev/null 2>&1; then
            echo "Resource group 'devops-project-rg' exists. Importing into Terraform state..."
            terraform import azurerm_resource_group.devops_rg /subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/devops-project-rg
          else
            echo "Resource group 'devops-project-rg' does not exist. It will be created by Terraform."
          fi

      - name: Terraform Apply
        working-directory: ./infrastructure
        run: terraform apply -auto-approve
        env:
          TF_VAR_subscription_id: ${{ secrets.ARM_SUBSCRIPTION_ID }}
          TF_VAR_client_id: ${{ secrets.ARM_CLIENT_ID }}
          TF_VAR_client_secret: ${{ secrets.ARM_CLIENT_SECRET }}
          TF_VAR_tenant_id: ${{ secrets.ARM_TENANT_ID }}
          TF_VAR_docker_image: ${{ secrets.DOCKER_HUB_USERNAME }}/devops-flask-app:latest