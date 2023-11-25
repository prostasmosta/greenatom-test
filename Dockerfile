FROM ruby:3.2.2

RUN mkdir -p /greenatom
WORKDIR /greenatom

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]