from debian:sid

env DEBIAN_FRONTEND noninteractive
run apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get clean
run apt-get update && \
    apt-get install -y openjdk-8-jre rsync ssh less nano && \
    apt-get clean
# minecraft

env SERVER glowstone++-1.9.2-SNAPSHOT.jar

add $SERVER /opt/minecraft/glowstone++.jar
# add sc-mqtt.jar /opt/minecraft/sc-mqtt.jar
# add scriptcraft.jar /opt/minecraft/plugins/scriptcraft.jar

# run echo "eula=true" > /opt/minecraft/eula.txt
add server.cfg /opt/minecraft/config/server.cfg
add default_NORMAL.cfg /opt/minecraft/config/worlds/default/default_NORMAL.cfg

# a default ssh access to upload js 
add sshd_config /etc/ssh/sshd_config
run mkdir -p /opt/minecraft/scriptcraft/players/
run echo "root:minecraft" | chpasswd

add start /start
run chmod +x /start

expose 25565 22

# RRN: I can't figure out when this would be helpful.  It saves the
# data, which is good, but it creates a fresh copy every time it runs.
# volume ["/minecraft"]
# volume ["/u/rrnewton/gabriel_coding/"]

# cmd /start
