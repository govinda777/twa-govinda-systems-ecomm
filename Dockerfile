# Use a imagem oficial do Node.js como base
FROM node:18

# Instala o Trivy
RUN apt-get update && \
    apt-get install -y wget apt-transport-https gnupg lsb-release && \
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos package.json e yarn.lock para o diretório de trabalho
COPY package.json yarn.lock ./

# Instala as dependências do projeto
RUN yarn install

# Copia o restante dos arquivos do projeto
COPY . .

# Comando padrão ao iniciar o contêiner
CMD ["yarn", "lint"]
