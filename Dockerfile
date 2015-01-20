FROM ubuntu:14.04
 
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8

#Utilities
RUN apt-get install -y vim less net-tools inetutils-ping wget curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common

#Install Oracle Java 8
RUN add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

#Maven
RUN curl http://apache.osuosl.org/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz | tar zx
RUN mv apache-maven* maven && \
    ln -s /maven/bin/mvn /usr/bin/mvn

#Sbt
RUN curl -L https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz | tar zx
RUN ln -s /sbt/bin/sbt /usr/bin/sbt

#Node
RUN curl http://nodejs.org/dist/v0.10.35/node-v0.10.35-linux-x64.tar.gz | tar xz
RUN mv node* node && \
    ln -s /node/bin/node /usr/local/bin/node && \
    ln -s /node/bin/npm /usr/local/bin/npm
ENV NODE_PATH /usr/local/lib/node_modules

#Grunt-init
RUN npm install -g grunt-init 

#Grunt CLI
RUN npm install -g grunt-cli

#PhantomJS
RUN apt-get install -y libfontconfig1
RUN npm install -g phantomjs

#Activator
RUN wget http://downloads.typesafe.com/typesafe-activator/1.2.12/typesafe-activator-1.2.12.zip && \
    unzip typesafe-activator*.zip && \
    rm typesafe-activator*.zip
RUN mv activator* activator
RUN ln -s /activator/activator /usr/bin/activator

#Gradle
RUN wget https://services.gradle.org/distributions/gradle-2.2.1-bin.zip && \
    unzip gradle*zip && \
    rm gradle*zip
RUN ln -s /gradle-2.2.1/bin/gradle /usr/bin/gradle

#Fig
RUN curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig

#HTTPie
RUN apt-get install -y python-pip
RUN pip install --upgrade httpie
