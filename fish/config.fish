if status is-interactive
  fish_vi_key_bindings

  fish_add_path $HOME/.cargo/bin # cargo
  fish_add_path $HOME/.local/bin # pip
  fish_add_path $HOME/go/bin # golang
  fish_add_path /usr/lib/node_modules # npm

  abbr --add grep rg
  abbr --add find fd
  abbr --add cat bat
  abbr --add dig dog
  abbr --add ls lsd
  abbr --add ll "lsd -l"
  abbr --add ssh "kitty +kitten ssh"
  abbr --add killjobs 'kill $(jobs -p)'
  export GPG_TTY=$(tty)
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/gmatiukhin/.ghcup/bin # ghcup-env