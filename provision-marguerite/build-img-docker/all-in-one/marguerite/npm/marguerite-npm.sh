#!/bin/bash



# - 
# - Configuration de couchbase via son API rest : https://developer.couchbase.com/documentation/server/4.1/install/setup-cli-rest.html
# - 
echo " Installation de CouchBase : https://developer.couchbase.com/documentation/server/4.1/install/setup-cli-rest.html "
echo "You need CouchDB version 1.4.0 or higher. 1.5.0 or higher is best. So i'm gonna install it for you."

echo " +++ // Setup Administrator username and password"
curl -v -X POST http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/settings/web -d password=$USER_PWD_BDD_DU_REGISTRY_NPM -d username=$USER_NAME_BDD_DU_REGISTRY_NPM
echo " +++ // Setup services that couchbase will run"
# curl -u username=[$USER_NAME_BDD_DU_REGISTRY_NPM]&password=[$USER_PWD_BDD_DU_REGISTRY_NPM] -v -X POST http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/node/controller/setupServices -d services=data,index,query,moxi
curl -u username=$USER_NAME_BDD_DU_REGISTRY_NPM&password=$USER_PWD_BDD_DU_REGISTRY_NPM -v -X POST http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/node/controller/setupServices -d services=data,index,query,moxi
echo " celui là je ne sais pas à quoi il sert, donc je ne l'exécute pas : # Initialize Node # curl -v -X POST http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/nodes/self/controller/settings -d path=[location] -d index_path=[location] "
echo " celui là je ne sais pas à quoi il sert, donc je ne l'exécute pas : # Setup Bucket # curl -v -X POST http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/pools/default/buckets -d ramQuotaMB=[value]"
echo " celui là je ne sais pas à quoi il sert, donc je ne l'exécute pas : # Setup Index RAM Quota # curl -u username=[admin]&password=[password] -X POST http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/pools/default -d memoryQuota=[value] -d indexMemoryQuota=[value]" 




# et c'est la manière dont la doc npmregistry-couchbase-app recommande de créer la BDD couchbase du registry :
echo " +++ Once you have CouchDB installed, create a new database: curl -X PUT http://$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/registry "
curl -X PUT http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_DU_REGISTRY_NPM:$NO_PORT_DU_REGISTRY_NPM/margerite-registry

# - 
# - installation du serveur $URI_REPO_GIT_OFFICIEL_CODE_SOURCE_NPMREGISTRY
# - 
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
npm start --npm-registry-couchapp:couch=http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/margerite-registry
npm run load --npm-registry-couchapp:couch=http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/margerite-registry
npm run copy --npm-registry-couchapp:couch=http://$USER_NAME_BDD_DU_REGISTRY_NPM:$USER_PWD_BDD_DU_REGISTRY_NPM@$HOTE_RESEAU_BDD_DU_REGISTRY_NPM:$NO_PORT_BDD_DU_REGISTRY_NPM/margerite-registry

