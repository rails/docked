ARG RUBY_VERSION=3.1
ARG NODE_VERSION=19

FROM node:${NODE_VERSION}-alpine AS node

FROM ruby:${RUBY_VERSION}-alpine

# Install dependencies
RUN apk --no-cache add \
      build-base \
      git \
      libressl-dev \
      libxml2-dev \
      tzdata

# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/3.1.0/bin:${PATH}"

# Install Rails
RUN gem install rails

# Copy node binaries
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]
