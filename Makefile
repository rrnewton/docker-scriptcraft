
TAG=rrnewton/scriptcraft:latest

.PHONY: jars all run image

all: jars image run

# RRN: This is the newest I think:
CANARY=CanaryMod-1.8.0-1.2.1-SNAPSHOT-shaded.jar

jars: $(CANARY) sc-mqtt.jar scriptcraft.jar

$(CANARY):
	wget http://scriptcraftjs.org/download/latest/$(CANARY)

sc-mqtt.jar:
	wget http://scriptcraftjs.org/download/extras/mqtt/sc-mqtt.jar 

scriptcraft.jar:
# RRN bumping to 3.2.0 from 3.1.10 in the orig Dockerfile [2016.05.15]:
	wget http://scriptcraftjs.org/download/latest/scriptcraft-3.2.0/scriptcraft.jar 

image:
	docker build -t $(TAG) .

# --privileged 
MOUNT= -v $(shell pwd)/../scriptcraft_scripts:/gabriel_scripts:ro \
       -v $(shell pwd)/minecraft:/minecraft:rw

# Can't bind 22 on a linux server of course, that's already in use:
#   -p 22:22
# I can do this, but then I need to set up passwords or some such:
#   -p 8022:22
PORTS = -p 25565:25565

run:
	docker run $(PORTS) $(MOUNT) -it $(TAG)
