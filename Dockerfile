FROM ubuntu:latest

ARG RENPY_VERSION
ENV SDL_AUDIODRIVER="dummy" \
    SDL_VIDEODRIVER="dummy" \
    RENPY_DIR="/renpy" \
    RENPY_VERSION=${RENPY_VERSION:-"7.3.5"}

RUN apt-get -y update \
    && apt-get -y --no-install-recommends install \
        procps \
        bzip2 \
        ca-certificates \
        curl \
        tar \
        unzip \
        zip \
        wget \
    && rm -Rf /var/lib/apt/lists/* \
    && wget -O renpy-$RENPY_VERSION-sdk.tar.bz2 https://www.renpy.org/dl/$RENPY_VERSION/renpy-$RENPY_VERSION-sdk.tar.bz2 \
    && tar -xf renpy-$RENPY_VERSION-sdk.tar.bz2 \
    && rm renpy-$RENPY_VERSION-sdk.tar.bz2 \
    && mv renpy-$RENPY_VERSION-sdk $RENPY_DIR \
    && wget -O /web.zip https://www.renpy.org/dl/$RENPY_VERSION/renpy-$RENPY_VERSION-web.zip \
    && unzip /web.zip \
    && rm /web.zip

COPY repackage.sh $RENPY_DIR/repackage.sh