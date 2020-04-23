# FROM gradle:6.3-jdk8 AS build
# COPY --chown=gradle:gradle . /home/gradle/src
# WORKDIR /home/gradle/src
# RUN gradle build --no-daemon
# COPY build/libs/foaas-alexa-0.1-all.jar foaas-alexa.jar
# EXPOSE 8080
# CMD ["java", "-Dcom.sun.management.jmxremote", "-Xmx128m", "-XX:+IdleTuningGcOnIdle", "-Xtune:virtualized", "-jar", "foaas-alexa.jar"]

# http://paulbakker.io/java/docker-gradle-multistage/
FROM gradle:6.3-jdk8 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:10-jre-slim
EXPOSE 8080
RUN ls /home/gradle/src/
COPY --from=builder /home/gradle/src/foaas-alexa/build/distributions/foaas-alexa.tar /app/
WORKDIR /app
RUN tar -xvf foaas-alexa.tar
WORKDIR /app/foaas-alexa
CMD bin/foaas-alexa
