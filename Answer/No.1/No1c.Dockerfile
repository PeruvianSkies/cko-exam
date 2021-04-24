# dockerfile to build image for Myjava-app  8.5

# menggunakan image dasar rhel:7.2 untuk membuat image baru
FROM rhel:7.2

# mencantumkan pengelola image, saya tidak mencantumkan maintainer untuk memperkecil jumlah layer
# MAINTAINER "FirstName LastName" "emailaddress@gmail.com"

# pada layer ini menjalankan beberapa perintah yang di butuhkan image yaitu,
# (fyi. keterangan setelah baris perintah)
RUN yum -y update \         # update dependencies
    && yum -y install sudo openssh-clients telnet unzip java-1.8.0-openjdk-devel \      # install openssh-client, install telnet, install unzip, install java-1.8.0-openjdk
    && yum clean all \      # membersihkan semua cache
    && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \    # setup passwordless didalam satu perintah
    && sed -i 's/.*requiretty$/Defaults !requiretty/' /etc/sudoers \    # menonaktifkan requiretty menjadi default
    && useradd -m myjava-app \      # menambahkan user dengan nama myjava-app
    && echo myjava-app: | chpasswd \    # mengganti password menjadi kosong pada user myjava-app
    && usermod -a -G wheel myjava-app \     # membuat user myjava-app menjadi user sudo
    && mkdir -p /opt/rh     # membuat direktori /rh di dalam direktori /opt

# pada layer ini medefinisikan direktori tempat berada di /opt/rh
WORKDIR /opt/rh

# pada layer ini menambahkan file myjava-app-8.5.0.zip kedalam direktori /tmp
ADD myjava-app-8.5.0.zip /tmp/myjava-app-8.5.0.zip

# pada layer ini membongkar file zip myjava-app-8.5.0.zip di dalam direktori /tmp
RUN unzip /tmp/myjava-app--8.5.0.zip

# pada layer ini menambahkan environment Myjava-app_HOME kedalam /opt/rh/myjava-app-8.5
ENV Myjava-app_HOME /opt/rh/myjava-app-8.5

# pada layer ini menjalankan beberapa perintah yang dibutuhkan ketika membangun image, yaitu
# (fyi. keterangan setelah baris perintah)
RUN $Myjava-app_HOME/bin/add-user.sh admin admin@2016 --silent \    # membuat Myjava-app console user
    && echo "JAVA_OPTS=\"\$JAVA_OPTS -Dmyjava-app.bind.address=0.0.0.0 -Dmyjava-app.bind.address.management=0.0.0.0\"" >> $Myjava-app_HOME/bin/standalone.conf \    # konfigurasi Myjava-app
    && chown -R myjava-app:myjava-app /opt/rh   # mengganti kepemilikan direktori /opt/rh kepada user myjava-app

# pada layer ini mendefinisikan port listen yang di butuhkan image pada 8080 9990 9999
EXPOSE 8080 9990 9999

# pada layer ini mendefinisikan perintah apa yg akan di eksekusi ketika menjalankan container
ENTRYPOINT $Myjava-app_HOME/bin/standalone.sh -c standalone-full-ha.xml

# pada layer ini menyalin file myapp.war kedalam Myjava-app_HOME/standalone/deployment/
ADD myapp.war "$Myjava-app_HOME/standalone/deployments/"

# pada layer ini mendefinisikan user yang di gunakan yaitu myjava-app untuk menjalankan perintah di dalam container
USER myjava-app

# pada layer ini mendefinisikan perintah untuk mengeksekusi bash di dalam container
CMD /bin/bash

# Total layer setelah saya lakukan beberapa modifikasi pada dockerfile ini yaitu 12 layer