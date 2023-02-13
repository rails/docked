ARG RUBY_VERSION=3.2.0
ARG VARIANT=jemalloc-bullseye-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

# Ensure node.js 19 is available for apt-get
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -

# Install dependencies
RUN apt-get update -qq \
  && apt-get install -qq -y build-essential libvips nodejs \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists \
  && rm -rf /var/cache/apt \
  && npm install -g yarn

# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/3.2.0/bin:${PATH}"
ENV RUBY_YJIT_ENABLE true

# Install Rails
RUN gem install rails

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]
