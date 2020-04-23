FROM gradle:6.3-jdk8 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon
RUN ls
RUN ls build/
RUN ls build/libs

FROM adoptopenjdk/openjdk13-openj9:jdk-13.0.2_8_openj9-0.18.0-alpine-slim
RUN ls
RUN ls build/
RUN ls build/libs
COPY build/libs/foaas-alexa-*-all.jar foaas-alexa.jar
EXPOSE 8080
CMD ["java", "-Dcom.sun.management.jmxremote", "-Xmx128m", "-XX:+IdleTuningGcOnIdle", "-Xtune:virtualized", "-jar", "foaas-alexa.jar"]
