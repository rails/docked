# Docked Rails

Setting up Rails for the first time with all the dependencies necessary can be daunting for beginners. Docked Rails attempts to flatten the onboarding curve by only requiring a working Docker installation in order to get started making a new Rails application, working with that application during development, and running a basic server. All based on pre-configured commands and dependencies living in a Docker image.

## Getting started

To use Docked Rails, follow these steps on macOS:

1. [Install Docker](https://www.docker.com/products/docker-desktop/)
1. Copy'n'paste to run in terminal: 
   ```bash
   docker volume create ruby-bundle-cache
   alias rails='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle dhh37/rails'
   alias rails-server='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 dhh37/rails server -b 0.0.0.0'
   ```

Or on Linux 64-bit:

1. [Install Docker](https://www.docker.com/products/docker-desktop/)
1. Copy'n'paste to run in terminal: 
   ```bash
   docker volume create ruby-bundle-cache
   alias rails='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle dhh37/rails-amd64'
   alias rails-server='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 dhh37/rails-amd64 server -b 0.0.0.0'
   ```

Or on Windows (with PowerShell):

1. [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
1. [Install Docker](https://www.docker.com/products/docker-desktop/)
1. Copy'n'paste to run in terminal: 
   ```bash
   docker volume create ruby-bundle-cache
   alias rails='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle dhh37/rails-amd64'
   alias rails-server='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 dhh37/rails-amd64 server -b 0.0.0.0'
   ```

Then you're ready to create your first Rails app:

1. `rails new my-first-rails-app`
1. `cd my-first-rails-app`
1. `rails generate scaffold post title:string body:text`
1. `rails db:migrate`
1. `rails-server`

That's it! You're running Rails on `http://localhost:3000`.

## Working with JavaScript-bundled Rails apps

The default for Rails 7 is to rely on importmaps for JavaScript, so you don't need to use any JavaScript build process. But if you know you need to work with React, or other heavy JavaScript front-end tooling, you should use Rails together with JS bundling. To setup, follow the same steps as above, then add the following alias:

On macOS:

1. `alias rails-dev='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 --entrypoint bin/dev dhh37/rails'`

Or on Linux 64-bit:

1. `alias rails-dev='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 --entrypoint bin/dev dhh37/rails-amd64'`

Or on Windows (with PowerShell):

1. `alias rails-dev='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 --entrypoint bin/dev dhh37/rails-amd64'`

Then create your app:

1. `rails new my-first-rails-app -j esbuild`
1. `cd my-first-rails-app`
1. `rails generate scaffold post title:string body:text`
1. `rails db:migrate`
1. Edit the Procfile.dev in the root of your project and change the first line to: `web: bin/rails server -p 3000 -b 0.0.0.0`
1. `rails-dev`

Now your development server will automatically compile any changes you make to the JavaScript in the project. Like with first setup, your server is running on `http://localhost:3000`.

## Mapping additional commands

In addition to the alias for rails and rails-server (or rails-dev), it can be helpful also to map bundle, rake, or even yarn to run via Docker.

Follow these steps on macOS:

```bash
alias bundle='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint bundle dhh37/rails'
alias rake='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint rake dhh37/rails'
alias yarn='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint yarn dhh37/rails'
```

Or on Linux 64-bit:

```bash
alias bundle='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint bundle dhh37/rails-amd64'
alias rake='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint rake dhh37/rails-amd64'
alias yarn='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint yarn dhh37/rails-amd64'
```

Or on Windows:

```bash
alias bundle='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint bundle dhh37/rails-amd64'
alias rake='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint rake dhh37/rails-amd64'
alias yarn='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle --entrypoint yarn dhh37/rails-amd64'
```


## Work to be done

1. Setup pipeline to compile single multi-platform image (so darwin and amd64 can live together)
2. Change the Procfile.dev in rails to bind to 0.0.0.0 by default?
