# adds homebrew stuff to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# poetry - python package management tool
export PATH="$HOME/.poetry/bin:$PATH"

# rust
source "$HOME/.cargo/env"

# local zprofile config
source "$HOME/.zprofile.local"

