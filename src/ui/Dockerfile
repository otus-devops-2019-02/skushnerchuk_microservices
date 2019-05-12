FROM alpine:3.7

LABEL version="2.0"
LABEL maintainer="s.kushnerchuk@frontol.ru"

ENV APP_DIR /app
WORKDIR $APP_DIR

COPY Gemfile* $APP_DIR/
RUN apk add --update --no-cache --virtual build_deps gcc make musl-dev \
        ruby ruby-dev ruby-bundler ruby-rdoc ruby-irb \
    && gem install bundler \
    && bundle install --no-cache \
    && bundle clean --force \
    && apk del build_deps \
    && apk add --no-cache ruby-rdoc

COPY . $APP_DIR

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
