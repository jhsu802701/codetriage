#!/bin/bash

# This script runs the app through code metrics.
# Violations will not stop the app from passing but will be flagged here.

echo '----------------------'
echo 'bundle install --quiet'
bundle install --quiet

# Checks for violations of the Ruby Style Guide, not recommended for legacy apps
echo '----------------------'
echo 'bundle exec rubocop -D'
bundle exec rubocop -D
