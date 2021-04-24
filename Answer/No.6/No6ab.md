### MultiContainer Application Deployment

* Step 1
    ```
    # mkdir -p /root/var/lib/mysql
    # mkdir -p /root/var/www/html
    ```

* Step 2
    ```
    # docker network create --attachable mariadb-wp-privnet
    ```

* Step 3 (No 6a)
    ```
    # sestatus (melihat status SELinux)

    # setenforce 0 (merubah mode SELinux dari enforcing menjadi permissive secara temporary)
    
    # getenforce  (melihat mode SELinux)

    # vim /etc/selinux/config   (buka file config SELinux untuk konfigurasi)
        
        SELINUX=enforcing      (Ubah pada bagian ini menjadi permissive)

* Step 4 (No 6b)
    ```
    # vim myscript1.sh
    ```
    ```
    #!/bin/bash docker container run -d \
    --name mymariadb \
    -e MYSQL_ROOT_PASSWORD='redhat' \
    -e MYSQL_DATABASE='wpappdb' \
    -e MYSQL_USER='wpapp' \
    -e MYSQL_PASSWORD='redhat123' \
    -v /root/var/lib/mysql:/var/lib/mysql \
    --network mariadb-wp-privnet \
    mariadb
    ```

    ```
    # vim myscript2.sh
    ```
    ```
    #!/bin/bash docker container run -d \
    --name wordpress \
    -e WORDPRESS_DB_HOST='mariadb' \
    -e WORDPRESS_DB_USER='wpapp' \
    -e WORDPRESS_DB_PASSWORD='redhat123' \
    -e WORDPRESS_DB_NAME='wpappdb' \
    -v /root/var/www/html:/var/www/html \
    --network mariadb-wp-privnet \
    -p 80:80 \
    wordpress
    ```
* Step 5
    ```
    # chmod +x myscript1.sh
    # chmod +x myscript2.sh
    ```

* Step 6
    ```
    # ./myscript1.sh
    # ./myscript2.sh
    ```