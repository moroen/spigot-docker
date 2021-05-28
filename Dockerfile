FROM alpine:latest

RUN apk add openjdk11 git wget screen python3
WORKDIR /opt
RUN mkdir spigot
WORKDIR /opt/spigot

RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
# RUN git config --global --unset core.autocrlf
RUN java -jar BuildTools.jar

RUN ln -s spigot*.jar spigot.jar

# COPY start.sh /opt/spigot
COPY minecraftd /opt/spigot

EXPOSE 25565
WORKDIR /opt/spigot/server
CMD ../minecraftd ./spigot.jar -Xms2G -Xmx2G -XX:+UseG1GC 
