FROM mcr.microsoft.com/devcontainers/base AS base
ENV PATH=$PATH:/opt/node-v22.11.0-linux-arm64/bin
RUN curl -L https://nodejs.org/dist/v22.11.0/node-v22.11.0-linux-arm64.tar.xz | sudo tar -xJ -C /opt \
    && npm install -g @devcontainers/cli