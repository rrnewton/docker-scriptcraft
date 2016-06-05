
TAG=rrnewton/glowstone-scriptcraft:latest

.PHONY: jars all run image other-files

all: other-files jars image run mine

other-files: server.cfg default_NORMAL.cfg sshd_config

# Super lame: Docker can't handle EITHER symlinks or ../ paths:
server.cfg: ../canarymod_server/server.cfg
	cp $^ $@
default_NORMAL.cfg: ../canarymod_server/default_NORMAL.cfg
	cp $^ $@
sshd_config: ../canarymod_server/sshd_config
	cp $^ $@


# +'s need to be URL encoded, but wget seems to be smart about this:
SERVER=glowstone++-1.9.2-SNAPSHOT.jar

jars: $(SERVER) sc-mqtt.jar scriptcraft.jar

$(SERVER):
	wget https://bamboo.gserv.me/browse/GSPP-SRV/latestSuccessful/artifact/shared/Server-JAR/${SERVER}

sc-mqtt.jar:
	wget http://scriptcraftjs.org/download/extras/mqtt/sc-mqtt.jar 

scriptcraft.jar:
# RRN bumping to 3.2.0 from 3.1.10 in the orig Dockerfile [2016.05.15]:
	wget http://scriptcraftjs.org/download/latest/scriptcraft-3.2.0/scriptcraft.jar 

image:
	docker build -t $(TAG) .

mine:
	sudo chown -R $(USER) ./minecraft/

# Mount the scripts read only:
# Mount and mutate the WORLD on the host file system:
# --privileged 
MOUNT= -v $(shell pwd)/../../scriptcraft_scripts:/gabriel_scripts:ro \
       -v $(shell pwd)/minecraft:/minecraft:rw

# Can't bind 22 on a linux server of course, that's already in use:
#   -p 22:22
# I can do this, but then I need to set up passwords or some such:
#   -p 8022:22
PORTS = -p 25565:25565

run:
	docker run $(PORTS) $(MOUNT) -it $(TAG)
