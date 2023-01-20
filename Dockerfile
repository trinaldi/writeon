FROM ruby:3.0.4-alpine

ENV BUNDLER_VERSION=2.3.11

# Generic rails app
RUN apk update && apk add build-base tzdata

RUN gem install bundler -v 2.3.11
WORKDIR /app
ADD Gemfile .
ADD Gemfile.lock .
COPY . .
CMD [ "mv", ".env.docker", ".env"]
RUN bundle check || bundle install
RUN gem install foreman
CMD [ "foreman", "start", "-f", "Procfile" ]
