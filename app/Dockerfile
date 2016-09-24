FROM ruby:2.3.0


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs sqlite3

RUN mkdir -p /home/deploy/app
WORKDIR /home/deploy/app
COPY . /home/deploy/app

RUN gem install bundler
RUN bundle install

EXPOSE 3000

CMD bin/rake db:create && bin/rake db:migrate && bin/rake db:reset && bin/rake db:seed && rails server -eproduction
