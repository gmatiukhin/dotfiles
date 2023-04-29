if status is-interactive
  fish_add_path $HOME/.cargo/bin # cargo
  fish_add_path $HOME/.local/bin # pip
  fish_add_path /usr/lib/node_modules # npm

  abbr --add grep rg
  abbr --add find fd
  abbr --add cat bat
  abbr --add ssh "kitty +kitten ssh"
end
