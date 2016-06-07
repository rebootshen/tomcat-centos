FROM centos:centos7
MAINTAINER sam.shen

#helpful utils, but only sudo is required
#RUN yum -y install tar
#RUN yum -y install vim
#RUN yum -y install nc
RUN yum -y install sudo


###### JDK8

#Note that ADD uncompresses this tarball automatically
ADD jdk-8u91-linux-x64.tar.gz /opt
WORKDIR /opt/jdk1.8.0_91
RUN alternatives --install /usr/bin/java java /opt/jdk1.8.0_91/bin/java 1
RUN alternatives --install /usr/bin/jar jar /opt/jdk1.80_91/bin/jar 1
RUN alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_91/bin/javac 1
RUN echo "JAVA_HOME=/opt/jdk1.8.0_91" >> /etc/environment


###### Tomcat

ADD apache-tomcat-8.0.35.tar.gz /opt
WORKDIR /opt/
RUN mv apache-tomcat-8.0.35 tomcat8
RUN echo "JAVA_HOME=/opt/jdk1.8.0_91/" >> /etc/default/tomcat8
RUN groupadd tomcat
RUN useradd -s /bin/bash -g tomcat tomcat
ADD tomcat-users.xml /opt/tomcat8/conf/
RUN chown -Rf tomcat.tomcat /opt/tomcat8
EXPOSE 8080
