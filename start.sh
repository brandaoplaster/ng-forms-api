#!/usr/bin/env bash

bundle check || bundle install
bundle exec puma -C config/puma.rb