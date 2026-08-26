# Create my standard git configuration.
git_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
git_config="$git_config_dir/git/config"

# Don't make any changes when the config file already
# exists. This improves bash startup performance and
# avoids accidental loss of existing settings.
if [[ -s "$git_config" ]]; then
  if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
    echo "$git_config already exists."
  fi
  return
fi
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
  echo "Creating $git_config"
fi

# Ensure that the git config directory exists.
mkdir -p "$git_config_dir/git"

# Create the git config file. Note that local
# overrides can be stored in ~/.gitconfig, which
# is never modified by this script.
git config set --file "$git_config" alias.checokut 'checkout'
git config set --file "$git_config" alias.co 'checkout'
git config set --file "$git_config" alias.dm 'difftool --dir-diff --no-symlinks'
git config set --file "$git_config" alias.fix '!f() { git commit --fixup :/^$1; }; f'
git config set --file "$git_config" alias.l 'log --graph --format=compactgraph --max-count=20'
git config set --file "$git_config" alias.la 'log --graph --format=compactgraph --all'
git config set --file "$git_config" alias.lf 'log --format=medium'
git config set --file "$git_config" alias.lg 'log --graph --format=compactgraph'
git config set --file "$git_config" alias.prunetags '!git tag -l | xargs git tag -d && git fetch -t'
git config set --file "$git_config" alias.st 'status -sb'
git config set --file "$git_config" color.branch 'auto'
git config set --file "$git_config" color.status 'always'
git config set --file "$git_config" --type=path core.attributesfile '~/.config/git/attributes'
git config set --file "$git_config" --type=bool core.autocrlf false
git config set --file "$git_config" --type=bool core.filemode false
git config set --file "$git_config" --type=bool core.fscache true
git config set --file "$git_config" --type=bool core.preloadindex true
git config set --file "$git_config" core.whitespace 'cr-at-eol'
git config set --file "$git_config" diff.algorithm histogram
git config set --file "$git_config" --type=bool diff.renames true
git config set --file "$git_config" --type=bool fetch.all true
git config set --file "$git_config" --type=bool fetch.prune true
git config set --file "$git_config" --type=bool fetch.pruneTags true
git config set --file "$git_config" format.pretty 'compactgraph'
git config set --file "$git_config" help.autocorrect 'prompt'
git config set --file "$git_config" log.date 'local'
git config set --file "$git_config" merge.conflictstyle 'zdiff3'
git config set --file "$git_config" pretty.compactgraph '%C(blue)%<(10)%h%C(reset)%C(cyan)%ad%C(reset) %C(green)(%cr)%C(reset)%C(yellow)%d%C(reset)%n%<(10)%x20%C(normal)%s%C(reset) %C(magenta)- %ae%C(reset)'
git config set --file "$git_config" push.default 'current'
git config set --file "$git_config" --type=bool rebase.autosquash true
git config set --file "$git_config" --type=bool rebase.updaterefs true
git config set --file "$git_config" remote.origin.tagopt '--tags'
git config set --file "$git_config" --type=bool rerere.autoupdate true
git config set --file "$git_config" --type=bool rerere.enabled true

# Only useful when the 'jq' command is available.
# Perhaps this should be a plugin?
if command -v jq &>/dev/null; then
  git config set --file "$git_config" diff.json.textconv "jq -S '.'"
  echo "*.json diff=json" >"$git_config_dir/git/attributes"
fi
