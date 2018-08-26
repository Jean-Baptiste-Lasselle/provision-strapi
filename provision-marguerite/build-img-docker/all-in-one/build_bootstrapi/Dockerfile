FROM centos:7

LABEL maintainer="Jean-Baptiste Lasselle <jean.baptiste.lasselle.it@gmail.com>" \
      org.label-schema.vendor="Bootstrapi Devops" \
      org.label-schema.name="Dockerized Bootstrapi Devops process cycle image - BUILD PHASE" \
      org.label-schema.description="A Simple strapi.io devops cycle containerized automation" \
      org.label-schema.url="https://github.com/Jean-Baptiste-Lasselle" \
      org.label-schema.vcs-url="https://github.com/Jean-Baptiste-Lasselle/provision-strapi" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0.0"

ARG URI_REPO_GIT_DEVELOPPEURS_DEFAUT
ENV URI_REPO_GIT_DEVELOPPEURS=$URI_REPO_GIT_DEVELOPPEURS_DEFAUT
# [npm.kytes.io] amène vers un conteneur dans le même hôte docker, par configuration de 3 noeuds réseau:
#  1 - le reverse proxy NGINX qui définit que toute requête lui arrviant, avec le domaine npm.kytes.io, est redirigée vers le contenur registry npm kytes
#  2 - le serveur DNS, désignons le par "KYTES_DNS", qui  associe le domaine npm.kytes.io, à l'adresse IP de l'hôte docker sur lequel se trovue le conteneur NGINX et le conteneur NPM registry
#  3 - toute machine qui voudrta accéder à npm.kytes.io, devra comporter dans sa configuration de carte réseau : dnsnameservers $ADRESSE_IP_DU_SERVEUR_KYTES_DNS

ARG URI_PRIVATE_NPM_REGISTRY_DEFAUT
ENV URI_PRIVATE_NPM_REGISTRY=$URI_PRIVATE_NPM_REGISTRY_DEFAUT

ARG NO_VERSION_BOOOTSTRAPI_DE_DEPART_PAR_DEFAUT
ENV NO_VERSION_BOOOTSTRAPI_DE_DEPART=$NO_VERSION_BOOOTSTRAPI_DE_DEPART_PAR_DEFAUT

ARG NO_VERSION_PUBLICATION_BOOOTSTRAPI_PAR_DEFAUT
ENV NO_VERSION_PUBLICATION_BOOOTSTRAPI=$NO_VERSION_PUBLICATION_BOOOTSTRAPI_PAR_DEFAUT

RUN yum update -y && yum install -y wget git curl sed

RUN # - Installation configuration nodejs / npm 
# - cycle de build ("build lifecycle") par défaut de NPM : [https://docs.npmjs.com/misc/scripts]

RUN yum install -y epel-release
RUN yum install -y nodejs
RUN node --version
RUN yum install -y npm
RUN npm --version
RUN echo " "
RUN echo " "
# - configuration du registry privé NPM : ici on ne veut pas faire le pull, on veut juste publier, donc on n'utilisera le private registry pour la commande publish
# RUN npm config set registry = "$URI_PRIVATE_NPM_REGISTRY"
RUN mkdir -p /opt/projet-developpeur
WORKDIR /opt/projet-developpeur
RUN git clone "$URI_REPO_GIT_DEVELOPPEURS" .
RUN echo " "
RUN echo " "
RUN echo " CONTENU PROJET CODE SOURCE AVANT BUILD : " 
RUN echo " "
RUN echo " "
RUN ls -all
RUN echo " "
RUN echo " "
RUN echo " - ++ CYCLE DEV ++ on appliquera un changement mineur dans le code source, puis on change de numéro de version dans le package.json, en vue de la publication :  " 
RUN echo " "
RUN echo " "
RUN sed -i 's/$NO_VERSION_BOOOTSTRAPI_DE_DEPART/$NO_VERSION_PUBLICATION_BOOOTSTRAPI/g' ./package.json
RUN echo " "
RUN echo " "
RUN echo " - ++ CYCLE DEV ++ puis suit à la lettre, la procédure indiquée pour commencer le développement avec strapi."
# cf. 
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm install && npm build]"
RUN echo "[ RUN : npm run setup --build]"
RUN echo " "
RUN echo " "
# RUN npm install 
RUN npm run setup --build
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run release]"
RUN echo " "
RUN echo " "
# sert uniquement pour exécuter le npm run release, parce que cette variable d'environnement est référencée dans le script d'origine venant de strapi.io, et importé automatiquement dans $URI_REPO_GIT_DEVELOPPEURS
# cf. $URI_REPO_GIT_DEVELOPPEURS/package.json   => release: ....
ARG TAG_PAR_DEFAUT=$NO_VERSION_PUBLICATION_BOOOTSTRAPI_PAR_DEFAUT
ENV TAG_ENV=$TAG_PAR_DEFAUT
# cf. son utilisation dans ./build-and-publish-bootstrapi.sh
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "


RUN echo " "
RUN echo " "
RUN echo " CONTENU PROJET CODE SOURCE APRES BUILD : " 
RUN echo " "
RUN echo " "
RUN ls -all
RUN echo " "
RUN echo " "

# - ++ CYCLE DEV ++ ensuite on réalise la procédure de build 




# - ++ CYCLE DEV ++ enfin on réalise la procédure de publication sur le registry NPM privé : ds l'infra entreprise
# - suppose qu'NPM a été configuré, après son installation, ppour faire usage du registry privé npm.marguerite.io
# RUN npm pack
# RUN npm publish --registry $URI_PRIVATE_NPM_REGISTRY
ADD build-and-publish-bootstrapi.sh /opt/projet-developpeur
RUN chmod +x /opt/projet-developpeur/build-and-publish-bootstrapi.sh
RUN cp ./build-and-publish-bootstrapi.sh /opt/marguerite/build-and-publish-bootstrapi.sh
# - on pourra aussi réaliser l'exécution du build à l'exécution du conteneur
# Ce travail sera fait par le Jenkins pipeline, déclenché par un push sur le git repo du code source boostrapi, dont
# la première version (le premier commit & push) provient de'une version bien spécifique de l'officiel strapi.
CMD [/opt/marguerite/build-and-publish-bootstrapi.sh]








