# Docked Rails

Setting up Rails for the first time with all the dependencies necessary can be daunting for beginners. Docked Rails uses a Rails CLI Docker image to make it much easier, requiring only Docker to be installed.

Install [Docker](https://www.docker.com/products/docker-desktop/) (and [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) on Windows). Then copy'n'paste into your terminal:

```bash
docker volume create ruby-bundle-cache
alias rails='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle ghcr.io/rails/cli'
alias rails-server='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 ghcr.io/rails/cli server -b 0.0.0.0'
alias rails-dev='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 --entrypoint bin/dev ghcr.io/rails/cli'
alias bundle='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle --entrypoint bundle ghcr.io/rails/cli'
alias rake='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle --entrypoint rake ghcr.io/rails/cli'
alias yarn='docker run --rm -it -v $PWD:/rails -v ruby-bundle-cache:/bundle --entrypoint yarn ghcr.io/rails/cli'
```

Then create your Rails app:

```bash
rails new weblog
cd weblog
rails generate scaffold post title:string body:text
rails db:migrate
rails-server
```

That's it! Your Rails app is running on `http://localhost:3000/posts`.

