# if on apple silicon, homebrew recommends installing to /opt/homebrew
# compared to previously homebrew's default install location was /usr/local
arch_name="$(uname -m)"

if [ "${arch_name}" = "arm64" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
elif [ "${{arch_name}" = "x86_64" ]; then
    export PATH="/usr/local/bin::$PATH"
else
    echo "Unknkown architecture ${arch_name}, your PATH may be incomplete"
fi

# rust environment
source "$HOME/.cargo/env"

# add yarn global binaries
# yarn global bin is just /opt/homebrew/bin so we can comment this out
# export PATH="$(yarn global bin):$PATH"

