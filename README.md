
***

# **CI/CD Pipeline to Deploy Node.js App on AWS ECS Fargate Using GitHub Actions**

## ** Overview**

This project demonstrates a complete **CI/CD pipeline** where a Node.js application is automatically deployed to **AWS ECS Fargate** using **GitHub Actions**.

Whenever code is pushed to the `main` branch, the pipeline:

1.  Builds a Docker image
2.  Pushes it to **Amazon ECR**
3.  Creates/updates the **ECS Task Definition**
4.  Deploys the container on **ECS Fargate**
5.  Exposes it publicly using a public IP

This setup follows a production‑like workflow and is fully automated.

***

## ** Architecture Flow**

    GitHub → GitHub Actions → Docker Build → Amazon ECR 
           → ECS Task Definition → ECS Fargate → Public IP → Browser

***

## ** Project Structure**

    ├── app.js
    ├── package.json
    ├── Dockerfile
    └── .github
        └── workflows
            └── deploy.yml

***

## ** Technologies Used**

*   **Node.js + Express**
*   **Docker**
*   **AWS ECR**
*   **AWS ECS Fargate**
*   **GitHub Actions**
*   **CloudWatch Logs**

***

## ** Application Details**

The application is a simple Express server with two endpoints:

*   `/` → returns a success message
*   `/health` → used by ECS for health checks
*   Runs on port **3000**

The container listens on:

    0.0.0.0:3000

***

## ** Dockerfile Summary**

*   Base Image: `node:20-alpine`
*   Installs dependencies
*   Installs `curl` (for health checks)
*   Exposes port **3000**
*   Starts the app using `node app.js`

***

## ** AWS Resources Created**

### **1. Amazon ECR Repository**

Stores Docker images.

Example:

    poc24-node-app

### **2. ECS Cluster**

    poc24-cluster

### **3. ECS Service + Task Definition**

*   Launch type: **Fargate**
*   CPU/MEM: Configurable
*   Assigns **Public IP**
*   Security group allows:

<!---->

    Port 3000 → 0.0.0.0/0

### **4. IAM Roles**

*   Task Execution Role
*   Task Role

These allow ECS to pull images from ECR and send logs to CloudWatch.

***

## ** GitHub Secrets Required**

Store these under **Repository → Settings → Secrets → Actions**:

| Secret Name              | Description                |
| ------------------------ | -------------------------- |
| `AWS_ACCESS_KEY_ID`      | IAM user key               |
| `AWS_SECRET_ACCESS_KEY`  | IAM user secret            |
| `AWS_REGION`             | Example: `ap-south-1`      |
| `ECS_CLUSTER`            | Cluster name               |
| `ECS_SERVICE`            | Service name               |
| `ECR_REPOSITORY`         | ECR repo name              |
| `ECS_TASK_EXEC_ROLE_ARN` | Task execution role        |
| `ECS_TASK_ROLE_ARN`      | Task role                  |
| `ECS_SUBNET_IDS`         | Comma‑separated subnet IDs |
| `ECS_SECURITY_GROUP_IDS` | Security group IDs         |

***

## ** GitHub Actions Workflow Summary**

### The pipeline performs:

1.  **Checkout Repository**
2.  **Configure AWS Credentials**
3.  **Login to ECR**
4.  **Build and Tag Docker Image**
5.  **Push Image to Amazon ECR**
6.  **Register New Task Definition**
7.  **Deploy Updated Task on ECS Fargate**

Trigger:

    on:
      push:
        branches: [ "main" ]
      workflow_dispatch:

***

## ** Accessing the Application**

After deployment:

1.  Go to **ECS → Cluster → Service → Tasks**
2.  Open the running task
3.  Copy the **Public IPv4 Address**

Open in browser:

    http://<Public-IP>:3000

You should see:

    App deployed successfully on ECS Fargate!

***

## ** Summary**

This POC demonstrates:

*   Containerizing an application
*   Using GitHub Actions for CI/CD
*   Storing images in ECR
*   Deploying to ECS Fargate automatically
*   Running a production‑like pipeline

This workflow is clean, simple, and fully automated.

***


