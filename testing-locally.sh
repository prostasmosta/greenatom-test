#!/usr/bin/env bash

echo "---- start tests ----"

bash -c 'db_name=temp_$(date +%s) &&
echo $db_name &&
RAILS_ENV=test DB_NAME=$db_name rails db:create &&
RAILS_ENV=test DB_NAME=$db_name rails db:migrate --trace
RAILS_ENV=test DB_NAME=$db_name bundle exec rspec ./spec
RAILS_ENV=test DB_NAME=$db_name rails db:drop'
