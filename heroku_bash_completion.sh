__heroku_complete_base()
{
  local current_word previous_word

  for alias in "${!__heroku_aliases[@]}"; do
    __heroku_commands_and_options[${alias}]=__heroku_commands_and_options[__heroku_aliases[${alias}]]
  done

  _get_comp_words_by_ref -n ':' -c current_word -p previous_word

  case "${previous_word}" in
    --app|-a)
      COMPREPLY=($(compgen -W '$(__heroku_apps)' -- ${current_word}))
      return 0
      ;;
    rake)
      COMPREPLY=($(compgen -W '$(__rake_tasks)' -- ${current_word}))
      __ltrim_colon_completions "$current_word"
      return 0
      ;;
  esac

  if [[ ${current_word} == -* ]]; then
    COMPREPLY=($(compgen -W '${__heroku_commands_and_options["${previous_word}"]}' -- ${current_word}))
    return 0
  fi

  COMPREPLY=($(compgen -W '${!__heroku_commands_and_options[@]}' -- ${current_word}))
  __ltrim_colon_completions "$current_word"
}

__heroku_apps()
{
  echo $(heroku list | awk '{{print $1}}' | grep -v '^=*$' | tr '\n' ' ')
}

__rake_tasks()
{
  echo $(rake -sT 2>/dev/null | awk '{{print $2}}')
}

complete -F __heroku_complete_base heroku

declare -A __heroku_commands_and_options=(
  ["addons"]="--all --app --resource "
  ["addons:attach"]="--as --confirm "
  ["addons:create"]="--name --as --confirm "
  ["addons:destroy"]="--force "
  ["addons:detach"]=""
  ["addons:docs"]=""
  ["addons:downgrade"]=""
  ["addons:open"]=""
  ["addons:plans"]=""
  ["addons:services"]=""
  ["addons:upgrade"]=""
  ["apps"]=""
  ["apps:create"]="--addons --buildpack --no-remote --remote --stack --region --locked --ssh-git "
  ["apps:destroy"]=""
  ["apps:info"]="--shell "
  ["apps:join"]="--app "
  ["apps:leave"]="--app "
  ["apps:lock"]=""
  ["apps:open"]=""
  ["apps:rename"]="--ssh-git "
  ["apps:unlock"]=""
  ["auth"]=""
  ["auth:login"]=""
  ["auth:logout"]=""
  ["auth:password"]=""
  ["auth:token"]=""
  ["auth:user"]=""
  ["auth:whoami"]=""
  ["config"]=""
  ["config:get"]="--shell "
  ["config:set"]=""
  ["config:unset"]=""
  ["domains"]=""
  ["domains:add"]=""
  ["domains:clear"]=""
  ["domains:remove"]=""
  ["logs"]=""
  ["ps"]=""
  ["ps:resize"]=""
  ["ps:restart"]=""
  ["ps:scale"]=""
  ["ps:stop"]=""
  ["ps:type"]=""
  ["releases"]=""
  ["releases:info"]="--shell "
  ["releases:rollback"]=""
  ["run"]="--exit-code "
  ["run:detached"]="--size --tail "
  ["run:rake"]=""
  ["sharing"]=""
  ["sharing:add"]=""
  ["sharing:remove"]=""
  ["sharing:transfer"]="--locked "
  ["accounts"]=""
  ["accounts:add"]="--auto "
  ["accounts:default"]=""
  ["accounts:remove"]=""
  ["accounts:set"]=""
  ["buildpacks"]=""
  ["buildpacks:add"]="--index "
  ["buildpacks:clear"]=""
  ["buildpacks:remove"]="--index "
  ["buildpacks:set"]="--index "
  ["certs"]=""
  ["certs:add"]="--bypass "
  ["certs:chain"]=""
  ["certs:generate"]="--city --selfsigned --keysize --owner --country --area --city --subject --now "
  ["certs:info"]="--endpoint "
  ["certs:key"]=""
  ["certs:remove"]="--endpoint "
  ["certs:rollback"]="--endpoint "
  ["certs:update"]="--bypass --endpoint "
  ["drains"]=""
  ["drains:add"]=""
  ["drains:remove"]=""
  ["features"]=""
  ["features:disable"]=""
  ["features:enable"]=""
  ["features:info"]=""
  ["fork"]="--region --skip-pg "
  ["git"]=""
  ["git:clone"]="--app --remote --ssh-git "
  ["git:remote"]="--app --remote --ssh-git "
  ["help"]="--addons "
  ["keys"]=""
  ["keys:add"]=""
  ["keys:clear"]=""
  ["keys:remove"]=""
  ["labs"]=""
  ["labs:disable"]=""
  ["labs:enable"]=""
  ["labs:info"]=""
  ["local"]=""
  ["maintenance"]=""
  ["maintenance:off"]=""
  ["maintenance:on"]=""
  ["members"]=""
  ["members:add"]="--role "
  ["members:remove"]=""
  ["members:set"]="--role "
  ["orgs"]=""
  ["orgs:open"]=""
  ["pg"]=""
  ["pg:backups"]="--quiet --at "
  ["pg:copy"]=""
  ["pg:credentials"]="--reset "
  ["pg:diagnose"]=""
  ["pg:info"]="--extended "
  ["pg:kill"]=""
  ["pg:killall"]=""
  ["pg:maintenance"]="--force "
  ["pg:promote"]=""
  ["pg:ps"]=""
  ["pg:psql"]="--command "
  ["pg:pull"]=""
  ["pg:push"]=""
  ["pg:reset"]=""
  ["pg:unfollow"]=""
  ["pg:upgrade"]=""
  ["pg:wait"]="--wait-interval "
  ["pgbackups"]=""
  ["pgbackups:capture"]="--expire "
  ["pgbackups:destroy"]=""
  ["pgbackups:restore"]=""
  ["pgbackups:transfer"]=""
  ["pgbackups:url"]=""
  ["plugins"]=""
  ["plugins:install"]=""
  ["plugins:link"]=""
  ["plugins:uninstall"]=""
  ["plugins:update"]=""
  ["redis"]=""
  ["regions"]=""
  ["stack"]=""
  ["stack:set"]=""
  ["status"]=""
  ["twofactor"]=""
  ["twofactor:disable"]=""
  ["twofactor:generate-recovery-codes"]=""
  ["update"]=""
  ["update:beta"]=""
  ["version"]=""
)

declare -A __heroku_aliases=(
  ["-h"]="help"
  ["--help"]="help"
  ["config:add"]="config:set"
  ["config:remove"]="config:unset"
  ["features:list"]="features"
  ["2fa"]="twofactor"
  ["2fa:disable"]="twofactor:disable"
  ["2fa:generate-recovery-codes"]="twofactor:generate_recovery_codes"
  ["dynos"]="ps:dynos"
  ["workers"]="ps:workers"
  ["restart"]="ps:restart"
  ["scale"]="ps:scale"
  ["stop"]="ps:stop"
  ["resize"]="ps:type"
  ["stack:migrate"]="stack:set"
  ["rake"]="run:rake"
  ["console"]="run:console"
  ["login"]="auth:login"
  ["logout"]="auth:logout"
  ["list"]="apps"
  ["info"]="apps:info"
  ["create"]="apps:create"
  ["rename"]="apps:rename"
  ["open"]="apps:open"
  ["destroy"]="apps:destroy"
  ["apps:delete"]="apps:destroy"
  ["join"]="apps:join"
  ["leave"]="apps:leave"
  ["lock"]="apps:lock"
  ["unlock"]="apps:unlock"
  ["upgrade"]="apps:upgrade"
  ["downgrade"]="apps:downgrade"
  ["rollback"]="releases:rollback"
  ["labs:list"]="labs"
  ["addons:list"]="addons:services"
  ["addons:add"]="addons:create"
  ["addons:remove"]="addons:destroy"
  ["clone"]="git:clone"
)
