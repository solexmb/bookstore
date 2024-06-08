# Use a base image with JDK and Maven pre-installed
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src/

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight base image for the application
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage to the container
COPY --from=build /app/target/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
