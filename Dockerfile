FROM ubuntu:20.04 AS build
RUN apt-get update -y
RUN apt-get install default-jre -y
RUN apt-get update -y
RUN apt-get install git -y
RUN git clone https://github.com/bharathsh96/hello-world-war.git
RUN apt-get update -y
WORKDIR hello-world-war
RUN apt-get install maven -y
RUN mvn clean package

FROM tomcat:latest
COPY --from=build ./hello-world-war/target/hello-world-war-1.0.0.war ./webapps
CMD ["service","tomcat"] 

RUN apt-get update -y
RUN ln -s /opt/apache-tomcat/bin/startup.sh /usr/local/bin/tomcatup
RUN ln -s /opt/apache-tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown
EXPOSE 8080
