FROM couchbase/server
# Ajout du fichier de configuration
RUN echo " - VARIF EXISTENCE /etc/couchdb/ " && ls -all /etc/couchdb/
RUN echo " - VARIF EXISTENCE /etc/couchdb/local.ini " && ls -all /etc/couchdb/local.ini
# RUN rm-f /etc/couchdb/local.ini
ADD local.ini .
RUN cp -f ./local.ini /opt/couchbase/etc/
# /etc/couchdb/local.ini

EXPOSE 8091-8094:8091-8094
EXPOSE 11210:11210


