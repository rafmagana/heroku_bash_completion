# Heroku Gem Bash Completion

A set of function to autocomplete commands and options of the heroku gem.

## Installation

1. Copy the functions to your ~/.bash_profile, ~/.profile or ~/.bashrc file
2. Close all your bash sessions and open new ones or

    source ~/.bash_profile

3. Enjoy.

### Examples:

    $ heroku [TAB] # => It will show the full list of available commands

    $ heroku cr[TAB] # => create

    $ heroku i[TAB] # => info

    $ heroku addons --[TAB]
    --all       --app       --resource

    $ heroku addons:[TAB]
    add        attach     create     destroy    detach     docsdowngrade
    list       open       plans      remove     services   upgrade

    $ heroku rake[TAB] # => it will show all your rake tasks

    $ heroku rake db:mi[TAB] # => db:migrate

    $ heroku info --app my[TAB] # => myapp

## ToDo

* Make it dynamic (right know all the commands an options are hard coded)
