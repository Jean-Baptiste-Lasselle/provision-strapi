#!/bion/bash
# - parceque le publish doit être fait au run, après le buiild, et lorsque la conteneur npm-registry est up n running
RUN npm pack
RUN npm publish --registry $URI_PRIVATE_NPM_REGISTRY
