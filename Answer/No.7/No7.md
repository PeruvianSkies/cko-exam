### Openshift S2I Process

Sebelum mendeploy sebuah aplikasi kedalam openshift biasanya saya menyiapkan beberapa kebutuhan file configurasi .yml bisa di bilang file ini adalah sebuah BuildConfig untuk mendeploy aplikasi kedalam openshift cluster.

Ketika menjalankan sebuah BuildConfig maka akan mengkontrol sebuah Builder Container yang terdiri dari Builder Image, Source Code dan Application Image.

Oleh sebab itu di dalam file tersebut terdapat beberapa konfigurasi seperti, Source Url tempat dimana kita menaruh source code, Image Registry tempat kita menaruh image registry yang akan di gunakan oleh pod, dan konfigurasi lainnya.

Didalam file tersebut bisa juga di taruh konfigurasi untuk mengkontrol automation build ketika terjadi perubahan pada source code(Trigger). Secara garis besar ketika ada perubahan pada source code maka kita tidak perlu lagi mendeploy ulang aplikasi tersebut, mulai dari deploying aplikasi, build image sampai push image kedalam registry.

Application Image ini yang akan digunakan oleh Application container untuk menyajikan sebuah aplikasi kepada user, maka di perlukan sebuah service untuk keperluan dari sisi Networking.
Ketika DeploymentConfig ini di jalankan di dalam file tersebut ada beberapa konfigurasi mulai dari sisi Service, berapa Replica pod yang di gunakan, sampai menerapkan AutoScale application.