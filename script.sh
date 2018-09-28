#!/bin/sh
rails db:migrate
bundle exec puma -C config/puma.rb
