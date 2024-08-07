#!/bin/bash

echo "Building Docker image..."
docker build -t twa-govinda-systems-ecomm .

echo "Running tests..."
docker run twa-govinda-systems-ecomm yarn test

echo "Running linting..."
docker run twa-govinda-systems-ecomm yarn lint

echo "Running Trivy scan..."
docker run --rm -v $(pwd):/app -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy fs --exit-code 1 --severity HIGH,CRITICAL --no-progress .
