# creates and activates python's venv in a directory where there's no venv
# alternatively deactivates it
function venv -a python
  if test -e "$VIRTUAL_ENV"
    deactivate
  else
    if not test -e .venv
      if string match -req "python3\.\d+" $python
        $python -m venv .venv
      else
        python3 -m venv .venv
      end
    end
    source .venv/bin/activate.fish
  end
end
