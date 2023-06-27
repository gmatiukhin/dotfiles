function open
  xdg-open $argv 2>&1 &> /dev/null &; disown
end
