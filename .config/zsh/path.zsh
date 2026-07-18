export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# bun completions
[ -s "/Users/cloudduty/.bun/_bun" ] && source "/Users/cloudduty/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cloudduty/.lmstudio/bin"
# End of LM Studio CLI section

# Go bin
export PATH="$PATH:$HOME/go/bin"

# pnpm
export PNPM_HOME="/Users/cloudduty/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/bin/env"

# Composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# Postgres
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Added by Antigravity
export PATH="/Users/cloudduty/.antigravity/antigravity/bin:$PATH"

# Cargo
. "$HOME/.cargo/env"

# Custom script
export PATH="$HOME/extra/bin:$PATH"

export PATH="$HOME/.platformio/penv/bin:$PATH"
