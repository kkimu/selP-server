FROM ruby:2.3.0


RUN apt-get update -qq && apt-get install -y build-essential nodejs sqlite3

RUN mkdir -p /home/deploy/app
WORKDIR /home/deploy/app
COPY Gemfile /home/deploy/app
COPY Gemfile.lock /home/deploy/app

RUN gem install bundler && bundle install --path vendor/bundle

COPY . /home/deploy/app
EXPOSE 3000

CMD bin/rake db:migrate && bin/rake db:seed && rails server -b 0.0.0.0 -e development
