FROM ruby

# Ensure node.js 18 LTS is available for apt-get
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips nodejs && npm install -g yarn

WORKDIR /rails

VOLUME ["/bundle"]

# Ensure gems are installed on a persistent volume
RUN gem install bundler && bundle config set --global path '/bundle'

RUN gem install rails

ENTRYPOINT ["rails"]
