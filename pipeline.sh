#!/bin/sh

# Cores
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
reset='\033[0m'

echo "${yellow}🚀 Iniciando o script pipeline.sh${reset}"

echo "${yellow}🧪 Executando testes...${reset}"
yarn test
if [ $? -ne 0 ]; then
  echo "${red}❌ Falha nos testes${reset}"
  exit 1
fi

echo "${yellow}🔍 Executando linting...${reset}"
yarn lint
if [ $? -ne 0 ]; then
  echo "${red}❌ Falha no linting${reset}"
  exit 1
fi

# Mensagem final
echo "${green}🎉 Checks de pre-commit concluídos com sucesso!${reset}"
