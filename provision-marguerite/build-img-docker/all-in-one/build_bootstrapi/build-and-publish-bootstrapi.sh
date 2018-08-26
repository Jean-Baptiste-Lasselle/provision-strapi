#!/bion/bash
# - parceque le publish doit être fait au run, après le build, et lorsque la conteneur npm-registry est up n running
cd /opt/projet-developpeur
npm pack
echo " vérification cible de publication npm => URI_PRIVATE_NPM_REGISTRY=$URI_PRIVATE_NPM_REGISTRY  "
export TAG=$TAG_ENV && npm run release
# npm publish --registry $URI_PRIVATE_NPM_REGISTRY
