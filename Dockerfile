FROM maven:3.6-jdk-8 AS build  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package

FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/OracleBanking-1.0-SNAPSHOT.jar /usr/app/OracleBanking-1.0-SNAPSHOT.jar 
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/OracleBanking-1.0-SNAPSHOT.jar"] 
