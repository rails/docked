# First run:
# docker volume create ruby-bundle-cache

# Move to rails/rails or rails/rails-cli when possible
export DOCKED_RAILS_IMAGE='dhh37/rails'

alias docked-in-rails='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle'
alias rails='docked-in-rails $DOCKED_RAILS_IMAGE'
alias rails-server='docked-in-rails -p 3000:3000 $DOCKED_RAILS_IMAGE server -b 0.0.0.0'
alias rails-dev='docked-in-rails -p 3000:3000 --entrypoint bin/dev $DOCKED_RAILS_IMAGE'
alias bundle='docked-in-rails --entrypoint bundle $DOCKED_RAILS_IMAGE'
alias rake='docked-in-rails --entrypoint rake $DOCKED_RAILS_IMAGE'
alias yarn='docked-in-rails --entrypoint yarn $DOCKED_RAILS_IMAGE'
alias docked='docked-in-rails --entrypoint bash $DOCKED_RAILS_IMAGE'
