#compdef repo
function _repo {
for r in $(find "$HOME/Projects" -mindepth 1 -maxdepth 1 -type d)
do
  if [[ ! $(basename $r) == '.git' ]]; then
    compadd "$(basename $r)"
  fi
done
}

_repo
