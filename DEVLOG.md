


## [2016.06.05] {Trying glowstone++ for the first time}

I think all these servers are standarized to use the same world format
config files?  There was some commentary about putting it in your
existing server dir.

The jar fetches other things:

    + /usr/bin/java -Xmx4096M -jar glowstone++.jar
    16:00:08 [INFO] This server is running Glowstone++ version
    1.9.2-SNAPSHOT-"d6c17c2"-MC1.9.2 (Implementing API version 1.9.2-R0.1-SNAPSHOT)
    16:00:08 [INFO] Creating default config: config/glowstone.yml
    16:00:09 [INFO] Recipes: 295 shaped, 63 shapeless, 26 furnace, 10
    dynamic, 28 fuels.
    16:00:09 [INFO] Downloading mysql-connector-java 5.1.38...
    16:00:09 [INFO] Downloading slf4j-jdk14 1.7.15...
    16:00:09 [INFO] Downloading sqlite-jdbc 3.7.2...
    16:00:09 [INFO] Downloaded slf4j-jdk14 1.7.15.
    16:00:09 [INFO] Downloaded mysql-connector-java 5.1.38.
    16:00:09 [INFO] Downloaded sqlite-jdbc 3.7.2.
    16:00:09 [INFO] Scanning plugins...
    16:00:09 [INFO] Created default config: config/help.yml
    16:00:09 [INFO] Preparing spawn for world...
    16:00:12 [INFO] Preparing spawn for world: 0%
    16:00:13 [INFO] Preparing spawn for world: 2%
    ...
    16:00:23 [INFO] Created default config: config/commands.yml
    16:00:23 [INFO] Created default config: config/permissions.yml
    16:00:23 [INFO] Binding to address: 0.0.0.0/0.0.0.0:25565...
    16:00:23 [INFO] Successfully bound to: /0:0:0:0:0:0:0:0:25565
    16:00:23 [INFO] Ready for connections.

I can always hop into it from another terminal with:

    docker exec -it $(docker ps -q) bash
    
(assuming only one container is running!)

HAH, even before CONNECTING the server crashed after a bit:

    16:00:23 [INFO] Ready for connections.
    16:05:24 [SEVERE] Error while loading chunk (5,8)
      java.util.zip.ZipException: unknown compression method
      at java.util.zip.InflaterInputStream.read(InflaterInputStream.java:164)

Ok, and this is with a FRESH world.  However, I did use the same
config files from the previous canarymod setup.  Hmm, I don't have any
confirmation that it actually read/used them though.

Uh, when it says "API version 1.9.2-R0.1-SNAPSHOT"  does that number
correlate with the minecraft version?  I.e. should I connect with a
client running 1.9(.2?)?  Well... if I connect with 1.8 I get:

    java.lang.NullPointerException: group
    
Well lookee there!   Right in my list of servers it says "Glowstone++
1.9.2" in when I refresh servers.  Ok let's connect with ver 1.9.2 of

the minecraft jar.  Hmm, still failed to connect.  Server says:

    16:06:32 [INFO] Ready for connections.
    16:10:25 [INFO] Evithyon [/68.45.38.255:59908] lost connection
    
Trying again keeps disconnecting... though it says:

    16:11:05 [INFO] Evithyon [/68.45.38.255:59916] connected, UUID: 11321308-2721-4c1f-bdc3-6ba13901b5f0
    16:11:05 [INFO] Evithyon joined the game
    16:11:51 [INFO] Evithyon [/68.45.38.255:59923] lost connection
    16:11:51 [INFO] Evithyon left the game

Man I haven't even tried scriptcraft yet!  Or any other plugins...

It created `./config/glowstone.yml`.  I could toy with that.
Documented here: https://github.com/GlowstoneMC/GlowstonePlusPlus/wiki/Configuration-Guide

Then... another random exception.  Glowstone++ seems untenable...

    6:18:18 [SEVERE] Error while executing GlowTask{id=18, plugin=null,
    sync=true:
    net.glowstone.net.handler.login.EncryptionKeyResponseHandler$ClientAuthCallback$$Lambda$38/1214094820@5fd2d0ea}
    net.glowstone.libs.com.flowpowered.network.exception.ChannelClosedException:
    Trying to send a message when a session is inactive!
       at net.glowstone.libs.com.flowpowered.network.session.BasicSession.sendWithFuture(BasicSession.java:89)

Opping the character first doesn't make any difference. It gets "lost
connection" just the same.

Just for the heck of it, I tried running it outside of the docker
container.  That yields other problems:

    12:39:22 [INFO] Downloading slf4j-jdk14 1.7.15...
    12:39:23 [WARNING] Failed to download: mysql-connector-java 5.1.38
    javax.net.ssl.SSLHandshakeException: Received fatal alert: handshake_failure
        at sun.security.ssl.Alerts.getSSLException(Alerts.java:192)

BUT it still gets to the "Ready for connections." point.  And... 
it still gets random exceptions:

    12:44:36 [SEVERE] Error while loading chunk (25,-20)
    java.io.IOException: Unknown version: 0

When I run it native, I actually can't connect.  Server doesn't show
up properly in the list.  I can't get an nmap on veronica either.  The
port must be blocked somehow.  (Interesting that docker gets around
that...)

