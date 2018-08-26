#!/bin/bash

# - +++ ENV





export MAISON=$(pwd)
export STRAPI_ENV=production
export NOM_IMAGE=bootstrapi
export VERSION_IMAGE=1.0.0
export NOM_HOTE_RESEAU_REPO_DOCKER=docker.marguerite.io
export NOM_ORG=kytes

# export NOM_COMPLET_IMAGE_DOCKER=$NOM_HOTE_RESEAU_REPO_DOCKER/$NOM_ORG/$NOM_IMAGE:$VERSION_IMAGE
export DOCKERFILE_BOOTSTRAPI_ONE=$MAISON/all-in-one.bootstrapi.dockerfile
export DOCKERCOMPOSEFILE_MARGUERITE_ONE=$MAISON/provision-bootstrapi/all-in-one.marguerite.docker-compose.yml
export DOCKERCOMPOSEFILE_BOOTSTRAPI_ONE=$MAISON/provision-bootstrapi/all-in-one.bootstrapi.docker-compose.yml



# - +++ OPS


# - on build l'image docker bootstrapi avec docler-compose  : $CONTEXTE_BUILD_DOCKER se trouve dans le fichier docker-compose.yml
# docker-compose -f $DOCKERCOMPOSEFILE_BOOTSTRAPI_ONE build bootstrapi 
# ---tag $NOM_COMPLET_IMAGE_DOCKER -f $DOCKERFILE_BOOTSTRAPI_ONE $CONTEXTE_BUILD_DOCKER


# - on lance 

# docker run -d --name db -p 8091-8094:8091-8094 -p 11210:11210 couchbase && 
# docker-compose -f $DOCKERCOMPOSEFILE_MARGUERITE_ONE up && docker-compose -f $DOCKERCOMPOSEFILE_BOOTSTRAPI_ONE up

docker-compose up




