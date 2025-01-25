# Use the official OpenJDK image as the base image
FROM openjdk:17-jdk-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the jar file from the target folder of your project into the container
COPY target/java-maven-app-1.1.0-SNAPSHOT.jar /app/javamaven.jar


# Expose the port that your application will run on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "/app/javamaven.jar"]
