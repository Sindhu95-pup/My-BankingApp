#!/bin/bash
set -e

# === CONFIGURATION ===
INFRA_DIR="./infra"
AWS_REGION="eu-central-1"  # match what you set in provider block

# === GET REPO URLS FROM TERRAFORM ===
echo "📥 Fetching repository URLs from Terraform outputs..."
HANDLER_REPO_URL=$(terraform -chdir=$INFRA_DIR output -raw handler_repo_url)
PROCESSOR_REPO_URL=$(terraform -chdir=$INFRA_DIR output -raw processor_repo_url)

echo "   Handler repo:   $HANDLER_REPO_URL"
echo "   Processor repo: $PROCESSOR_REPO_URL"

# === LOGIN TO ECR ===
echo "🔐 Logging in to ECR..."
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region $AWS_REGION \
  | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# === BUILD & TAG IMAGES ===
echo "🏗️ Building images..."
docker build -t handler:latest ./handler-service
docker build -t processor:latest ./processor-service

echo "🏷️ Tagging images..."
docker tag handler:latest ${HANDLER_REPO_URL}:latest
docker tag processor:latest ${PROCESSOR_REPO_URL}:latest

# === PUSH TO ECR ===
echo "⬆️ Pushing handler-service..."
docker push ${HANDLER_REPO_URL}:latest

echo "⬆️ Pushing processor-service..."
docker push ${PROCESSOR_REPO_URL}:latest

echo "✅ Done! Images pushed to ECR."
