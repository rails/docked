ARG RUBY_VERSION=3.1

FROM ruby:$RUBY_VERSION-slim-bullseye

# Install dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    libvips \
    gnupg2 \
    curl \
  && apt-get clean

ARG NODE_MAJOR=19
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -\
  && apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    nodejs \
    && npm install -g yarn \
    && apt-get clean

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

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]
