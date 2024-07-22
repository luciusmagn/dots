if status is-interactive
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -xg PATH /root/.config/emacs/bin/ $PATH

# fugg

set -xg DBUS_SESSION_BUS_ADDRESS "unix:path=/run/user/"(id -u)/bus

set -xg MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xg MANROFFOPT "-c"
