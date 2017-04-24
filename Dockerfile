#
# IMPORTANT:
#
# The following docker command is required to be run to enable the arm emulation in the host
# kernel. This must be run once after a reboot to enable docker to use the armhf images.
#
# docker run --rm --privileged multiarch/qemu-user-static:register --reset
#
#from multiarch/alpine:x86_64-v3.3
from multiarch/alpine:armhf-edge
RUN echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    apk update; \
    apk add alpine-keys; \
    apk add bash automake make git rsync tar python py-setuptools \
       gcc g++ binutils libgcc libstdc++ libgfortran \
       readline readline-dev python-dev dev86 \
       m4 libtool autoconf swig fuse fuse-dev perl-dev \
       linux-headers libftdi1-dev; \
    cd /; \
    git clone https://git.code.sf.net/p/owfs/code owfs-code;
    

ENTRYPOINT cd owfs-code; \
    git pull; \
    ./bootstrap; \
    ./configure; \
    make; \
    make install
