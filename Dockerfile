FROM ruby:4.0.5-alpine

# Removido nodejs e yarn já que é uma API pura
RUN apk add --no-cache \
  build-base \
  git \
  tzdata \
  yaml \
  yaml-dev \
  coreutils

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 4.0.13

RUN bundle install

COPY . .

RUN mkdir -p tmp/pids tmp/cache tmp/sockets log

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
