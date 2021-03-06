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

RUN git clone https://github.com/golang/go --depth=1 --no-single-branch \
    && cd go/src/ \
    && git checkout dev.go2go \
    && ./make.bash


FROM debian:stretch

COPY --from=builder /tmp/go /opt/

WORKDIR /tmp

ENTRYPOINT ["/opt/bin/go"]

