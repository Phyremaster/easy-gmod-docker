# Debian base image with SteamCMD
FROM cm2network/steamcmd:root

# DO NOT OVERRIDE THESE
ENV GMODID=4020 \
	GMODDIR=/home/steam/garrysmod \
	CSSID=232330 \
	CSSDIR=/home/steam/css \
	TF2ID=232250 \
	TF2DIR=/home/steam/tf2 \
	SERVERCFG=${GMODDIR}/garrysmod/cfg/server.cfg \
	MOUNTCFG=${GMODDIR}/garrysmod/cfg/mount.cfg

# Environment variables
ENV HOSTNAME="A Garry's Mod Server" \
	MAXPLAYERS=20 \
	GAMEMODE=sandbox \
	GAMEMAP=gm_flatgrass \
	ALLTALK=0 \
	MAXFILESIZE=1024 \
	WORKSHOPID="" \
	DOWNLOADURL="" \
	LOADINGURL="" \
	PASSWORD="" \
	RCONPASSWORD="" \
	LOGINTOKEN=""

# Mount other game content
ADD --chown=steam mount.cfg $MOUNTCFG

# Add autoupdate script
ADD --chown=steam autoupdatescript.txt ${GMODDIR}/

# Start main script
WORKDIR /home/steam/
ADD --chown=steam easygmod.sh .
RUN dos2unix easygmod.sh
RUN chmod a+rx easygmod.sh
USER steam
CMD ./easygmod.sh

# Set up container
EXPOSE 27015/tcp 27015/udp
VOLUME ${GMODDIR} ${CSSDIR} ${TF2DIR}