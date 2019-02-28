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
                          python3\
                          locales\
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

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

