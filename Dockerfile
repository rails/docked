FROM ruby:3.1

# Ensure node.js 19 is available for apt-get
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips nodejs && npm install -g yarn

# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume
VOLUME /bundle
RUN gem install bundler && bundle config set --global path '/bundle'
RUN gem install rails

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Bundle bins should be available on the path
ENV PATH="/bundle/ruby/3.1.0/bin:${PATH}"
