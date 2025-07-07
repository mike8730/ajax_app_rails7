#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# 最終手段：DBを完全にリセットする
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:schema:load