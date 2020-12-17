 FROM ubuntu:latest AS build

ARG RENPY_VERSION
ENV RENPY_VERSION=${RENPY_VERSION:-"7.3.5"} \
    RENPY_DIR="/renpy"

RUN apt-get -y update \
    && apt-get -y --no-install-recommends install \
        procps \
        bzip2 \
        ca-certificates \
        curl \
        tar \
        unzip \
        wget \
    && rm -Rf /var/lib/apt/lists/* \
    && wget -O renpy-$RENPY_VERSION-sdk.tar.bz2 https://www.renpy.org/dl/$RENPY_VERSION/renpy-$RENPY_VERSION-sdk.tar.bz2 \
    && tar -xf renpy-$RENPY_VERSION-sdk.tar.bz2 \
    && rm renpy-$RENPY_VERSION-sdk.tar.bz2 \
    && mv renpy-$RENPY_VERSION-sdk $RENPY_DIR \
    && rm -rd $RENPY_DIR/the_question $RENPY_DIR/tutorial

FROM ubuntu:latest
ENV SDL_AUDIODRIVER="dummy" \
    SDL_VIDEODRIVER="dummy" \
    RENPY_DIR="/renpy"

COPY --from=0 $RENPY_DIR $RENPY_DIR
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "sh", "entrypoint.sh" ]
