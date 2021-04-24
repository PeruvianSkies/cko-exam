### Push Registry & Backup image

* 2b quay.io
```
$ podman login quay.io -u=furqanpr -p=redhat123

$ podman tag localhost/myjava-app:8.5 quay.io/furqanpr/mycompany

$ podman push quay.io/furqanpr/mycompany
```

* 2c docker.io
```
$ podman login docker.io -u=furqanpr -p=redhat123

$ podman tag localhost/myjava-app:8.5 docker.io/furqanpr/mycompany

$ podman push docker.io/furqanpr/mycompany
```

* 2d myregistry.mycompany.com
```$ podman login myregistry.mycompany.com -u=furqanpr -p=redhat123

$ podman tag localhost/myjava-app:8.5 myregistry.mycompany.com/furqanpr/mycompany

$ podman push myregistry.mycompany.com/furqanpr/mycompany
```

* 2e backup image
```
$ podman save > myjava-app-8.5.tar.gzip localhost/myjava-app:8.5
```