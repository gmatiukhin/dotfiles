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
