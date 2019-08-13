FROM ubuntu:16.04
RUN sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list &&  apt-get update && apt-get --no-install-recommends -y install autoconf automake bison build-essential bzip2 flex gawk gcc-multilib gettext gperf groff-base lib32stdc++6 lib32z1-dev libexpat1-dev libncurses5-dev libssl-dev libtool libxml-parser-perl patch perl pkg-config shtool texinfo unzip zlib1g-dev liblzo2-dev bc uuid-dev git sudo vim-common xsltproc cmake libltdl-dev gtk-doc-tools libtool-bin rsync && apt-get clean
RUN apt-get install -y curl && curl http://ftp.gnu.org/gnu/automake/automake-1.16.1.tar.xz -o /tmp/automake-1.16.1.tar.xz && tar xvf /tmp/automake-1.16.1.tar.xz -C /tmp && cd /tmp/automake-1.16.1 && ./configure --prefix=/usr && make install && cd /tmp/ && rm -rf /tmp/automake-1.16.1 /tmp/automake-1.16.1.tar.xz
RUN useradd -m -s /bin/bash cuckoo && adduser cuckoo sudo && sed -i 's/^%sudo.*/%sudo ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
RUN mkdir -p /media/ASUSWRT && ln -s /home/cuckoo/asuswrt-merlin.ng /media/ASUSWRT/asuswrt-merlin.ng && ln -sf bash /bin/sh
ENV LD_LIBRARY_PATH=/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/lib
ENV PATH=$PATH:/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin:/opt/toolchains/crosstools-aarch64-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin
USER cuckoo
WORKDIR /home/cuckoo/asuswrt-merlin.ng
