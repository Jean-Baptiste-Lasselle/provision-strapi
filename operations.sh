#!/bin/bash

# - ENV
# - 
export MAISON=$(pwd)
export STRAPI_ENV=production
export NOM_IMAGE=bootstrapi
export VERSION_IMAGE=1.0.0
export URI_REPO_DOCKER=docker.kytes.io
export NOM_ORG=kytes
export CONTEXTE_BUILD_DOCKER=$MAISON/build-img-docker/all-in-one
# export NOM_COMPLET_IMAGE_DOCKER=$URI_REPO_DOCKER/$NOM_ORG/$NOM_IMAGE:$VERSION_IMAGE
export NOM_COMPLET_IMAGE_DOCKER=$NOM_ORG/$NOM_IMAGE:$VERSION_IMAGE
# export DOCKERFILE_BOOTSTRAPI_ONE=$MAISON/all-in-one.bootstrapi.dockerfile
export DOCKERCOMPOSEFILE_BOOTSTRAPI_ONE=$MAISON/all-in-one.bootstrapi.docker-compose.yml

# - pour plus tard, la séparation admin et apis.

export NOM_CONTNEU_BACKEND_ADMIN=boostrapi-admin-backend
export NOM_CONTENUR_FRONTEND_ADMIN=bootstrapi-admin-frontend


# -- OPS

mkdir -p $CONTEXTE_BUILD_DOCKER

# - on build l'image docker bootstrapi avec docler-compose  : $CONTEXTE_BUILD_DOCKER se trouve dans le fichier docker-compose.yml

docker-compse -f $DOCKERCOMPOSEFILE_BOOTSTRAPI_ONE build bootstrapi 
# ---tag $NOM_COMPLET_IMAGE_DOCKER -f $DOCKERFILE_BOOTSTRAPI_ONE $CONTEXTE_BUILD_DOCKER


# - on lance le conteneur

docker-compose up -f $DOCKERCOMPOSEFILE_BOOTSTRAPI_ONE
