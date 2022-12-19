ARG RUBY_VERSION=3.1
ARG DISTRO_NAME=bullseye
ARG PROJECT_NODE_MAJOR=19

FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME

# Install dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    libvips \
    gnupg2 \
    curl \
  && apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_$PROJECT_NODE_MAJOR.x | bash -
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

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Bundle bins should be available on the path
ENV PATH="/bundle/ruby/3.1.0/bin:${PATH}"

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]
