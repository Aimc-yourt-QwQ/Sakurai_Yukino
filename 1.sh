#bin/bash
curl -s http://ohmyposh.dev/install.sh | bash -s

sleep 5

cat <<EOF > $HOME/.config/fish/config.fish
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ""
oh-my-posh init fish --config ~/.cache/oh-my-posh/themes/montys.omp.json | source

EOF
