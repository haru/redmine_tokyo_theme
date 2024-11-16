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
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake redmine:plugins:migrate

}

initdb

