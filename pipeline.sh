#!/bin/bash

# Exit on any error
set -e

# Defina o nome da imagem
IMAGE_NAME="twa-govinda-systems-ecomm:latest"

# Construa a imagem Docker
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Execute testes dentro do contêiner Docker
echo "Running tests..."
docker run --rm $IMAGE_NAME yarn test

# Execute linting dentro do contêiner Docker
echo "Running linting..."
docker run --rm $IMAGE_NAME yarn lint || true

# Verifique se o Trivy está instalado
if ! command -v trivy &> /dev/null
then
    echo "Trivy not found. Please install it manually:"
    echo "sudo apt-get update"
    echo "sudo apt-get install -y wget apt-transport-https gnupg lsb-release"
    echo "wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -"
    echo "echo deb https://aquasecurity.github.io/trivy-repo/deb \$(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/trivy.list"
    echo "sudo apt-get update"
    echo "sudo apt-get install -y trivy"
    exit 1
fi

# Execute escaneamento de vulnerabilidades com Trivy
echo "Scanning for vulnerabilities..."
trivy fs --exit-code 1 --severity HIGH,CRITICAL --no-progress --format json -o trivy-report.json .

# Exibe mensagem de sucesso
echo "Pipeline executed successfully!"

# Mostrar relatório Trivy
cat trivy-report.json | jq '.'
