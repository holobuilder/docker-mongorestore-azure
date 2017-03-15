FROM mhart/alpine-node

RUN npm install --global azure-cli

RUN \
    echo http://dl-3.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    echo http://dl-3.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache mongodb-tools && \
    rm /usr/bin/mongotop /usr/bin/mongoexport /usr/bin/mongodump /usr/bin/mongostat /usr/bin/mongofiles /usr/bin/mongoimport /usr/bin/mongooplog /usr/bin/bsondump

ADD restore.sh /
RUN chmod 0755 restore.sh

ENTRYPOINT ["/restore.sh"]
