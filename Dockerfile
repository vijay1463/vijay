FROM ubuntu:latest
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir -p /usr/local/tomcat
RUN wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.57/* /usr/local/tomcat/
RUN rm -rf /usr/local/tomcat/conf/tomcat-users.xml
RUN rm -rf /usr/local/tomcat/webapps/manager/META-INF/context.xml
ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/
RUN mkdir /usr/local/tomcat/webapps 
COPY ./sparkjava-hello-world-1.0.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD sh /usr/local/tomcat/bin/catalina.sh run
