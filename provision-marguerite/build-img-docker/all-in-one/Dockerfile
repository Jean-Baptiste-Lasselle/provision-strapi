FROM node:9.11.1-alpine

LABEL maintainer="Jean-Baptiste Lasselle <jean.baptiste.lasselle.it@gmail.com>" \
      org.label-schema.vendor="Jean-Baptiste Lasselle - Fullstack Devops Architect" \
      org.label-schema.name="Dockerized Bootstrapi Devops process cycle image - DEPLOYMENT PHASE" \
      org.label-schema.description="A Simple strapi.io devops cycle containerized automation" \
      org.label-schema.url="https://github.com/Jean-Baptiste-Lasselle" \
      org.label-schema.vcs-url="https://github.com/Jean-Baptiste-Lasselle/provision-strapi" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0.0"


ARG URI_REPO_GIT_DEVELOPPEURS_DEFAUT
ARG URI_PRIVATE_NPM_REGISTRY_DEFAUT
ENV NUMERO_VERSION_BOOTSTRAPI=$URI_REPO_GIT_DEVELOPPEURS_DEFAUT
ENV URI_PRIVATE_NPM_REGISTRY=$URI_PRIVATE_NPM_REGISTRY_DEFAUT
WORKDIR /usr/src/api

# - on va donc installer le package publié avec la modification de code des développeurs, donc bootstrapi@$NUMERO_VERSION_BOOTSTRAPI
# - mais avant cela, il nous faut ocnfigurer le package manager NPM, pour qu'il utilise notre registry privé NPM:
RUN npm config set registry = "$URI_PRIVATE_NPM_REGISTRY"
# RUN npm install -g strapi@3.0.0-alpha.13.1
RUN npm install -g bootstrapi@$NUMERO_VERSION_BOOTSTRAPI


COPY strapi.sh ./
RUN chmod +x ./strapi.sh

EXPOSE 1337

COPY healthcheck.js ./
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
      CMD node /usr/src/api/healthcheck.js

CMD ["./strapi.sh"]
