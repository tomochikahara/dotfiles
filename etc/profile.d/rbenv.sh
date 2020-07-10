# https://qiita.com/sonots/items/a309520b9cce1b7631a5
if command -v rbenv &> /dev/null && [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init --no-rehash -)"
fi
