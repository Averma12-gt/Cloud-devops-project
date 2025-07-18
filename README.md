# 🌩️ Akash's Cloud DevOps Project 🚀

This project demonstrates end-to-end deployment of a Flask web application on **AWS ECS Fargate** using:

- **Docker**
- **Amazon ECR**
- **ECS Fargate + ALB**
- **Terraform (IaC)**
- **AWS CodePipeline + CodeBuild** for CI/CD

---

## 📸 Live Demo

📸 Live Demo
🔗 Live URL is based on the Public IP assigned to ECS Task

To access the deployed application:

Go to the AWS Console → ECS → select your Cluster.
Choose the Service (akash-service).
Click on the running Task.
Under the Network section, copy the Public IP assigned to the task’s ENI.

Open your browser and visit:
http://<Public-IP>:80
Example: http://13.233.178.166 (Note: This IP changes if the task stops or restarts)

---

## 📦 Tech Stack

| Tool            | Purpose                                      |
|-----------------|----------------------------------------------|
| **Flask**       | Python web framework for the demo app        |
| **Docker**      | Containerizes the application                |
| **Amazon ECR**  | Docker image storage                         |
| **ECS Fargate** | Serverless container hosting                 |
| **ALB**         | Public access to the container               |
| **CodePipeline**| Automates build and deployment               |
| **Terraform**   | Infrastructure as Code                       |
| **GitHub**      | Source code and CI/CD trigger                |

---

### 📁 Project Structure

```text
cloud-devops-project/
├── app/                            # Flask app source code and Dockerfile
│   ├── app.py                      # Main Flask application
│   ├── requirements.txt            # Python dependencies
│   ├── Dockerfile                  # Dockerfile for containerizing the app
│   └── build.sh                    # Shell script to build Docker image locally
│
├── terraform/                      # Infrastructure as Code (Terraform)
│   ├── main.tf                     # Terraform backend & provider configuration
│   ├── ecr.tf                      # AWS ECR resource definitions
│   ├── ecs.tf                      # AWS ECS task and service definitions
│   └── variables.tf                # Input variables for Terraform
│
├── buildspec.yml                   # AWS CodeBuild build specification
├── task-def.json                   # ECS Task Definition JSON
└── README.md                       # Project documentation

```


## ⚙️ How It Works

1. **Flask app** is containerized using a `Dockerfile`.
2. **Docker image** is pushed to **ECR**.
3. **Terraform** provisions:
   - VPC, Subnets
   - ECS Cluster
   - Fargate Task + Service
   - ALB and Security Groups
4. **CodePipeline**:
   - Triggers on GitHub push
   - Builds Docker image using **CodeBuild**
   - Pushes to ECR
   - Triggers ECS deployment with updated image
5. App becomes accessible via **ALB Public IP**

---

## 🚀 How to Deploy

```text
### 1. Clone & Configure
git clone https://github.com/Averma12-gt/Cloud-devops-project.git
cd Cloud-devops-project/terraform

2. Terraform Setup

terraform init
terraform apply

3. Setup CodePipeline (One-time)
Make sure your GitHub repo is connected to CodePipeline
Add buildspec.yml in the root
Ensure task-def.json is kept updated if image tag changes

```
🐳 Docker Commands (Local Testing)
```
docker build -t akash-cloud-app .
docker run -p 5000:5000 akash-cloud-app

```
🧠 Lessons Learned
```
Importance of using correct platform linux/amd64 for ECS
Using SHA256 vs tag (latest) in ECS
Troubleshooting ECS logs and container pull errors
Git LFS vs .gitignore for large file handling
```

🏁 Future Improvements
```
Add domain name + SSL using Route53 + ACM
CI/CD with GitHub Actions (alternate option)
Monitoring with CloudWatch & container insights
```

