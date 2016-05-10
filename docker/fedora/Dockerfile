FROM fedora:23

# RUN apt-get update
RUN dnf install -y ruby glibc-devel gcc gcc-c++ make gmp-devel
RUN dnf install -y ruby-devel rpm-build rpmdevtools
RUN gem install fpm
RUN rpmbuild --help
RUN mkdir /src
WORKDIR /src

# Create new user - to prevent user id issues
RUN groupadd -g 1000 user
RUN useradd --home /src -u 1000 -g 1000 -M user
USER user
