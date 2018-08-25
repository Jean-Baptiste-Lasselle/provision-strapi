# provision-strapi
Une recette de déploiement strapi, sur un hôte docker, avec configuration NGINX

# Uitlisation

```
export PROVISIONING_HOME=$(pwd)/provision-bootstrapi
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa '
export URI_REPO_GIT=https://github.com/Jean-Baptiste-Lasselle/provision-strapi

mkdir -p $PROVISIONING_HOME
cd $PROVISIONING_HOME
git clone "$URI_REPO_GIT" .
chmod +x ./operations.sh
./operations.sh
```

Soit, en une seule ligne : 

```
export PROVISIONING_HOME=$(pwd)/provision-bootstrapi && export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa ' && export URI_REPO_GIT=https://github.com/Jean-Baptiste-Lasselle/provision-strapi && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "$URI_REPO_GIT" . && chmod +x ./operations.sh && ./operations.sh
```


