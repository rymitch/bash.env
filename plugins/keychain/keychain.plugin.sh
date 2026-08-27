# Initialize keychain (a manager for ssh-agent)

if command -v keychain &>/dev/null; then
  eval "$(keychain --eval --noask --quiet)"
else
  echo "WARNING: You have enabled the keychain plugin but keychain is not installed."
fi
