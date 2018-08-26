#!/bin/bash
# En date du build docker, la dernière version LTS de NOdeJS / NPM est la 8.11.4
# export DERNIERE_VERSION_LTS_NODEJS_NPM=8.11.4
# wget https://nodejs.org/dist/v$DERNIERE_VERSION_LTS_NODEJS_NPM/node-v$DERNIERE_VERSION_LTS_NODEJS_NPM-linux-x64.tar.xz

yum install epel-release
yum install nodejs
node --version

yum install npm
npm --version
