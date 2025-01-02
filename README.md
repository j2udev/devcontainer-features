# Devcontainer Features

This repo contains [Dev Container](https://containers.dev/overview)
[Features](https://containers.dev/implementors/features/) for tools that I
commonly use. Feel free to use them as well!

## Documentation

For auto-generating feature documentation, run the following from the `src`
folder.

```sh
devcontainer features generate-docs -n j2udev/devcontainer-features
```

## Testing

For testing features, run the following from the root of the repo.

```sh
devcontainer features test -i mcr.microsoft.com/devcontainers/base:jammy
```

To test individual features, use the `-f` flag.

```sh
devcontainer features test -i mcr.microsoft.com/devcontainers/base:jammy -f k9s
```

## References

-   [VSCode Blog about Features](https://code.visualstudio.com/blogs/2022/09/15/dev-container-features)
-   [Dev Container Features reference](https://containers.dev/implementors/features/)
-   [Dev Container collection index (submit a PR here to have your templates/features show up in vscode)](https://github.com/devcontainers/devcontainers.github.io/blob/gh-pages/_data/collection-index.yml)
-   [Dev Container GitHub Action](https://github.com/devcontainers/action/blob/main/action.yml)
-   [Dev Container Feature authoring best practices](https://containers.dev/guide/feature-authoring-best-practices)
-   [Dev Container Feature test lib](https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib)
