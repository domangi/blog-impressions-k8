FROM ruby:2.7.2-alpine
RUN apk add --update bash build-base nodejs sqlite-dev tzdata yarn mariadb-dev 
COPY ./ /app
WORKDIR /app

RUN rm -f /app/tmp/pids/server.pid
RUN gem install bundler:2.1.4
RUN bundle install

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

ENV PATH=/app:$PATH

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
