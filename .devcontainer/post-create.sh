#!/bin/sh
cd $REDMINE_ROOT

if [ -d .git.sv ]
then
    mv -s .git.sv .git
    git pull
    rm .git
fi

ln -s /workspaces/${THEME_NAME} themes/${PLUGIN_NAME}


bundle install 

initdb() {
    rm -r db/schema.rb
    if [ $DB != "sqlite3" ]
    then
        bundle exec rake db:create
    fi
    bundle exec rake db:migrate
    bundle exec rake redmine:plugins:migrate

    if [ $DB != "sqlite3" ]
    then
        bundle exec rake db:drop RAILS_ENV=test
        bundle exec rake db:create RAILS_ENV=test
    fi

    bundle exec rake db:migrate RAILS_ENV=test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=test
}

export DB=mysql2
export DB_NAME=redmine
export DB_USERNAME=root
export DB_PASSWORD=root
export DB_HOST=mysql
export DB_PORT=3306

initdb

export DB=postgresql
export DB_NAME=redmine
export DB_USERNAME=postgres
export DB_PASSWORD=postgres
export DB_HOST=postgres
export DB_PORT=5432

initdb

rm -f db/redmine.sqlite3_test
export DB=sqlite3
initdb

curl -fsSL https://claude.ai/install.sh | bash
