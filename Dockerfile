FROM ruby:2.6.3-slim-buster

RUN apt-get update -qq && \
    apt-get install -y build-essential && \
    gem update --system && \
    gem install bundler:2.2.0

ENV APP_HOME ../private_records
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD . $APP_HOME

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
