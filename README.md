# Docker via Terraform on GCP

### Prerequisites

Install Terraform and Git.

## Getting Started

1. Create Google Cloud Platform account
2. Take note of your generated project name and ID (or [create your own project name](https://console.cloud.google.com/cloud-resource-manager?_ga=2.152268665.-1101307456.1571267735))
3. [Create a service account](https://cloud.google.com/video-intelligence/docs/common/auth#creating_a_service_account_in_the) and download your subsequent JSON key

## Installation

1. Clone Repo and run terraform init
   ```
   git clone https://github.com/amitoo7/docker-gce-terraform.git
   cd ./docker-gce-terraform
   terraform init
   ```
2. Copy downloaded json credential file to this project location and rename it to hauntapp.json
3. Modify gcp_project value in vars.tf to match the your project ID in google cloud
4. Execute Terraform plan and apply
   ```
   terraform plan
   terraform apply -auto-approve
   ```
5. Log into GCP console and confirm your docker container(s) is running
   ```
   sudo docker container ls #on google cloud vm instance
   ```
6. Point your domain to Public IP of the server created and you can access api-gateway service over https


I included my email and domain for traefik let's encrypt please change it in docker-compose-build.tpl which becomes docker-compose.yml on the host.
