FROM meganii/dockerfile-mecab-python3:latest
MAINTAINER "meganii yuhei24@gmail.com"

# Install dependencies for tools
RUN apk add --update --no-cache libstdc++ lapack-dev && \
    apk add --update --no-cache \
        --virtual=.build-dependencies \
        g++ gfortran musl-dev \
        python3-dev && \
    ln -s locale.h /usr/include/xlocale.h && \
    pip install numpy && \
    pip install pandas && \
    pip install scipy && \
    pip install scikit-learn && \
    find /usr/lib/python3.*/ -name 'tests' -exec rm -r '{}' + && \
    rm /usr/include/xlocale.h && \
    rm -r /root/.cache && \
    apk del .build-dependencies

# Install Ruby
RUN apk add --update --no-cache ruby ruby-bundler

# Install Hugo
ENV HUGO_VERSION 0.26
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit

# Download and Install hugo
RUN mkdir /usr/local/hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/bin/hugo/
