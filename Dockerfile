FROM debian:stretch as builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y \
    && apt install -y wget gcc make git

WORKDIR /tmp

RUN wget -q https://dl.google.com/go/go1.4-bootstrap-20171003.tar.gz -O gobootstrap.tar.gz \
    && tar xfvz gobootstrap.tar.gz \
    && mv go gobootstrap \
    && cd gobootstrap/src/ \
    && ./make.bash \
    && cd /tmp

ENV GOROOT_BOOTSTRAP=/tmp/gobootstrap

RUN git clone https://github.com/golang/go -b dev.go2go --depth=1 \
    && cd go/src/ \
    && ./make.bash


FROM debian:stretch

COPY --from=builder /tmp/go /opt/

RUN mkdir -p /home/gopher/go /home/gopher/.cache \
    && chown -R 1000:1000 /home/gopher

WORKDIR /home/gopher/go

USER 1000:1000

ENV GOCACHE /home/gopher/.cache

ENTRYPOINT ["/opt/bin/go"]

