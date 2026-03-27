FROM ruby:3.3.0-alpine

RUN apk add --no-cache \
  build-base \
  git \
  tzdata \
  nodejs \
  yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN mkdir -p tmp/pids tmp/cache tmp/sockets log

EXPOSE 3000

CMD bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}
