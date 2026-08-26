# Create my standard ssh configuration.
ssh_config_dir="$HOME/.ssh"
ssh_config="$ssh_config_dir/config"

# Don't make any changes when the config file already
# exists. This improves bash startup performance and
# avoids accidental loss of existing settings.
if [[ -s "$ssh_config" ]]; then
  if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
    echo "$ssh_config already exists."
  fi
  return
fi
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
  echo "Creating $ssh_config"
fi

# Ensure that the ssh config directory exists.
if [[ ! -d "$ssh_config_dir" ]]; then
  mkdir -p "$ssh_config_dir"
  chmod 700 "$ssh_config_dir"
fi

# Create the ssh config file.
echo "Host *" >>"$ssh_config"
echo "  AddKeysToAgent yes" >>"$ssh_config"
echo "" >>"$ssh_config"
echo "Host github.com" >>"$ssh_config"
echo "  RequestTTY no" >>"$ssh_config"
