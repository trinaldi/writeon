FROM ruby:3.3.0-alpine

ENV BUNDLER_VERSION=2.7.1

# Generic rails app
RUN apk update && apk add build-base tzdata

RUN gem install bundler -v 2.7.1
WORKDIR /app
ADD Gemfile .
ADD Gemfile.lock .
COPY . .
CMD [ "mv", ".env.docker", ".env"]
RUN bundle check || bundle install
RUN gem install foreman
CMD [ "foreman", "start", "-f", "Procfile" ]
