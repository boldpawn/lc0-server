FROM    nvidia/opencl:devel-ubuntu16.04

COPY resources /

RUN ln -s /usr/lib/x86_64-linux-gnu/libdrm_amdgpu.so.1.0.0 /usr/lib/x86_64-linux-gnu/libdrm_amdgpu.so.1 && \
    ln -s /usr/lib/x86_64-linux-gnu/libdrm.so.2.4.0 /usr/lib/x86_64-linux-gnu/libdrm.so.2 && \
    ldconfig
RUN     apt update
RUN     apt install -y git gnupg
RUN     apt-get install tcputils
RUN     apt install -y ninja-build clang python3-pip
RUN     pip3 install --upgrade meson
RUN     git clone -b release/0.20 --recurse-submodules https://github.com/LeelaChessZero/lc0.git
RUN     cd /lc0 && ./build.sh
RUN     apt-get install wget
RUN wget -O /weights_run2_32194.pb http://lczero.org/get_network?sha=bd0909fe765bf4b385d0e583e6b7aaf784a447d43fbd63b6853b488032831b24
RUN    chmod 777 /lc0/build/release/lc0
RUN     chmod 666 /weights_run2_32194.pb
## Expose the mini-inetd port
EXPOSE  8080

CMD ["/usr/bin/mini-inetd", "-d", "8080", "/lc0/build/release/lc0", "go"]
