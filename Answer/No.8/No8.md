### Deployment PostgreSQL

* 8a Fungsi

1. **apiVersion** : mendefinisikan versi endpoint API yang digunakan.

2. **kind** : mempresentasikan sebuah type yang akan di buat di dalam openshift, kind:deployment (mempresentasikan deployment object di dalam openshift)

3. **labels** : merupakan seperangkat informasi yang berupa metadata dengan tujuan yang di khususkan.

4. **objects** : sebuah entitas untuk menyediakan yang spesifik ketika membuat file .yml untuk di deploy di dalam openshift.

5. **parameters** : mendefinisikan resource spesifik yang diinginkan ketika mendeploy aplikasi.

* 8b Resource

> Untuk membuat template diwajibkan mendefinisikan beberapa resource yaitu,
    1. Deployment
    2. Secret
    3. Service
    4. PersistentVolumeClaim

* 8c Resource Utama

> Resource utama yaitu,
    1. Deployment
    2. Service
    3. PersistentVolumeClaim

* 8d Resource POD

> Karena POD adalah unit paling dasar dari sebuah cluster, biasanya berisi satu atau lebih container POD yang berjalan. POD akan otomatis terbentuk ketika menjalankan sebuah deployment konfigurasi, karena POD dirancang untuk menjadi sementara yang berarti dapat dibuat atau dihancurkan kapan saja. Container POD memiliki network, penyimpanan dan proses yang sama, artinya POD dapat berkomunikasi antara POD satu dan POD lainnya secara realtime, dan semua POD dapat dihentikan dan dijalankan secara bersamaan.

* 8c Resource Secret

> Semua yang berhubungan dengan informasi sensitif wajib dimasukkan pada resource Secret seperti username, password, SSH key, dan Token.

* 8f Image Name

> pull image PostgreSQL ada pada bagian DeploymentConfig, yang image sebelumnya sudah dibuild pada bagian trigger. Pull image ini menggunakan automatic deploying ketika ada perubahan pada Image postgresql.