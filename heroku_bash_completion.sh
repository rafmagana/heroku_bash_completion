__heroku_complete_base()
{
    local current_word previous_word
	local general_commands app_commands all_commands 
	local app_options db_options
	
    COMPREPLY=()

    current_word="${COMP_WORDS[COMP_CWORD]}"
    previous_word="${COMP_WORDS[COMP_CWORD-1]}"
	
	general_commands="help version list create keys keys:add keys:remove keys:clear"
	app_commands="info open rename dynos workers sharing:add sharing:remove sharing:transfer domains:add domains:remove domains:clear ssl:add ssl:remove rake console restart logs logs:cron maintenance:on maintenance:off config config:add config:remove config:clear stack stack:migrate bundles bundles:capture bundles:download bundles:download bundles:animate bundles:destroy addons addons:info addons:add addons:remove addons:clear destroy plugins plugins:install plugins:uninstall"
	db_commands="db:pull db:push db:reset"
	all_commands="${general_commands} ${app_commands} ${db_commands}"
	
	app_options="--app --remote --stack --timeout --addons"
	db_options="--force --chunksize --filter --tables --disable-compression --resume-filename --indexes-last --debug"
	
	case "${previous_word}" in
		--app)
			COMPREPLY=($(compgen -W "$(__heroku_apps)" -- ${current_word}))
			return 0
			;;
		rake)
			COMPREPLY=($(compgen -W "$(__rake_tasks)" -- ${current_word}))
			return 0
			;;
	esac
	
	if [[ $app_commands == *$previous_word* ]]; then
		COMPREPLY=($(compgen -W "${app_options}" -- ${current_word}))
		return 0
	fi

	if [[ $db_commands == *$previous_word* ]]; then
		COMPREPLY=($(compgen -W "${db_options}" -- ${current_word}))
		return 0
	fi
	
	if [[ ${current_word} == -* ]] ; then
		COMPREPLY=($(compgen -W "${app_options}" -- ${current_word}))
		return 0
    fi
	
	COMPREPLY=($(compgen -W "${all_commands}" -- ${current_word}))
}

__heroku_apps()
{
	echo `heroku list | awk '{{print $1}}' | tr '\n' ' '`
}

__rake_tasks()
{
	echo `rake -s -T 2>/dev/null | awk '{{print $2}}'`
}

complete -F __heroku_complete_base heroku