#
# Ruby 2.3.0 via rbenv 
#

# Pull base image.
FROM ubuntu:16.04    

# Install some dependencies
RUN apt-get update
RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties

# Install rbenv to install ruby
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# Install rbenv plugin: ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/rbenv-gem-rehash
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH $RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install ruby
RUN rbenv install 2.3.0
RUN rbenv local 2.3.0
RUN rbenv global 2.3.0

RUN gem install bundler

## Install Rails
RUN apt-get install -y software-properties-common
#RUN add-apt-repository ppa:chris-lea/node.js
#RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
#RUN apt-get update

RUN apt-get install -y nodejs

## Finally, install Rails
RUN gem install rails -v 4.2.6
RUN rbenv rehash

# Define working directory
WORKDIR /var/www/

VOLUME /var/www/

CMD ["/bin/bash"]

# Expose ports
EXPOSE 3000
