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

RUN yum update -y && yum install -y wget git curl  

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
RUN mkdir -p projet-developpeur
WORKDIR projet-developpeur
RUN git clone "$URI_REPO_GIT_DEVELOPPEURS" .
RUN echo " "
RUN echo " "
RUN echo " CONTENU PROJET CODE SOURCE AVANT BUILD : " 
RUN echo " "
RUN echo " "
RUN ls -all
RUN echo " "
RUN echo " "
RUN echo " - ++ CYCLE DEV ++ on commence par suivre à la lettre, la procédure indiquée pour commencer le développement avec strapi : on appliquera un changement mineur dans le code source."
# cf. 
RUN npm run build && npm run build --plugins && npm run setup --plugins
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm build]"
RUN echo " "
RUN echo " "
RUN npm build
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm build --plugins]"
RUN echo " "
RUN echo " "
RUN npm build --plugins
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run build]"
RUN echo " "
RUN echo " "
RUN npm run build
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run build --plugins]"
RUN echo " "
RUN echo " "
RUN npm run build --plugins
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run setup build]"
RUN echo " "
RUN echo " "
RUN npm run setup build
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run setup build --plugins]"
RUN echo " "
RUN echo " "
RUN npm run setup build --plugins
RUN echo " "
RUN echo " "

RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run setup]"
RUN echo " "
RUN echo " "
RUN npm run setup
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run setup --plugins]"
RUN echo " "
RUN echo " "
RUN npm run setup --plugins
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo " "
RUN echo "[ RUN : npm run setup --plugins]"
RUN echo " "
RUN echo " "
RUN npm run setup --plugins
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
ADD build-and-publish-bootstrapi.sh .
RUN chmod +x ./build-and-publish-bootstrapi.sh
# - on pourra aussi réaliser l'exécution du build à l'exécution du conteneur
# Ce travail sera fait par le Jenkins pipeline, déclenché par un push sur le git repo du code source boostrapi, dont
# la première version (le premier commit & push) provient de'une version bien spécifique de l'officiel strapi.
CMD [./build-and-publish-bootstrapi.sh]
# CMD ["/bin/bash"]








