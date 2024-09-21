#!/bin/sh

# Função para adicionar cores
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
reset='\033[0m'

echo -e "${yellow}🚀 Iniciando o script pipeline.sh${reset}"

echo -e "${yellow}🔨 Construindo a imagem Docker...${reset}"
docker build -t twa-govinda-systems-ecomm .
if [ $? -ne 0 ]; then
  echo -e "${red}❌ Falha na construção da imagem Docker${reset}"
  exit 1
fi

echo -e "${yellow}🧪 Executando testes...${reset}"
yarn test
if [ $? -ne 0 ]; then
  echo -e "${red}❌ Falha nos testes${reset}"
  exit 1
fi

echo -e "${yellow}🔍 Executando linting...${reset}"
yarn lint
if [ $? -ne 0 ]; then
  echo -e "${red}❌ Falha no linting${reset}"
  exit 1
fi

echo -e "${yellow}🔎 Executando Trivy scan...${reset}"
docker run --rm -v $(pwd):/app twa-govinda-systems-ecomm trivy fs --exit-code 1 --severity HIGH,CRITICAL --no-progress --format json -o trivy-report.json /app
if [ $? -ne 0 ]; then
  echo -e "${red}❌ Trivy encontrou vulnerabilidades${reset}"

  # Verifique se o jq está instalado antes de tentar processar o arquivo JSON
  if command -v jq > /dev/null; then
    cat trivy-report.json | jq '.'
  else
    echo -e "${red}❌ 'jq' não encontrado. Por favor, instale 'jq' para ver os detalhes das vulnerabilidades.${reset}"
    cat trivy-report.json
  fi
  exit 1
else
  echo -e "${green}✅ Nenhuma vulnerabilidade crítica encontrada${reset}"
fi

# Mensagem final amigável
echo -e "${green}🎉 Parabéns! O Pipeline foi concluído com sucesso!${reset}"
echo -e "${green}💡 Código testado, analisado e livre de vulnerabilidades críticas. Você está pronto para seguir em frente! 💪${reset}"
