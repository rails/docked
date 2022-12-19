FROM ruby:slim-bullseye

# Install dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    libvips \
    gnupg2 \
    curl \
  && apt-get clean

ARG PROJECT_NODE_MAJOR
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
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

ENTRYPOINT ["rails"]
