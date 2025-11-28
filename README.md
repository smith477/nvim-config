# Neovim Config

LazyVim-based setup with **Swift (iOS)** and **Go** language support.

## What's Configured

### Swift/iOS
- SourceKit LSP with proper root detection
- SwiftFormat integration (respects `.swiftformat` config)
- SwiftLint diagnostics
- Xcodebuild.nvim for build/run/test from editor
- DAP debugging with codelldb

### Go
- gopls with full configuration
- goimports + gofumpt formatting pipeline
- Standard Go tooling integration

## Structure
```
lua/plugins/
├── swift-config.lua       # SourceKit LSP setup
├── go-config.lua          # gopls setup
├── go-formatting.lua      # Go formatter chain
├── lsp-keymaps.lua        # LSP attach hooks
├── xcodebuild-plugin.lua  # Xcode integration
└── ...
```

## Installation
```bash
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
nvim  # Plugins auto-install
```

Install language servers via `:Mason` - gopls, goimports, gofumpt.

## Requirements

- **Swift**: Xcode CLI tools, `buildServer.json` in project root
- **Go**: Go 1.18+, project with `go.mod`
