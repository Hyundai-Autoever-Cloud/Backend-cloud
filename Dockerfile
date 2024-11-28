# Step 1: 빌드 단계 (build stage)
# Gradle을 사용하여 애플리케이션 빌드
FROM gradle:7.5.1-jdk17 AS build

# 애플리케이션 소스를 컨테이너로 복사
WORKDIR /app
COPY . /app

# Gradle 빌드
RUN ./gradlew build

# Step 2: 실행 단계 (runtime stage)
# OpenJDK 17을 사용하여 빌드된 애플리케이션을 실행할 경량 이미지
FROM openjdk:17-jdk-slim

# 빌드된 JAR 파일을 컨테이너의 /app 디렉토리로 복사
COPY --from=build /app/build/libs/*.jar app.jar

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]

# 컨테이너가 리스닝할 포트 지정 (Spring Boot 기본 포트 8080)
EXPOSE 8080