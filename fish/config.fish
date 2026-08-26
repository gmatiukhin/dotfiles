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
  abbr --add rm "rm -I"
  export GPG_TTY=$(tty)
end

set -gx JAVA_HOME $(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | xargs | cut -d " " -f 3)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin
