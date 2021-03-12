FROM maven:3.6.3-jdk-11 as maven
COPY ./ ./maven-app
WORKDIR /maven-app 
RUN mvn install
# RUN pwd
# RUN ls
# RUN ls target
# RUN java -jar /target/*.jar
FROM openjdk:11
WORKDIR /maven-app
COPY --from=maven /spring-app/target/*.jar ./app.jar 
Run pwd
Run ls
ENTRYPOINT ["java","-jar","./app.jar"]
