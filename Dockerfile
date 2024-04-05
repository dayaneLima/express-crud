# Informa ao Docker qual imagem base iremos utilizar
FROM ubuntu:20.04 as base

# Versão do node que vamos instalar
ENV NODE_VERSION 19.6.0

# Instalacao libs necessarias
RUN apt-get update
RUN apt-get -y install curl wget tar apt-utils apt-transport-https lsb-release gnupg libc6
RUN apt-get install lsof
RUN apt-get install nano

#Instalação node
RUN wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
RUN tar xvfJ "node-v$NODE_VERSION-linux-x64.tar.xz"  -C /usr/
ENV PATH=/usr/node-v$NODE_VERSION-linux-x64/bin:$PATH
RUN rm -f "node-v$NODE_VERSION-linux-x64.tar.xz"

WORKDIR /app


# Ambiente de desenvolvimento
FROM base as development
COPY . .
WORKDIR /app
EXPOSE 3000 9229
# usado para o container não morrer enquanto a aplicação não foi criada, ao descomentar a linha acima, comente essa abaixo
CMD tail -f /dev/null
# Caso já tenha o node com o package.json mas ainda não tem o comando de inicialização (npm run dev, etc)
# CMD npm install && tail -f /dev/null
# descomentar somente após a aplicação base ser criada
# CMD npm install && npm run dev


# Ambiente de produção
FROM base as production
COPY . .
WORKDIR /app
EXPOSE 8000
CMD npm install && npm run build && npm run prod
