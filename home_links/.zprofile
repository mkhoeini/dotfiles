
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Start ssh-agent if not already running
if ! pgrep -q ssh-agent; then
  eval "$(ssh-agent -s)"
fi

