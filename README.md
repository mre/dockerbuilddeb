# Docker deb package builders
Collection of [Docker](https://www.docker.com) images to build Debian/Ubuntu deb packages. All tested under Ubuntu 14.04LTS, but should work for any host that supports Docker.

- For each package a `Dockerfile` will build the OS image and create the deb package using [`checkinstall`](https://help.ubuntu.com/community/CheckInstall).
- The `extractdeb.sh` script will then:
	- run the image in a container
	- extract deb package back to the host file system
	- destroy the container

When installing package on target system remember that dependent packages will need to be installed manually, they are not brought over by the `checkinstall` process.

**Notes for Ubuntu 14.04LTS:** The Docker package in the Ubuntu repositories is (somewhat inconveniently) named `docker.io` due to an existing package clash. All build scripts assume you have symlinked the `docker.io` binary like so:

```sh
$ sudo apt-get install docker.io
$ ln -sf /usr/bin/docker.io /usr/local/bin/docker
```

Alternatively (and probably a better idea), you can install the latest stable [`docker-engine`](https://docs.docker.com/installation/ubuntulinux/) package from Docker's own repository using the following commands:

```sh
$ curl -sSL https://get.docker.com/ | sh
# add USERNAME to docker group - avoids the need for "sudo docker" calls.
$ sudo usermod -aG docker USERNAME
```

## Nginx
- **OS:** Ubuntu 14.04.3 LTS
- **Version:** 1.8.0
- **Configure:** [nginx/resource/configure.sh](nginx/resource/configure.sh)

Create and extract package:
```sh
$ ./build.sh
# waiting... as Docker builds image

$ ./extractdeb.sh
# package extract from container

$ ls -l nginx_1.8.0-1_amd64.deb
-rw-r--r-- 1 root root 187224 Jun  7 12:53 nginx_1.8.0-1_amd64.deb
```

Install on target system:
```sh
# should be no dependent packages needed - based off packaged configure.sh
$ sudo dpkg -i /path/to/nginx_1.8.0-1_amd64.deb
```

## PHP-FPM
- **OS:** Ubuntu 14.04.3 LTS
- **Version:** 7.0.0 (PHP-FPM and CLI)
- **Configure:** [phpfpm/resource/configure.sh](phpfpm/resource/configure.sh)

Create and extract package:
```sh
$ ./build.sh
# waiting... as Docker builds image

$ ./extractdeb.sh
# package extract from container

$ ls -l php_7.0.0-1_amd64.deb
-rw-r--r-- 1 root root 3774996 Dec  8 10:58 php_7.0.0-1_amd64.deb
```

Install on target system:
```sh
# install dependent packages - based off packaged configure.sh
$ sudo apt-get install libjpeg62
$ sudo dpkg -i /path/to/php_7.0.0-1_amd64.deb
```
