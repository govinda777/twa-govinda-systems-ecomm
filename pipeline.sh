#!/bin/sh

# Função para adicionar cores
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
reset='\033[0m'

# Captura o início do tempo de execução
start_time=$(date +%s)

echo "${yellow}🚀 Iniciando o script pipeline.sh${reset}"

# Construindo a imagem Docker com cache otimizado
echo "${yellow}🔨 Construindo a imagem Docker...${reset}"
docker build --quiet -t twa-govinda-systems-ecomm . || {
  echo "${red}❌ Falha na construção da imagem Docker${reset}"
  exit 1
}

# Executando testes e linting em paralelo para ganhar tempo
echo "${yellow}🧪 Executando testes e linting...${reset}"
{
  yarn test && echo "${green}✅ Testes passaram${reset}"
} & {
  yarn lint && echo "${green}✅ Linting passou${reset}"
}

# Aguardar os dois processos paralelos terminarem
wait
if [ $? -ne 0 ]; then
  echo "${red}❌ Falha nos testes ou no linting${reset}"
  exit 1
fi

# Somente rodar o Trivy scan se os testes e linting passarem
echo "${yellow}🔎 Executando Trivy scan...${reset}"
docker run --rm -v $(pwd):/app twa-govinda-systems-ecomm trivy fs --exit-code 1 --severity HIGH,CRITICAL --no-progress --format json -o trivy-report.json /app || {
  echo "${red}❌ Trivy encontrou vulnerabilidades${reset}"

  # Verifique se o jq está instalado antes de tentar processar o arquivo JSON
  if command -v jq > /dev/null; then
    cat trivy-report.json | jq '.'
  else
    echo "${red}❌ 'jq' não encontrado. Por favor, instale 'jq' para ver os detalhes das vulnerabilidades.${reset}"
    cat trivy-report.json
  fi
  exit 1
}

echo "${green}✅ Nenhuma vulnerabilidade crítica encontrada${reset}"

# Mensagem final amigável
echo "${green}🎉 Parabéns! O Pipeline foi concluído com sucesso!${reset}"
echo "${green}💡 Código testado, analisado e livre de vulnerabilidades críticas. Você está pronto para seguir em frente! 💪${reset}"

# Captura o fim do tempo de execução
end_time=$(date +%s)

# Calcula o tempo total em segundos
total_time=$((end_time - start_time))

# Converte o tempo total para minutos e segundos
minutes=$((total_time / 60))
seconds=$((total_time % 60))

# Exibe o tempo total
echo "${yellow}⏱ Tempo total de execução: ${minutes} minutos e ${seconds} segundos${reset}"
