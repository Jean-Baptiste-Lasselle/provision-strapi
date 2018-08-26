#!/bion/bash
# - parceque le publish doit être fait au run, après le build, et lorsque la conteneur npm-registry est up n running
npm pack
echo " vérification cible de publication npm => URI_PRIVATE_NPM_REGISTRY=$URI_PRIVATE_NPM_REGISTRY  "
npm publish --registry $URI_PRIVATE_NPM_REGISTRY
