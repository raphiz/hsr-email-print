FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install ruby ruby-dev build-essential libgmp-dev -y
RUN gem install fpm

RUN mkdir /src
WORKDIR /src

# Create new user - to prevent user id issues
RUN groupadd -g 1000 user
RUN useradd --home /src -u 1000 -g 1000 -M user
USER user
