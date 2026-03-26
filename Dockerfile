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

EXPOSE 5000

CMD ["foreman", "start", "-f", "Procfile"]
