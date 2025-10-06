
# 🧠 Banking Microservices Platform – Detailed Execution Guide

This guide provides a **step-by-step command reference** to build, deploy, monitor, and log the Banking Microservices platform.

---

## ⚙️ Prerequisites
- Docker & Docker Compose installed
- AWS CLI & Terraform configured
- kubectl configured for EKS
- Basic understanding of Kubernetes objects

---

## 1️⃣ Build & Push Docker Images

### Build all services
```bash
docker compose build

Run locally (optional test)

docker compose up -d handler processor

Push images to AWS ECR

aws ecr get-login-password --region eu-central-1 | \
  docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.eu-central-1.amazonaws.com

docker tag handler-service:latest <AWS_ACCOUNT_ID>.dkr.ecr.eu-central-1.amazonaws.com/handler-service:latest
docker tag processor-service:latest <AWS_ACCOUNT_ID>.dkr.ecr.eu-central-1.amazonaws.com/processor-service:latest

docker push <AWS_ACCOUNT_ID>.dkr.ecr.eu-central-1.amazonaws.com/handler-service:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.eu-central-1.amazonaws.com/processor-service:latest


⸻

2️⃣ Provision AWS Infrastructure (Terraform)

cd infra
terraform init
terraform plan
terraform apply

Expected resources:
	•	VPC with public/private subnets
	•	EKS cluster (Fargate)
	•	IAM roles and ECR repositories

Once completed:

terraform output


⸻

3️⃣ Connect & Deploy to EKS

Update kubeconfig

aws eks update-kubeconfig --region eu-central-1 --name banking-app-cluster
kubectl get nodes

Create namespace & deploy workloads

kubectl create namespace banking
kubectl apply -f K8s/

Verify deployments and services

kubectl get pods -n banking
kubectl get svc -n banking
kubectl logs -f -n banking -l app=traffic-generator


⸻

4️⃣ Monitoring Setup (Prometheus + Grafana)

Start Prometheus & Grafana locally

docker compose up -d prometheus grafana

Access UI
	•	Prometheus → http://localhost:9095
	•	Grafana → http://localhost:3000 (admin / admin)

Import dashboards
	1.	In Grafana → Dashboards → Import
	2.	Use Dashboard IDs:
	•	4701 – Spring Boot (Handler)
	•	893 – Go App (Processor)

⸻

5️⃣ Logging Stack (Fluent Bit + Elasticsearch + Kibana)

Start ELK + Fluent Bit

docker compose up -d elasticsearch kibana fluentbit

Verify connectivity

curl -X GET "http://localhost:9200/_cat/indices?v"

Configure Kibana
	•	Go to Stack Management → Index Patterns
	•	Add index pattern: logstash-*
	•	Navigate to Discover → see live handler & processor logs

⸻

🧠 Useful kubectl Commands

Task	Command
List all namespaces	kubectl get ns
Check events	kubectl get events -n banking
Describe pod	kubectl describe pod <pod-name> -n banking
Delete a single pod	kubectl delete pod <pod-name> -n banking
Port forward	kubectl port-forward svc/<service-name> <local-port>:<target-port> -n banking


⸻

🧹 Cleanup

Delete EKS cluster and resources

cd infra
terraform destroy

Remove local containers

docker compose down -v


⸻

🧩 Next Enhancements
	•	CI/CD pipeline with GitHub Actions or Jenkins
	•	Add Dapr sidecars for interservice telemetry
	•	Introduce OpenTelemetry + Jaeger tracing

⸻

👩‍💻 Author

Sindhu Telikapalli
DevOps · Cloud Engineer · SRE
