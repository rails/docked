# Docked Rails CLI

Setting up Rails for the first time with all the dependencies necessary can be daunting for beginners. Docked Rails CLI uses a Docker image to make it much easier, requiring only Docker to be installed.

Install [Docker](https://www.docker.com/products/docker-desktop/) (and [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) on Windows). Then copy'n'paste into your terminal:

```bash
docker volume create ruby-bundle-cache
alias docked='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 ghcr.io/rails/cli'
```

Then create your Rails app:

```bash
docked rails new weblog
cd weblog
docked rails generate scaffold post title:string body:text
docked rails db:migrate
docked rails server
```

That's it! Your Rails app is running on `http://localhost:3000/posts`.

## Adding more aliases

If you'd like to have the standard Ruby and Rails bins available without writing `docked` before each command, you can add them as aliases:

```bash
alias rails='docked rails'
alias rails-dev='docked bin/dev'
alias bundle='docked bundle'
alias yarn='docked yarn'
alias rake='docked rake'
alias gem='docked gem'
```
