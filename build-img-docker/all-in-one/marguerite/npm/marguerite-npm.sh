#!/bin/bash

mkdir -p /opt/marguerite/npm-registry/
cd /opt/marguerite/npm-registry/
echo " "
echo " URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY=$URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY "
echo " "
git clone     $URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY .
echo " "
# - on build
echo " build from source jbl / npm registry couhapp : "
echo " exactes instructions de : [https://github.com/npm/npm-registry-couchapp] " 

# Ci-dessous, le RUN équivalent à ajouter dans le fichier de conf "$HOME/.npmrc" : [_npm-registry-couchapp:couch=http://admin:password@localhost:5984/registry = "$URI_PRIVATE_NPM_REGISTRY"]
# RUN npm config set couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/registry
npm install
# npm start --npm-registry-couchapp:couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/margerite-registry
# npm run load --npm-registry-couchapp:couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/margerite-registry
# npm run copy --npm-registry-couchapp:couch=http://$FIRST_USER_NAME_DU_REGISTRY_NPM:$FIRST_USER_PWD_DU_REGISTRY_NPM@$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/margerite-registry
# - Je change l'approche, il s'agit bien de la BDD.
npm start --npm-registry-couchapp:couch=http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/margerite-registry
npm run load --npm-registry-couchapp:couch=http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/margerite-registry
npm run copy --npm-registry-couchapp:couch=http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/margerite-registry

