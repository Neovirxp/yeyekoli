FROM alpine:3.8

RUN apk --no-cache add -U musl musl-dev ncurses-libs bash build-base make

COPY ./src/_build/prod/rel /rel
RUN ln -s /lib/libcrypto.so.43 /lib/libcrypto.so.42
WORKDIR /rel

CMD REPLACE_OS_VARS=true /rel/legavi/bin/legavi foreground
