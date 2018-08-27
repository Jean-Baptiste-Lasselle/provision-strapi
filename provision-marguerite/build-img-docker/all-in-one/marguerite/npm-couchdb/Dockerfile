FROM couchbase/server
# Ajout du fichier de configuration
RUN echo " - VERIF EXISTENCE /opt/couchbase/etc/ " && ls -all /opt/couchbase/etc/
ADD ./etc/security/limits.conf .
RUN rm -f /etc/security/limits.conf
RUN cp ./limits.conf /etc/security/
# RUN rm-f /etc/couchdb/local.ini
ADD local.ini .
RUN cp -f ./local.ini /opt/couchbase/etc/
# /etc/couchdb/local.ini
RUN echo " "
RUN echo " - VERIF EXISTENCE /opt/couchbase/etc/local.ini " && ls -all /opt/couchbase/etc/local.ini
RUN echo " "
RUN echo " - VERIF CONTENU /opt/couchbase/etc/local.ini " && cat /opt/couchbase/etc/local.ini
RUN echo " "
EXPOSE 8091-8094:8091-8094
EXPOSE 11210:11210


