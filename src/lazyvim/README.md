
# LazyVim (lazyvim)

Install LazyVim

## Example Usage

```json
"features": {
    "ghcr.io/j2udev/devcontainer-features/lazyvim:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| install_neovim | Whether to install neovim | boolean | true |
| install_lazyvim | Whether to install lazyvim | boolean | true |
| neovim_version | Select a Neovim version | string | stable |
| enable_config | Whether to enable custom config | boolean | true |

## Disclaimer

This feature is only tested on Ubuntu and is mostly a vanilla lazyvim installation.  There are a few config options that are enabled by default to make the nvim experience more like the Vim VSCode extension with vim.surround and vim.easymotion options enabled.  The Vim extension hasn't done a great job of keeping up with Neovim plugins, but I'm more often in VSCode than Neovim so I've committed those keybindings to muscle memory.

---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
