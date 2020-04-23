# http://paulbakker.io/java/docker-gradle-multistage/
FROM gradle:6.3-jdk8 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build
RUN ls build/
RUN ls build/distributions

FROM openjdk:10-jre-slim
EXPOSE 8080
COPY --from=builder /home/gradle/src/build/distributions/foaas-alexa-[0-9]*.[0-9]*.tar /app/foaas-alexa.tar
WORKDIR /app
RUN tar -xvf foaas-alexa.tar
WORKDIR /app/foaas-alexa
ENTRYPOINT bin/foaas-alexa
