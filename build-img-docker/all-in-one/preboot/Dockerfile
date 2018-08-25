FROM centos7:latest

LABEL maintainer="Jean-Baptiste Lasselle <jean.baptiste.lasselle.it@gmail.com>" \
      org.label-schema.vendor="Bootstrapi Devops" \
      org.label-schema.name="Dockerized Bootstrapi Devops process cycle iamge" \
      org.label-schema.description="A Simple strapi.io devops cycle containerized automation" \
      org.label-schema.url="https://github.com/Jean-Baptiste-Lasselle" \
      org.label-schema.vcs-url="https://github.com/Jean-Baptiste-Lasselle/provision-strapi" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0.0"
ENV URI_REPO_GIT_DEVELOPPEURS=https://github.com/Jean-Baptiste-Lasselle/bootstrapi

ENV URI_REGISTRY_NPM=

RUN yum update -y && yum install - y wget git curl  
RUN # TODO : installation configuration nodejs / npm 
RUN mkdir -p projet-developpeur
RUN WORKDIR projet-developpeur

RUN git clone  
RUN git clone  
RUN git clone "" .  

ADD




# - ++ CYCLE DEV ++ on commence par suivre à la lettre, la procédureindiquée pour commencer le développement avec strapi : on appliquera un changement mineur dans le code source.



# - ++ CYCLE DEV ++ ensuite on réalise la procédure de build 




# - ++ CYCLE DEV ++ enfin on réalise la procédure de publication sur le registry NPM privé : ds l'infra entreprise


# - on pourra aussi lirer l'exécution du build à l'exécution du conteneur
# CMD [./build-and-publish-bootstrapi.sh]

CMD ["/bin/bash"]








