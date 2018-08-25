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

# Il faut que je fasse un registry NPM privé

Pour démontrer le cycle complet de développement, avec : 
* Un conteneur Gitlab
* Un conteneur Jenkins avec Jenkins pipeline déploiement strapi à base de conteneur
* Un contneur avec serveur DNS, utilisant une interface réseau de l'hôte docker qu'il est seul à utiliser. les machiens, y compris l'hôte docker, ayant accès à ces applications doivent être configurées avec ce serveur DNS? auprès duquel on enregistre cahque application déployée.
* Un conteneur NGINX avec les configurations reverse proxy pour chaque conteneur
* Un conteneur avec un registry NPM privé
* Un conteneur avec un registry docker privé


