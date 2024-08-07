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

echo "Pipeline concluído com sucesso"
