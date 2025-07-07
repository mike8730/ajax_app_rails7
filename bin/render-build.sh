#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# データベースの全セッションを切断し、強制的に DROP
psql $DATABASE_URL -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'ajaxapp_production_3ah3' AND pid <> pg_backend_pid();"
psql $DATABASE_URL -c "DROP DATABASE IF EXISTS ajaxapp_production_3ah3;"

# DB再作成
bundle exec rake db:create
bundle exec rake db:schema:load