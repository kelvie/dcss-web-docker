FROM alpine:latest as builder

MAINTAINER Kelvie Wong <kelvie@kelvie.ca>

WORKDIR /crawl
COPY ./crawl /crawl

# So git describe works, as it is part of the build
COPY ./.git /.git/


RUN apk add --no-cache make gcc g++ perl git python3 py3-yaml libpng-dev \
    libexecinfo-dev ncurses-dev

RUN cd /crawl/crawl-ref/source && \
    make -j4 WEBTILES=y EXTRA_LIBS=-lexecinfo

FROM python:3-alpine

WORKDIR /crawl
COPY --from=builder /crawl/crawl-ref/source/ /crawl/
COPY --from=builder /crawl/crawl-ref/settings/ /settings/
COPY --from=builder /crawl/crawl-ref/docs/ /docs/

RUN apk add --no-cache gcc musl-dev libexecinfo
RUN pip install -r /crawl/webserver/requirements/dev.py3.txt
RUN echo 'password_db = "/data/passwd.db3"' >> /crawl/webserver/config.py
RUN echo 'settings_db = "/data/settings.db3"' >> /crawl/webserver/config.py
RUN ln -s /data/rcs rcs
RUN ln -s /data/saves saves

EXPOSE 8080

CMD ["sh", "-c", "mkdir -p /data/saves; mkdir -p /data/rcs; exec python webserver/server.py"]
