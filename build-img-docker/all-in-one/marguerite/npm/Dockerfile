FROM centos:7
LABEL maintainer="Jean-Baptiste Lasselle <jean.baptiste.lasselle.it@gmail.com>" \
      org.label-schema.vendor="Jean-Baptiste Lasselle - Fullstack Devops Architect" \
      org.label-schema.name="Dockerized NPM private registry, as a romantic pétale de marguerite" \
      org.label-schema.description="A marguerite petal" \
      org.label-schema.url="https://github.com/Jean-Baptiste-Lasselle" \
      org.label-schema.vcs-url="https://github.com/Jean-Baptiste-Lasselle/provision-strapi" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0.0"

# on ne donne pas de valeur par défaut à la valeur par défaut.. elle DOIT, être renseignée au build, avec la syntaxe [] 
ARG URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY_DEFAUT
ENV URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY=$URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY_DEFAUT
# https://github.com/npm/npm-registry-couchapp/releases/tag/v2.7.1
ARG VERSION_CODE_SOURCE_NPMREGISTRY_DEFAUT
ENV VERSION_CODE_SOURCE_NPMREGISTRY=$VERSION_CODE_SOURCE_NPMREGISTRY_DEFAUT
# - la config réseau du serveur 
ARG HOTE_RESEAU_DU_REGISTRY_NPM_DEFAUT
ENV HOTE_RESEAU_DU_REGISTRY_NPM=$HOTE_RESEAU_DU_REGISTRY_NPM_DEFAUT
ARG NO_PORT_DU_REGISTRY_NPM_DEFAUT
ENV NO_PORT_DU_REGISTRY_NPM=$NO_PORT_DU_REGISTRY_NPM_DEFAUT
# - le premier utilsiateur existant après installation du registry npm
ARG  FIRST_USER_NAME_DU_REGISTRY_NPM_DEFAUT
ENV  FIRST_USER_NAME_DU_REGISTRY_NPM=$FIRST_USER_PWD_DU_REGISTRY_NPM_DEFAUT
ARG  FIRST_USER_PWD_DU_REGISTRY_NPM_DEFAUT
ENV  FIRST_USER_PWD_DU_REGISTRY_NPM=$FIRST_USER_PWD_DU_REGISTRY_NPM_DEFAUT

# - la bdd couchbase utilsiée par ce registry npm : pour l'instant , je l'installe dans le même conteneur...
ARG HOTE_RESEAU_BDD_DU_REGISTRY_NPM_DEFAUT
ENV HOTE_RESEAU_BDD_DU_REGISTRY_NPM=$HOTE_RESEAU_BDD_DU_REGISTRY_NPM_DEFAUT
ARG NO_PORT_BDD_DU_REGISTRY_NPM_DEFAUT
ENV NO_PORT_BDD_DU_REGISTRY_NPM=$NO_PORT_BDD_DU_REGISTRY_NPM_DEFAUT
ARG  USER_NAME_BDD_DU_REGISTRY_NPM_DEFAUT
ENV  USER_NAME_BDD_DU_REGISTRY_NPM=$USER_NAME_BDD_DU_REGISTRY_NPM_DEFAUT
ARG  USER_PWD_BDD_DU_REGISTRY_NPM_DEFAUT
ENV  USER_PWD_BDD_DU_REGISTRY_NPM=$USER_PWD_BDD_DU_REGISTRY_NPM_DEFAUT

# - system setup 
RUN yum update -y && yum install -y curl wget tree git
# On clone, on build, et on run, le registry private NPM

# - build from source 
RUN # - Installation configuration nodejs / npm 
# - cycle de build ("build lifecycle") par défaut de NPM : [https://docs.npmjs.com/misc/scripts]

RUN yum install -y epel-release
RUN yum install -y nodejs
RUN echo " "
RUN echo " Version NodeJS : "
RUN echo " "
RUN node --version
RUN echo " "
RUN yum install -y npm
RUN echo " "
RUN echo " Version NPM : "
RUN echo " "
RUN npm --version
RUN echo " "
RUN echo " "
RUN mkdir -p build-from-source
WORKDIR build-from-source
RUN echo " "
RUN echo " URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY=$URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY "
RUN echo " "
RUN git clone "$URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY" .
RUN echo " "
# - on build
RUN echo " build from source jbl / npm registry couhapp : "
RUN echo " exactes instructions de : [https://github.com/npm/npm-registry-couchapp] " 

# Ci-dessous, le RUN équivalent à ajouter dans le fichier de conf "$HOME/.npmrc" : [_npm-registry-couchapp:couch=http://admin:password@localhost:5984/registry = "$URI_PRIVATE_NPM_REGISTRY"]
# RUN npm config set couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/registry

RUN npm install
RUN npm start --npm-registry-couchapp:couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/registry
RUN npm run load --npm-registry-couchapp:couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/registry
RUN npm run copy --npm-registry-couchapp:couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/registry


EXPOSE 5984
