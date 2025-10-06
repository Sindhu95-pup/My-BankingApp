# 💳 Banking Microservices Platform using AWS EKS and DevOps Tools

![Architecture](./Architecture.png)

## 📘 Overview
A **cloud-native microservices banking platform** demonstrating end-to-end DevOps practices — containerization, orchestration, observability, and IaC on AWS.

**Author:** Sindhu Telikapalli  
**Role:** DevOps / Cloud Engineer / SRE  
**Tech Stack:** Docker · Kubernetes (EKS) · Terraform · Prometheus · Grafana · Fluent Bit · ELK

---

## 🚀 Architecture Summary
- **Handler Service** – Accepts and routes transaction requests.  
- **Processor Service** – Processes transactions (OK/NOK) and writes structured logs.  
- **Traffic Generator** – Simulates live payment traffic.  
- **Prometheus & Grafana** – Monitoring, alerting, and visualization.  
- **Fluent Bit + Elasticsearch + Kibana (EFK)** – Centralized logging and analysis.  
- **Terraform + AWS EKS (Fargate)** – Infrastructure as Code for secure and scalable deployment.

---

## 🧩 Deployment Phases

| Phase | Description | Tools |
|-------|--------------|-------|
| **1** | Build and push Docker images to AWS ECR | Docker, AWS ECR |
| **2** | Provision EKS + Fargate cluster via IaC | Terraform, AWS |
| **3** | Deploy services and simulate traffic | kubectl, YAML |
| **4** | Integrate monitoring & alerting | Prometheus, Grafana |
| **5** | Implement centralized logging | Fluent Bit, Elasticsearch, Kibana |

> **Note:** The ECR image URLs in Kubernetes manifests are placeholders.  
> Replace them with your own AWS ECR repository URIs before deployment.

---

## 📊 Monitoring & Logging
- **Prometheus** – Scrapes metrics from handler and processor endpoints.  
- **Grafana** – Displays dashboards for uptime and transaction status.  
- **Fluent Bit** – Streams logs from `/var/log/myapp` into Elasticsearch.  
- **Kibana** – Visualizes indexed logs for debugging and observability.  

---

## 🌐 Highlights
✅ Fully automated provisioning using **Terraform**  
✅ **Dockerized microservices** built and deployed on EKS Fargate  
✅ Real-time synthetic load generation with **Traffic Generator**  
✅ Integrated **Prometheus + Grafana** dashboards  
✅ Centralized log pipeline with **Fluent Bit + Elasticsearch + Kibana**

---

## 📂 Repository Structure
My-BankingApp/
├── alert_rules.yml
├── docker-compose.yml
├── fluent-bit.conf
├── grafana/
├── handler-service/
├── infra/
├── K8s/
├── logs/
├── processor-service/
├── prometheus.yml
├── push-to-ecr.sh
├── traffic-generator/
├── image.png
├── README.md

## 🏁 Next Steps
- Integrate CI/CD with GitHub Actions or Jenkins.  
- Add **Dapr** sidecars for resilience and observability.  
- Extend deployment to **multi-region EKS clusters**.

---

### 👩‍💻 Author
**Sindhu Telikapalli**  
DevOps · Cloud Engineer · SRE  
