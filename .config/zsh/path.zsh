export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

# Go bin
export PATH="$PATH:$HOME/go/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -s "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# Postgres (HOMEBREW_PREFIX differs on Intel Macs: /usr/local)
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/postgresql@17/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Cargo
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Custom script
export PATH="$HOME/extra/bin:$PATH"

export PATH="$HOME/.platformio/penv/bin:$PATH"
