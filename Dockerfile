# Use a imagem oficial do Node.js como base
FROM node:18

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
