function open
  for i in $argv
    xdg-open $i 2>&1 &> /dev/null &; disown
  end
end
