FROM mcr.microsoft.com/devcontainers/base:bookworm

USER vscode

RUN sudo chown -R vscode:vscode /home/vscode

# Install Haskell (GHCup + GHC + cabal + stack)
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_MINIMAL=1 \
    sh

ENV PATH="/home/vscode/.ghcup/bin:/home/vscode/.cabal/bin:${PATH}"

RUN ghcup install ghc recommended && ghcup set ghc recommended

RUN ghcup install cabal recommended && ghcup set cabal recommended

# # Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/home/vscode/.cargo/bin:${PATH}"

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Install Nodejs + Global Packages
RUN curl -o- https://fnm.vercel.app/install | bash \
    && export PATH="/home/vscode/.local/share/fnm:$PATH" \
    && eval "$(fnm env)" \
    && fnm install 24 \
    && npm install -g \
      lefthook
