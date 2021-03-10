FROM ruby:2.6.3-slim-buster

ENV BUNDLER_VERSION=2.2.0
ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

RUN apt-get update -qq && \
    apt-get install -y build-essential && \
    gem update --system && \
    gem install bundler:$BUNDLER_VERSION

ENV APP_HOME /application
#RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle config set without 'development test' && bundle install

ADD . $APP_HOME

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
