# provision-strapi
Une recette de déploiement strapi, sur un hôte docker, avec configuration NGINX

# Utilisation

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
# ROADMAP

cahque relerase de ce repo correspondra à un fichier *docker-compose.yml

* `RELEASE-0.0.0:all-in-one.bootstrapi.docker-compose.yml` : l'objectif est d'arrvier à réaliser un déploiement strapi à partir de son code source sur https://github.com/strapi/strapi .  Même s'il foire, il doit être réalisé à partir d'un JEnkins pipeline, à l'aide d'un registry NPM privé, donc à l'aide d'un contneur Jenkins, un contneur Gitlab, un Conteneur privvate-NPM-registry, plus un conteneur NGINX pour gérer le tout. L'idée est de créer et publier sur le registry private NPM, un package bootstrapi@1.0.0, qui sera utilisé au déploiemnet par npm install -g bootstrapi@1.0.0 , ce numéro de version sera alors mappable vers un numéro de version git.
* `RELEASE-0.0.0:all-in-one.bootstrapi.docker-compose.yml` : modifier le pipeline précédent, pour pouvoir déployer admin et le reste dans deux conteneurs différents. trouver pourquoui le docker-compose.yml du repo github officiel `docker-strapi`, fait un partage de volume de toute la racine de l'applciation créée avec strapi new. 

# TODOs : Il faut que je fasse un registry NPM privé

Pour démontrer le cycle complet de développement, avec : 
* Un conteneur Gitlab
* Un conteneur Jenkins avec Jenkins pipeline déploiement strapi à base de conteneur
* Un contneur avec serveur DNS, utilisant une interface réseau de l'hôte docker qu'il est seul à utiliser. les machiens, y compris l'hôte docker, ayant accès à ces applications doivent être configurées avec ce serveur DNS? auprès duquel on enregistre cahque application déployée.
* Un conteneur NGINX avec les configurations reverse proxy pour chaque conteneur
* Un conteneur avec un registry NPM privé
* Un conteneur avec un registry docker privé


# Réfénrences cycle dev NPM

* https://scotch.io/bar-talk/how-to-build-and-publish-a-npm-package :  là se trouve l'explication de ce que fait STRAPI dans la doc officlelle quand ils disent de faire un npm link strapi dans le projet créé avec `strapi new` => on a fait un `npm install -g strapi@$NUMERO_VERSION`, ce qui installe globalement strapi, ce qui permet de fgaire strapi new monprojet, et derreière, quand on fait le npom link, on fait un symlink des modules strapi installés globalement, vers le repertoire `node_modules` de mon projet. C'est un peu comme si je faisais un npm install de strapi en non global, donc dans mon projet courant, mais sans réellement amener les fichiers. Donc, la question reste : comment fait-on, pour versionner le code source des développeurs? eh bien en fait c'est bien cela, on doit le versionner en enlevant els symlinks, pour n'avoir que l'essentiel. Et le cyle donne : 
  * On récupère le code source porduit par les développeurs, on refait le git clone du master de strapi (donc qui décide de la version de frameqork strapi utilisé), 
  * et là, on ne fait pas les symlinks, au lieu de ça on installe la dépendance strapi diret dans le projet. On fait `npm install strapi@$NUMERO_VERSION_STRAPI`.
  * Ensuite, on doit faire le build and publish à l'intérieur du projet :  on fera un `npm build && npm build --plugins && npm run build && npm run build --plugins && npm run setup --plugins` 


## Registry Docker privé

Ultra simple :

https://hub.docker.com/_/registry/

## Petit memo bonnes pratiques Dockerfile/docker-compose.yml

### Paramétrage des publications, pour le client

*  Pour chaque image de conteur, si elle est paramétrée, on utilise pour chaque paramètre : un "ARG", qui permet de fixer, au moment du build (donc par le publisher), la valeur par défaut de la variable d'environnement, et donc une varible `ENV`, ce qui donne :

```
FROM centos7:latest
# on ne donne pas de valeur par défaut à la valeur par défaut.. elle DOIT, être renseignée au build, avec la syntaxe  
ARG STRAPIBDD_HOST_PAR_DEFAUT
ENV STRAPIBDD_HOST=$STRAPIBDD_HOST_PAR_DEFAUT
RUN echo "La valeur de STRAPIBDD_HOST_PAR_DEFAUT=$STRAPIBDD_HOST_PAR_DEFAUT sera disponible pendant le build, mais pas le run"
RUN echo "La valeur de STRAPIBDD_HOST=$STRAPIBDD_HOST sera disponible pendant le build, et le sra aussi au run"

EXPOSE 1337

CMD ["echo \"et donc la valeur de STRAPIBDD_HOST=$STRAPIBDD_HOST est bien disponible au run, mais pas la valeur de STRAPIBDD_HOST_PAR_DEFAUT=$STRAPIBDD_HOST_PAR_DEFAUT \""]
```
Donc, pour utiliser correctement ce paramétrage le long de la supply chain des produits distribués vers le client : 

```
export NOM_CONTNEUR=mon-instance-de-produit
# composé de  : $HOTE_RESEAU_NPMREGISTRY/$NOM_ORGANISATION_PUBLIANTE/$NOM_PRODUIT:$VERSION_PRODUIT_SEMVER
export HOTE_RESEAU_NPMREGISTRY=npm.marguerite.io
export NOM_ORGANISATION_PUBLIANTE=notre-petite-equipe
export NOM_PRODUIT=bootstrapi
export VERSION_PRODUIT_SEMVER=1.0.0
export NOM_COMPLET_IMAGE=$HOTE_RESEAU_NPMREGISTRY/$NOM_ORGANISATION_PUBLIANTE/$NOM_PRODUIT:$VERSION_PRODUIT_SEMVER
# au build, on fixe la valeur par défaut, et on publie l'image de conteneur avec cette valeur par défaut, en pensant aux utilisateurs de l'image.
docker build --tag $NOM_COMPLET_IMAGE --build-arg STRAPIBDD_HOST_PAR_DEFAUT=localhost
# Et l'utilsiateur, pour changer la valeur par défaut donnée au build à la variable d'environnement [$STRAPIBDD_HOST], utilisera
# la syntaxe suivante pour re-définir, au moement du lancement du coneneur, la valeur de la varible d'environnement 
docker run -it --name $NOM_CONTNEUR -p 1337:1337 $NOM_COMPLET_IMAGE -e STRAPIBDD_HOST=bdd-strapi.kytes.io
```

Enfin, pour utiliser les varibles d'environnement et les "build-args" dans les docker-compose.yml : 


```

```

## Registry privé NPM provision/config

### configurer une installation NodeJS/NPM pour la forcer à faire usage d'un registry privé particulier

Selon [cette page de la doc. officielle NPM](https://docs.npmjs.com/misc/registry) : 

```
Set "private": true in your package.json to prevent it from being published at all, or 

"publishConfig":{"registry":"http://my-internal-registry.local"} 

to force it to be published only to your internal registry.

```

Selojn la même source, voici le repository du code source de l'application "NPM Registry", utilisée pour le registry public officiel NPM : 

https://github.com/npm/npm-registry-couchapp

J' ai regardé sur dockerhub, il n'y a pas de distribution de conteneur NPM registry, qui soit assez transparente pour être utilisée directement.
 créer un conteneur Docker, en suivant les instructions de build indiquées dans le README.md de ce repository Github.
De plus la docuementationd e ce repo indique comment configurer le client NPM pour faire usage de ce registry privé NPM : 

```
Using the registry with the npm client

With the setup so far, you can point the npm client at the registry by putting this in your ~/.npmrc file:

registry = http://localhost:5984/registry/_design/app/_rewrite

You can also set the npm registry config property like:

npm config set \
  registry=http://localhost:5984/registry/_design/app/_rewrite

Or you can simple override the registry config on each call:

npm \
  --registry=http://localhost:5984/registry/_design/app/_rewrite \
  install <package>
```


Ok, voici le petit test qui montre comemt j'ai effectivement bel et bien configuré le registry privé NPM, dans le même conteneur docker que le alpine utilsié par léquipe STRAPI :

```
/ # npm config set registry "http://marguerite_npm:5984/registry/_design/app/_rewrite"
/ # npm install lint
npm ERR! code ENOTFOUND
npm ERR! errno ENOTFOUND
npm ERR! network request to http://marguerite_npm:5984/registry/_design/app/_rewrite/lint failed, reason: getaddrinfo ENOTFOUND marguerite_npm marguerite_npm:5984
npm ERR! network This is a problem related to network connectivity.
npm ERR! network In most cases you are behind a proxy or have bad network settings.
npm ERR! network 
npm ERR! network If you are behind a proxy, please make sure that the
npm ERR! network 'proxy' config is set properly.  See: 'npm help config'

npm ERR! A complete log of this run can be found in:
npm ERR!     /root/.npm/_logs/2018-08-17T00_45_10_995Z-debug.log

```

### LA BDD Couchbase du registry
dans un conteneur séparé du registry lui-même
cf. le ./*docker-compose.yml correspondant à la release

 https://hub.docker.com/r/couchbase/server/


# Dernière erreur

Principal problème en l'état :  le conteneur CouchBase bdd du registry privé docker, est isntable. Il empêche le fonctionnement du registry NPM privé.


```
Step 28/111 : RUN npm run build && npm run build --plugins && npm run setup --plugins
 ---> Running in 71708f73254d
npm ERR! Linux 3.10.0-862.el7.x86_64
npm ERR! argv "/usr/bin/node" "/usr/bin/npm" "run" "build"
npm ERR! node v6.14.3
npm ERR! npm  v3.10.10

npm ERR! missing script: build
npm ERR! 
npm ERR! If you need help, you may report this error at:
npm ERR!     <https://github.com/npm/npm/issues>

npm ERR! Please include the following file with any support request:
npm ERR!     /projet-developpeur/npm-debug.log
ERROR: Service 'build_bootstrapi' failed to build: The command '/bin/sh -c npm run build && npm run build --plugins && npm run setup --plugins' returned a non-zero code: 1
[jibl@pc-100 provision-bootstrapi]$ 

```


