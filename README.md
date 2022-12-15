# Docked Rails

Setting up Rails for the first time with all the dependencies necessary can be daunting for beginners. Docked Rails uses a Rails CLI Docker image to ease the process of starting a new Rails application, working with that application during development, and running a basic server.

## Getting started

To use Docked Rails:

1. [Install Docker](https://www.docker.com/products/docker-desktop/)
1. Copy'n'paste to run in terminal:
   ```bash
   docker volume create ruby-bundle-cache
   alias rails='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle ghcr.io/rails/cli:latest'
   alias rails-server='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 ghcr.io/rails/cli:latest server -b 0.0.0.0'
   ```

(Note: On Windows, you first need to [install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) as well.)

Then you're ready to create your first Rails app:

1. `rails new my-first-rails-app`
1. `cd my-first-rails-app`
1. `rails generate scaffold post title:string body:text`
1. `rails db:migrate`
1. `rails-server`

That's it! You're running Rails on `http://localhost:3000`.

## Working with JavaScript-bundled Rails apps

The default for Rails 7 is to rely on importmaps for JavaScript, so you don't need to use any JavaScript build process. But if you know you need to work with React, or other heavy JavaScript front-end tooling, you should use Rails together with JS bundling. To setup, follow the same steps as above, then add the following alias:

```bash
alias rails-dev='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 --entrypoint bin/dev ghcr.io/rails/cli:latest'
```

Then create your app:

1. `rails new my-first-rails-app -j esbuild`
1. `cd my-first-rails-app`
1. `rails generate scaffold post title:string body:text`
1. `rails db:migrate`
1. Edit the Procfile.dev in the root of your project and change the first line to: `web: bin/rails server -p 3000 -b 0.0.0.0`
1. `rails-dev`

Now your development server will automatically compile any changes you make to the JavaScript in the project. Like with first setup, your server is running on `http://localhost:3000`.

## Mapping additional commands

In addition to the alias for rails and rails-server (or rails-dev), it can be helpful also to map bundle, rake, or even yarn to run via Docker:

```bash
alias bundle='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle --entrypoint bundle ghcr.io/rails/cli:latest'
alias rake='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle --entrypoint rake ghcr.io/rails/cli:latest'
alias rails-yarn='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle --entrypoint yarn ghcr.io/rails/cli:latest'
```

## Work to be done

1. Change the Procfile.dev in rails to bind to 0.0.0.0 by default?
