FROM maven:3.5-jdk-8 AS build
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 80
COPY --from=build /usr/src/app/target/01-aws-hello-world-rest-api-1.0.0-RELEASE.jar /usr/app/01-aws-hello-world-rest-api-1.0.0-RELEASE.jar  
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /usr/app/01-aws-hello-world-rest-api-1.0.0-RELEASE.jar" ]