FROM archlinux:base-devel
LABEL maintainer="GeoPD <geoemmanuelpd2001@gmail.com>"
ENV LANG=en_US.UTF-8

RUN pacman -Syyu --noconfirm \
    && pacman -S --noconfirm base-devel bc ccache clang cmake cpio git inetutils jdk8-openjdk lld llvm lzip multilib-devel nano patchelf python2 python3 rclone svn xmlto z3 zip \
    && curl -fsSL "https://repo.archlinuxcn.org/x86_64/glibc-linux4-2.33-4-x86_64.pkg.tar.zst" | bsdtar -C / -xvf - &>/dev/null \
    && PATH=/usr/bin/core_perl:$PATH \
    && ln -s /usr/lib/libz3.so /usr/lib/libz3.so.4

# Setup Toolchains
RUN export GCC_DIR=/tmp/gcc \
    && git clone --depth=1 https://github.com/mvaisakh/gcc-arm -b gcc-master $GCC_DIR/gcc32 \
    && git clone --depth=1 https://github.com/mvaisakh/gcc-arm64 -b gcc-master $GCC_DIR/gcc64

VOLUME ["/tmp/gcc"]
ENTRYPOINT ["/bin/bash"]
