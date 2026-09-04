#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Run database migrations and seed data automatically on deploy
bundle exec rails db:migrate
bundle exec rails db:seed