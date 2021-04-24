# dockerfile to build image for Myjava-app  8.5

# Add your description here ...
FROM rhel:7.2

# Add your description here ...
MAINTAINER "FirstName LastName" "emailaddress@gmail.com"

# melakukan update dependencies 2.install openssh-client telnet unzip dan java-1.8.0 3.membersihkan semua cache
RUN yum -y update 
RUN yum -y install sudo openssh-clients telnet unzip java-1.8.0-openjdk-devel
RUN yum clean all

# setup passwordless di dalam satu perintah 5.menonaktifkan requiretty menjadi default
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN sed -i 's/.*requiretty$/Defaults !requiretty/' /etc/sudoers

# menambahkan user dengan nama myjava-app 7.mengganti password menjadi kosong pada user myjava-app 8.membuat user myjava-app menjadi user sudo
RUN useradd -m myjava-app
RUN echo myjava-app: | chpasswd
RUN usermod -a -G wheel myjava-app

# membuat direktori /rh di dalam direktori /opt 10.tempat kerja direktori berada di /opt/rh
RUN mkdir -p /opt/rh
WORKDIR /opt/rh

# menambahkan file myjava-app-8.5.0.zip kedalam direktori /tmp 12.membongkar file zip myjava-app-8.5.0.zip di dalam direktori /tmp
ADD myjava-app-8.5.0.zip /tmp/myjava-app-8.5.0.zip
RUN unzip /tmp/myjava-app--8.5.0.zip

# menambahkan environment Myjava-app_HOME kedalam /opt/rh/myjava-app-8.5 
ENV Myjava-app_HOME /opt/rh/myjava-app-8.5

# membuat Myjava-app console user
RUN $Myjava-app_HOME/bin/add-user.sh admin admin@2016 --silent

# konfigurasi Myjava-app
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Dmyjava-app.bind.address=0.0.0.0 -Dmyjava-app.bind.address.management=0.0.0.0\"" >> $Myjava-app_HOME/bin/standalone.conf

# mengganti kepemilikan direktori /opt/rh kepada user myjava-app
RUN chown -R myjava-app:myjava-app /opt/rh

# mendefinisikan port listen untuk 8080 9990 9999
EXPOSE 8080 9990 9999

# instruksi untuk mendefinisikan perintah apa yg akan di eksekusi ketika menjalankan container
ENTRYPOINT $Myjava-app_HOME/bin/standalone.sh -c standalone-full-ha.xml

# menyalin file myapp.war kedalam Myjava-app_HOME/standalone/deployment/
ADD myapp.war "$Myjava-app_HOME/standalone/deployments/"

# menggunakan user myjava-app untuk menjalankan perintah di dalam container 21.perintah mengeksekusi bash di dalam contaienr
USER myjava-app
CMD /bin/bash