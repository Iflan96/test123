FROM alpine/git as clone 
WORKDIR /app
RUN git clone https://github.com/Iflan96/test123.git

FROM maven:3.6-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/test123 /app
RUN mvn install

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/ImgurUploader-1.0-SNAPSHOT.jar /app
EXPOSE 8080
RUN sh -c 'touch ImgurUploader-1.0-SNAPSHOT.jar'
ENTRYPOINT ["java","-jar","ImgurUploader-1.0-SNAPSHOT.jar"]
