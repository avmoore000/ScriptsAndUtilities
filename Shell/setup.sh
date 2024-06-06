#!/bin/bash

dpkg --add-architecture i386

add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

apt-get update -y
apt-get upgrade -y 

# Configure Java
echo "JAVA_HOME=/usr/local/java/jdk1.8.0_112" >> /etc/profile
echo "JRE_HOME=$JAVA_HOME/jre" >> /etc/profile
echo "PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin" >> /etc/profile
echo "export JAVA_HOME" >> /etc/profile
echo "export JRE_HOME" >> /etc/profile
echo "export PATH" >> /etc/profile

update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk1.8.0_112/jre/bin/java" 1

update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk1.8.0_112/bin/javac" 1

update-alternatives "/usr/bin/javaws" "javaws" "/usr/local/java/jdk1.8.0_112/bin/javaws" 1

update-alternatives --set java /usr/local/java/jdk1.8.0_112/jre/bin/java

update-alternatives --set javac /usr/local/java/jdk1.8.0_112/bin/javac

update-alternatives --set javac /usr/local/java/jdk1.8.0_112/bin/javaws

# Install programs
apt-get install -y vim kate blender gimp skype 

