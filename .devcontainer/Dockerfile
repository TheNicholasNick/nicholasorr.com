FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bookworm

# Install zsh and set it as the default shell - also locale stuff
RUN apt-get update && apt-get install -y --no-install-recommends \
    zsh \
    locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && chsh -s /bin/zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && zsh -c 'source /home/node/.zshrc && omz update'

ENV LANG=en_US.UTF-8

# Install pnpm
RUN npm install -g pnpm

# Set working directory
WORKDIR /workspace

# Expose port 4321
EXPOSE 4321

# Set the default command to zsh
CMD ["zsh"]