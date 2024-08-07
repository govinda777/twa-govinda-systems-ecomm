#!/bin/sh
echo "Iniciando o script pipeline.sh"

echo "Construindo a imagem Docker..."
docker build -t twa-govinda-systems-ecomm .
if [ $? -ne 0 ]; then
  echo "Falha na construção da imagem Docker"
  exit 1
fi

echo "Executando testes..."
yarn test
if [ $? -ne 0 ]; then
  echo "Falha nos testes"
  exit 1
fi

echo "Executando linting..."
yarn lint
if [ $? -ne 0 ]; then
  echo "Falha no linting"
  exit 1
fi

echo "Executando Trivy scan..."
docker run --rm -v $(pwd):/app twa-govinda-systems-ecomm trivy fs --exit-code 1 --severity HIGH,CRITICAL --no-progress --format json -o trivy-report.json /app
if [ $? -ne 0 ]; then
  echo "Trivy encontrou vulnerabilidades"
  cat trivy-report.json | jq '.'
  exit 1
else
  echo "Nenhuma vulnerabilidade crítica encontrada"
fi

echo "Pipeline concluído com sucesso"
