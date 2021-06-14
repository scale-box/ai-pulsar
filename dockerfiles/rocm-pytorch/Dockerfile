FROM openccf/base

FROM rocm/pytorch:rocm4.0.1_ubuntu18.04_py3.6_pytorch

LABEL maintainer="Kaichao Wu<kaichao@cnic.cn>"

RUN pip install opencv-python

# https://sigpyproc3.readthedocs.io/en/stable/install.html 
RUN \
    apt-get update && apt-get install -y libfftw3-dev && \
    pip install pysocks && export ALL_PROXY=socks5://127.0.0.1:1080 && \ 
    pip install git+https://github.com/FRBs/sigpyproc3

COPY --from=0 /app/sbin /app/sbin/

ENV LANG en_US.utf8
ENV LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib/python2.7/dist-packages/sigpyproc-0.1.1-py2.7-linux-x86_64.egg:$LD_LIBRARY_PATH
ENV PATH=/app/bin:/app/sbin:$PATH
ENV PYTHONPATH=/sigpyproc:$PYTHONPATH

ENV GRPC_SERVER=192.168.18.11:50051

ENTRYPOINT ["grpc-worker.sh"]
