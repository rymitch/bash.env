# Initialize ze.sh (an enhanced version of the z command)

# Optionally customize the command name. The default is "ze".
if [[ -n $_bash_env_plugins_ze_cmd ]]; then
  _ZE_CMD=$_bash_env_plugins_ze_cmd
fi

# Load the ze.sh utility.
source $dot_env_path/plugins/ze/ze.sh

# Optionally override "cd" to track directory changes.
if [[ "$_bash_env_plugins_ze_alias_cd" == "1" ]]; then
  alias cd=_ze_cd
fi
