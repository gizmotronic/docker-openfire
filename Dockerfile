FROM openjdk:11-jre

#RUN apt-get update && apt-get install -y wget openjdk-11-jre-headless

ENV OPENFIRE_VERSION=4.9.0 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo wget fontconfig libfreetype6 \
 && echo "Downloading openfire_${OPENFIRE_VERSION}_all.deb ..." \
 && wget --no-verbose "http://download.igniterealtime.org/openfire/openfire_${OPENFIRE_VERSION}_all.deb" -O /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && dpkg -i --force-depends /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin \
 && ln -s /usr/local/openjdk-17/bin/java /usr/bin/java \
 && rm -rf /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*


#-p 3478:3478 -p 3479:3479 -p 448:448 -p 5222:5222 -p 5223:5223 \
# -p 5229:5229 -p 5262:5262 -p 5263:5263 -p 5269:5269 -p 5270:5270 \
# -p 5275:5275 -p 5276:5276 -p 7070:7070 -p 7443:7443 -p 7777:7777 \
# -p 9090:9090 -p 9091:9091 -p 9997:9997 \
# -v /srv/dev-disk-by-label-KAPITDATA3/ITFiles/3.Backup/DOCKER/Gajim_Openfire:/var/lib/openfire \
# -v /srv/dev-disk-by-label-KAPITDATA3/ITFiles/3.Backup/DOCKER/Gajim_Openfire/Logs:/var/log/openfire \

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 5275/tcp 5276/tcp 5262/tcp 5263/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp 9091/tcp
VOLUME ["${OPENFIRE_DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
