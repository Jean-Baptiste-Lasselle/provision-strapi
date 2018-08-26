FROM nginx
LABEL maintainer="Jean-Baptiste Lasselle <jean.baptiste.lasselle.it@gmail.com>" \
      org.label-schema.vendor="Jean-Baptiste Lasselle - Fullstack Devops Architect" \
      org.label-schema.name="Dockerized NPM private registry, as a romantic pétale de marguerite" \
      org.label-schema.description="A marguerite petal" \
      org.label-schema.url="https://github.com/Jean-Baptiste-Lasselle" \
      org.label-schema.vcs-url="https://github.com/Jean-Baptiste-Lasselle/provision-strapi" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0.0"

# J'ajoute la configuration des pétles de marguerite : 
ADD marguerite.conf .
RUN cp ./marguerite.conf /etc/nginx/conf.d/marguerite.conf
# J'ajoute la conf des services déployés avec l'applciatif Strapi
ADD bootstrapi.conf .
RUN cp ./bootstrapi.conf /etc/nginx/conf.d/bootstrapi.conf

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
