# Maven build container 

FROM maven:3.5.2-jdk-8-alpine AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

From tomcat:8.0.51-jre8-alpine

RUN rm -rf /usr/local/tomcat/webapps/*

#maintainer 
MAINTAINER nauman@uog.edu.pk
#expose port 8080
EXPOSE 8080

#default command
#CMD java -jar /data/LOGISTICS.jar

#copy hello world to docker image from builder image

COPY --from=maven_build /tmp/target/v1.war /usr/local/tomcat/webapps/v1.war
CMD ["catalina.sh","run"]
