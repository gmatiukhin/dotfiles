# creates and activates python's venv in a directory where there's no venv
# alternatively deactivates it
function venv
  if test -e "$VIRTUAL_ENV"
    deactivate
  else
    if not test -e .venv
      python3 -m venv .venv
    end
    source .venv/bin/activate.fish
  end
end
