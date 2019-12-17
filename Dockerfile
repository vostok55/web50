FROM alpine/git AS first
WORKDIR /app
RUN git clone https://github.com/venkaDaria/puzzle15.git

FROM maven:3.5-jdk-8-alpine AS build
WORKDIR /app
COPY --from=first /app/puzzle15 /app
RUN mvn package

FROM tomcat:8.0-alpine
WORKDIR /app
COPY --from=build /app/target/Puzzle15-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]

