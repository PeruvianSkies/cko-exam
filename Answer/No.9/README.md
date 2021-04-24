### Troubleshooting Containerized Applications

> Sebelumnya dikarenakan saya belum pernah membuat sebuah cluster menggunakan openshift, maka saya akan menjelaskan Troubleshooting kubernetes cluster. (menggunakan command line kubernetes)

> Trouble pada sebuah cluster di pengaruhi oleh banyak hal, tetapi ketika ada Trouble lebih baik kita check terlebih dahulu apa yang menyebabkan Trouble itu terjadi.

1. Pastikan nodes pada cluster berjalan dengan semestinya.

```
$ kubectl get nodes
```
```
NAME                       STATUS   ROLES    AGE    VERSION
ap-southeast-5.127.0.0.2   Ready    <none>   298d   v1.18.8-aliyun.1
ap-southeast-5.127.0.0.3   Ready    <none>   298d   v1.18.8-aliyun.1
ap-southeast-5.127.0.0.4   Ready    <none>   298d   v1.18.8-aliyun.1
```
> Jika ingin melihat informasi yang lebih detail mengenai cluster bisa menjalankan perintah:

```
$ kubectl cluster-info dump
```

2. Pastikan semua namespace berstatus Active

```
$ kubectl get ns
```

```
NAME                   STATUS   AGE
testingns              Active   296d
default                Active   298d
kube-node-lease        Active   298d
kube-public            Active   298d
kube-system            Active   298d
kubernetes-dashboard   Active   297d
testingdb              Active   296d
production             Active   296d
rabbitmq-system        Active   15d
staging                Active   296d
```

3. Pastikan semua pods berstatus `Running` dan TIDAK BERSTATUS `CrashLoopBackOff`.

```
$ kubectl -n testingns get pods 
```
```
NAME                             READY   STATUS      RESTARTS   AGE
access-service-test-dj5dw        1/1     Running     0          8d
access-service-test-pd4zj        1/1     Running     0          8d
access-service-test-xq5z7        1/1     Running     0          8d
alfa-cronjob-test-qrgwr          0/1     Completed   0          2d22h
alfa-cronjob-test-htnc9          0/1     Completed   0          46h
alfa-cronjob-test-jcjhc          0/1     Completed   0          22h
alfagateway-service-test-b586d   1/1     Running     0          8d
alfamind-portal-web-test-lnxlb   1/1     Running     0          3d8h
application-service-test-8nqrw   1/1     Running     0          8d
article-service-test-5vr6v       1/1     Running     0          4d7h
auth-service-test-sgtzl          1/1     Running     3          4d2h
banner-service-test-g2hwv        1/1     Running     0          8d
comment-service-test-b2hx8       1/1     Running     0          171d
datastorage-service-test-vzbvb   1/1     Running     0          8d
email-service-test-mxdxp         1/1     Running     0          8d
following-service-test-j9djm     1/1     Running     0          171d
liking-service-test-mtw4d        1/1     Running     0          171d
location-service-test-hmr94      1/1     Running     0          8d
masterdata-service-test-xvstv    1/1     Running     0          8d
messaging-service-test-xhc8k     1/1     Running     0          8d
platform-service-test-wzxd5      1/1     Running     0          3d7h
product-service-test-tjvz8       1/1     Running     0          8d
```

4. Jika ada salah satu pods yang berstatus `CrashLoopBackOff` maka cek dahulu logs dari pods tersebut.

```
NAME                               READY   STATUS             RESTARTS   AGE
article-service-testing-75sr5       0/1    CrashLoopBackOff   530        2d7h
```

```
$ kubectl -n testingns logs article-service-testing-75sr5
```

```
> article@1.0.0 start /app
> NODE_ENV=production node index.js


█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
█                                                                    █                                                                                                                          
█     TESTING PLATFORM ~ ARTICLE SERVICE                             █                                                                                                                          
█                                                                    █                                                                                                                          
█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█                                                                                                                          

Listening on article-service.production:8080
Error connecting to mongodb://testdb:1234@mongo.testingdb:27017/article?authSource=admin
/app/app.js:28
  throw err;
  ^

MongooseServerSelectionError: connection timed out
    at NativeConnection.Connection.openUri (/app/node_modules/mongoose/lib/connection.js:845:32)
    at _mongoose._promiseOrCallback.cb (/app/node_modules/mongoose/lib/index.js:348:10)
    at Promise (/app/node_modules/mongoose/lib/helpers/promiseOrCallback.js:31:5)
    at new Promise (<anonymous>)
    at promiseOrCallback (/app/node_modules/mongoose/lib/helpers/promiseOrCallback.js:30:10)
    at Mongoose._promiseOrCallback (/app/node_modules/mongoose/lib/index.js:1152:10)
    at Mongoose.connect (/app/node_modules/mongoose/lib/index.js:347:20)
    at Object.<anonymous> (/app/app.js:23:10)
    at Module._compile (internal/modules/cjs/loader.js:778:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:789:10)
    at Module.load (internal/modules/cjs/loader.js:653:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:593:12)
    at Function.Module._load (internal/modules/cjs/loader.js:585:3)
    at Module.require (internal/modules/cjs/loader.js:692:17)
    at require (internal/modules/cjs/helpers.js:25:18)
    at Object.<anonymous> (/app/index.js:3:13)
    at Module._compile (internal/modules/cjs/loader.js:778:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:789:10)
    at Module.load (internal/modules/cjs/loader.js:653:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:593:12)
    at Function.Module._load (internal/modules/cjs/loader.js:585:3)
    at Function.Module.runMain (internal/modules/cjs/loader.js:831:12)
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! article@1.0.0 start: `NODE_ENV=production node index.js`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the article@1.0.0 start script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
npm ERR!     /root/.npm/_logs/2021-04-24T14_55_32_206Z-debug.log
```

> Pada contoh di atas dapat di pastikan bahwa service pod tersebut tidak bisa konek ke service mongoDB. Maka kita harus mengecek lebih dalam hal tersebut, apakah service MongoDB down atau ada salah konfigurasi baik pada pod article atau pod MongoDB tersebut.

> Demikian sedikit contoh yang dapat saya berikan ketika Troubleshooting terhadap cluster, secara garis besar kita tidak dapat langsung menyimpulkan apa penyebab trouble di dalam cluster tanpa mengecek terlebih dahulu semua hal yang ada pada cluster.

### Extras
1. Cek Services

```
$ kubectl get services
```

2. Cek Deployment

```
$ kubectl get deployment
```

3. Cek Replicaset

```
$ kubectl get replicasets.apps
```
4. Cek PersistentVolume

```
$ kubectl get persistentvolume
```
