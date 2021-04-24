## Fungsi :

1. **FROM** : perintah didalam dockerfile untuk membangun image baru yang akan di buat menggunakan image dasar yang sesuai dengan kebutuhan.

2. **MAINTAINER** : perintah didalam dockerfile untuk mencantumkan siapa yang mengelola image tersebut, biasanya akan dicantumkan nama dan email agar mudah untuk dihubungi ketika terjadi masalah dengan image yg dibangun.

3. **RUN**  : perintah didalam dockerfile untuk menentukan instruksi yang akan dieksekusi selama proses membangun image.

4. **WORKDIR**  : perintah didalam dockerfile untuk menetapkan direktori tempat kerja pada saat image dibangun.

5. **ADD**  : perintah didalam dockerfile untuk menambahkan suatu file atau direktori dari sumber yang di tentukan ke tujuan yang di tentukan pada suatu image, sumbernya bisa berasal dari direktori local atau url, jika sumbernya berupa arsip .tar local makan secara otomatis akan di bongkar di dalam image.

6. **ENV**  : perintah didalam dockerfile untuk mendefinisikan suatu environment variable yang memungkinkan pada sebuah image yang dibangun.

7. **EXPOSE**   : perintah didalam dockerfile untuk mendefinisikan port listens yg akan digunakan oleh container pada saat runtime.

8. **USER**   : perintah didalam dockerfile untuk menetapkan nama user atau UID yang akan digunakan ketika menjalankan instruksi selanjutnya.

9. **CMD**  : perintah didalam dockerfile untuk menentukan perintah yg akan di eksekusi ketika akan menjalankan sebuah container, perintah ini hanya dapat digunakan satu instruksi di dalam sebuah image.