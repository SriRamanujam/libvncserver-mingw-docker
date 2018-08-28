FROM fedora:28

ENV PKG_CONFIG_LIBDIR="/usr/i686-w64-mingw32/sys-root/mingw/lib/pkgconfig:/usr/i686-w64-mingw32/sys-root/mingw/share/pkgconfig"
ENV PATH=/usr/i686-w64-mingw32/bin:$PATH

RUN dnf install -y mingw32-gcc mingw32-gcc-c++ mingw32-binutils mingw32-headers
RUN dnf install -y cmake make git-core
RUN dnf install -y mingw32-libjpeg-turbo mingw32-SDL2 mingw32-zlib mingw32-libpng mingw32-gnutls

ARG COMMIT=79516a6aa3e875c8d9f4c83667076aa070fe5d6e
RUN curl -LO https://github.com/LibVNC/libvncserver/archive/${COMMIT}.tar.gz
RUN tar xzvf ${COMMIT}.tar.gz

COPY ./libvncserver-master-mingw32.patch /

RUN cd /libvncserver-${COMMIT}; git apply /libvncserver-master-mingw32.patch
RUN mkdir -p /libvncserver-${COMMIT}/build
RUN cd /libvncserver-${COMMIT}/build; cmake .. -DCMAKE_TOOLCHAIN_FILE=/usr/share/mingw/toolchain-mingw32.cmake -DWITH_TIGHTVNC_FILETRANSFER=OFF -DBUILD_SHARED_LIBS=ON && make -j4 && cp *.dll* /

