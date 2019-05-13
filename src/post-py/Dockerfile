FROM frolvlad/alpine-python3 as base
# FROM alpine:3.9 as base
#
# RUN apk add --no-cache python3 && \
#     python3 -m ensurepip && \
#     rm -r /usr/lib/python*/ensurepip && \
#     pip3 install --upgrade pip setuptools && \
#     if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
#     if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
#     rm -rf /root/.cache && \
#     rm -rf /var/cache/apk/*

LABEL version="2.0"
LABEL maintainer="s.kushnerchuk@frontol.ru"

FROM base as builder

WORKDIR /app
COPY requirements.txt /app

# RUN apk update \
#     && apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev \
#     && pip install --no-cache-dir --install-option="--prefix=/install" -r requirements.txt \
#     && apk del --no-cache --purge .build-deps \
#     && rm -rf /var/cache/apk/*

RUN apk update \
    && apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del --no-cache --purge .build-deps \
    && rm -rf /var/cache/apk/*
# FROM base

# COPY --from=builder /install /usr/lib

COPY . /app
WORKDIR /app


ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
