### Build Stage ###
FROM maven:3.6.3-jdk-8 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean install


### Package Stage ###
#FROM adoptopenjdk/openjdk11:alpine-jre
# Refer to Maven build -> finalName
#ARG JAR_FILE=target/websocket-demo-0.0.1-SNAPSHOT.jar
# cd /opt/app
#WORKDIR /opt/app
# cp target/websocket.jar /opt/app/app.jar
#COPY ${JAR_FILE} app.jar
# java -jar /opt/app/app.jar
#ENTRYPOINT ["java","-jar","app.jar"]

FROM openjdk:8
COPY --from=build /home/app/target/websocket-demo-0.0.1-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]
