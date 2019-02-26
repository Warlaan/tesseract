#
# Dockerfile for tesseract
#

FROM debian:stretch

RUN set -xe \
    && apt-get update \
    && apt-get install -y automake \
                          g++ \
                          git \
                          libtool \
                          libleptonica-dev \
                          make \
                          pkg-config\
    && git clone https://github.com/tesseract-ocr/tesseract.git \
        && cd tesseract \
        && ./autogen.sh \
        && ./configure \
        && make install \
        && ldconfig \
        && cd .. \
    && git clone https://github.com/tesseract-ocr/tessdata.git \
        && cd tessdata \
        && mv * /usr/local/share/tessdata/ \
        && cd .. \
    && rm -rf tesseract tessdata /var/cache/apk/*

