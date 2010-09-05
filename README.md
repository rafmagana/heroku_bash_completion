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

    $ heroku o[TAB] # => open

    $ heroku open --[TAB]
    --addons   --app      --remote   --stack    --timeout

    $ heroku db:[TAB]
    db:pull   db:push   db:reset

    $ heroku db:pull --[TAB]
    --chunksize            --disable-compression  --force                --resume-filename
    --debug                --filter               --indexes-last         --tables

    $ heroku rake[TAB] # => it will show all your rake tasks

    $ heroku rake db:mi[TAB] # => db:migrate

	$ heroku info --app my[TAB] # => myapp
	

## Known bugs

The heroku application completion is not working at 100%, it completes the app name but the line behaves in a weird way.

## ToDo

* Fix the completion of heroku app names
* Make it dynamic (right know all the commands an options are hard coded)