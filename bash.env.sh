# Exit unless we are a login shell
[[ -z "$PS1" ]] && return

export dot_env_path="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Allow custom directory to exist outside of project root.
export dot_env_custom="${dot_env_custom:=${dot_env_path}/custom}"

# Display .env version
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
  source "$dot_env_path/global/global_colors.sh"
  DOT_ENV_VERSION=$(cat "$dot_env_path/VERSION")
  echo_info ".env v$DOT_ENV_VERSION - https://github.com/midwire/bash.env"
fi

# Determine OS
dot_env_os=$(uname)
if [[ "$dot_env_os" =~ ^CYGWIN_NT* || "$dot_env_os" =~ ^MINGW64_NT* ]]; then
  dot_env_os=Windows
elif [[ "$dot_env_os" != "Darwin" && "$dot_env_os" != "Linux" && "$dot_env_os" != "SunOS" ]]; then
  echo_error "Sorry, bash.env does not support your platform: '$dot_env_os'"
  return 1
fi
dot_env_os_dir=$dot_env_path/os/$dot_env_os

# Check for updates
if [[ "$ENABLE_AUTO_UPDATE" == "true" ]]; then
  $dot_env_path/bin/check_for_update.sh
fi

# Make sure globals are sourced before OS specifics
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
  echo "Sourcing Global Environment"
fi
. $dot_env_path/global/global.sh

# Source managed config file if it exists (overrides plugins/theme from .bashrc)
if [[ -r "$HOME/.bash.env.conf" ]]; then
  . "$HOME/.bash.env.conf"
fi

# Source plugins which may be defined in ~/.bashrc, an OS, or Host specific file
. $dot_env_path/plugins/plugins.sh

# Now source OS specifics
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
  echo "Sourcing $dot_env_os Environment"
fi
for i in $dot_env_os_dir/*.sh ; do
  if [ -r "$i" ]; then
    . $i
  fi
done

# Source Host specifics if there are any for the current host
if [[ ! -z "$HOSTNAME" ]]; then
  HOST_DIR=$dot_env_path/host/$HOSTNAME
  if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
    echo "Sourcing '$HOSTNAME' Environment"
  fi
  for i in $HOST_DIR/*.sh ; do
    if [ -r "$i" ]; then
      . $i
    fi
  done
fi

unset i

# Source theme which may be defined in ~/.bashrc, an OS, or Host specific file
. $dot_env_path/themes/load_theme.sh
