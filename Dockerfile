FROM ruby:3.1

# Ensure node.js 19 is available for apt-get
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips nodejs && npm install -g yarn

# Mount $PWD to this workdir
WORKDIR /rails

# Install Rails
RUN gem install rails

# Ensure gems are installed on a persistent volume and available as bins
# the folder is world writable to let the default user write install the gems
RUN chmod -R ugo+rwt /usr/local/bundle
VOLUME /usr/local/bundle

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]
