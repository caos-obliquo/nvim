# caos.nvim

Personal Neovim configuration for Arch Linux + DWL + foot terminal.
Built on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with a Dracula layer inspired by [jonkero9](https://github.com/jonkero9/dotfiles).

![Neovim](https://img.shields.io/badge/Neovim-0.11-57A143?style=flat-square&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)
![Arch](https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white)

---

## Structure

```
~/.config/nvim/
├── init.lua                        settings, remaps, lazy bootstrap
└── lua/
    ├── kickstart/plugins/
    │   ├── lsp.lua                 language servers (nvim 0.11 API)
    │   ├── cmp.lua                 autocompletion
    │   ├── treesitter.lua          syntax + text objects
    │   ├── debug.lua               DAP (Rust, Go, C/C++)
    │   ├── neo-tree.lua            file explorer (right side)
    │   ├── autopairs.lua
    │   ├── gitsigns.lua
    │   ├── indent_line.lua
    │   └── lint.lua
    └── custom/plugins/
        ├── dracula.lua             theme + transparency
        ├── dracula-syntax.lua      LSP-aware syntax colors
        ├── lualine.lua             statusline
        ├── telescope.lua           fuzzy finder
        ├── harpoon.lua             quick file navigation
        ├── which-key.lua           keybinding hints
        ├── noice.lua               floating cmdline + notifications
        ├── rust-ide.lua            rustaceanvim + crates.nvim
        ├── conform.lua             formatting (stylua, prettier, gofmt, clang-format...)
        ├── trouble.lua             diagnostics list
        ├── neotest.lua             test runner
        ├── undotree.lua            visual undo history
        ├── refactoring.lua         extract variable/function/block
        ├── cloak.lua               hide secrets in .env files
        ├── context.lua             show current function at top (disabled for yaml/json/toml)
        ├── devops.lua              YAML/Docker/K8s/Terraform schemas
        ├── spectre.lua             project-wide search and replace
        └── extras.lua              LazyGit, hardtime, zen-mode, surround, illuminate
```

---

## Keybindings

Leader = `Space`

### General

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;Esc&gt;</kbd></td><td>Clear search highlight</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ss</kbd></td><td>Save file</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;f</kbd></td><td>Format file</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;zig</kbd></td><td>Restart LSP</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;u</kbd></td><td>Toggle Undotree</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;z</kbd></td><td>Toggle Zen Mode</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;gg</kbd></td><td>Open LazyGit</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;s</kbd></td><td>Search and replace word under cursor</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;x</kbd></td><td>Make file executable (chmod +x)</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>&lt;leader&gt;y</kbd></td><td>Yank to system clipboard</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;Y</kbd></td><td>Yank line to system clipboard</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>&lt;leader&gt;d</kbd></td><td>Delete to void register</td></tr>
    <tr><td><kbd>x</kbd></td><td><kbd>&lt;leader&gt;p</kbd></td><td>Paste without losing register</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>J</kbd></td><td>Join lines keeping cursor position</td></tr>
    <tr><td><kbd>v</kbd></td><td><kbd>J</kbd> / <kbd>K</kbd></td><td>Move selected lines down / up</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>=ap</kbd></td><td>Auto-format paragraph</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-d&gt;</kbd> / <kbd>&lt;C-u&gt;</kbd></td><td>Scroll half-page, cursor centered</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>n</kbd> / <kbd>N</kbd></td><td>Next / prev search result, centered</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-c&gt;</kbd></td><td>Exit insert mode</td></tr>
    <tr><td><kbd>t</kbd></td><td><kbd>&lt;Esc&gt;&lt;Esc&gt;</kbd></td><td>Exit terminal mode</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>Q</kbd></td><td>Disabled (prevents accidental Ex mode)</td></tr>
  </tbody>
</table>

### Window Navigation

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-h&gt;</kbd></td><td>Move to left split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-j&gt;</kbd></td><td>Move to lower split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-k&gt;</kbd></td><td>Move to upper split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-l&gt;</kbd></td><td>Move to right split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>]q</kbd> / <kbd>[q</kbd></td><td>Quickfix next / prev</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>]l</kbd> / <kbd>[l</kbd></td><td>Location list next / prev</td></tr>
  </tbody>
</table>

### File Explorer (neo-tree)

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;e</kbd></td><td>Toggle file explorer (right)</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;E</kbd></td><td>Toggle file explorer at cwd</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>h</kbd></td><td>Close node</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>l</kbd> / <kbd>o</kbd> / <kbd>&lt;cr&gt;</kbd></td><td>Open</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>s</kbd></td><td>Open in horizontal split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>v</kbd></td><td>Open in vertical split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>t</kbd></td><td>Open in new tab</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>a</kbd> / <kbd>A</kbd></td><td>Add file / directory</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>d</kbd></td><td>Delete</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>r</kbd></td><td>Rename</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>y</kbd> / <kbd>x</kbd> / <kbd>p</kbd></td><td>Copy / cut / paste</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>z</kbd> / <kbd>Z</kbd></td><td>Close all / expand all nodes</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>R</kbd></td><td>Refresh</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>q</kbd></td><td>Close window</td></tr>
  </tbody>
</table>

### LSP

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>gd</kbd></td><td>Go to definition</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>gr</kbd></td><td>Find references</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>gI</kbd></td><td>Go to implementation</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>gD</kbd></td><td>Go to declaration</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>K</kbd></td><td>Hover documentation</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>&lt;leader&gt;ca</kbd></td><td>Code actions</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rn</kbd></td><td>Rename symbol</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;D</kbd></td><td>Type definition</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ds</kbd></td><td>Document symbols</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ws</kbd></td><td>Workspace symbols</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;k</kbd></td><td>Signature help</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>]d</kbd> / <kbd>[d</kbd></td><td>Next / prev diagnostic</td></tr>
  </tbody>
</table>

### Completion

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-j&gt;</kbd> / <kbd>&lt;C-n&gt;</kbd></td><td>Next suggestion</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-k&gt;</kbd> / <kbd>&lt;C-p&gt;</kbd></td><td>Previous suggestion</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;CR&gt;</kbd> / <kbd>&lt;C-y&gt;</kbd></td><td>Confirm selection</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-Space&gt;</kbd></td><td>Force open completion</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-e&gt;</kbd></td><td>Abort completion</td></tr>
    <tr><td><kbd>i/s</kbd></td><td><kbd>&lt;Tab&gt;</kbd> / <kbd>&lt;S-Tab&gt;</kbd></td><td>Next / prev item or snippet jump</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-b&gt;</kbd> / <kbd>&lt;C-f&gt;</kbd></td><td>Scroll documentation</td></tr>
  </tbody>
</table>

### Telescope

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;&lt;leader&gt;</kbd></td><td>Find files</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sf</kbd></td><td>Find files (explicit)</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sg</kbd></td><td>Live grep</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sr</kbd></td><td>Recent files</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sb</kbd></td><td>Search buffers</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sw</kbd></td><td>Search word under cursor</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sd</kbd></td><td>Search diagnostics</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sh</kbd></td><td>Search help tags</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sk</kbd></td><td>Search keymaps</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sc</kbd></td><td>Search commands</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sG</kbd></td><td>Git files</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;s.</kbd></td><td>Recent files in cwd</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sR</kbd></td><td>Resume last search</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;s:</kbd></td><td>Command history</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;/</kbd></td><td>Fuzzy search in current buffer</td></tr>
  </tbody>
</table>

### Harpoon

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;a</kbd></td><td>Add file to harpoon</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-e&gt;</kbd></td><td>Toggle harpoon menu</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-h&gt;</kbd></td><td>Jump to file 1</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-t&gt;</kbd></td><td>Jump to file 2</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-n&gt;</kbd></td><td>Jump to file 3</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-s&gt;</kbd></td><td>Jump to file 4</td></tr>
  </tbody>
</table>

### Git (gitsigns)

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>]c</kbd> / <kbd>[c</kbd></td><td>Next / prev git change</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>&lt;leader&gt;hs</kbd></td><td>Stage hunk</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>&lt;leader&gt;hr</kbd></td><td>Reset hunk</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hS</kbd></td><td>Stage buffer</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hu</kbd></td><td>Undo stage hunk</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hR</kbd></td><td>Reset buffer</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hp</kbd></td><td>Preview hunk</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hb</kbd></td><td>Blame line</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hd</kbd></td><td>Diff against index</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;hD</kbd></td><td>Diff against last commit</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;tb</kbd></td><td>Toggle git blame</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;gg</kbd></td><td>Open LazyGit</td></tr>
  </tbody>
</table>

### DAP (Debug)

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;F5&gt;</kbd></td><td>Start / continue</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;F1&gt;</kbd></td><td>Step into</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;F2&gt;</kbd></td><td>Step over</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;F3&gt;</kbd></td><td>Step out</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;b</kbd></td><td>Toggle breakpoint</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;B</kbd></td><td>Set conditional breakpoint</td></tr>
  </tbody>
</table>

### Trouble

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;xq</kbd></td><td>Quickfix list</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;xd</kbd></td><td>Diagnostics</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;xl</kbd></td><td>Location list</td></tr>
  </tbody>
</table>

### Rust (rustaceanvim + crates.nvim)

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rr</kbd></td><td>Runnables</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rd</kbd></td><td>Debuggables</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;re</kbd></td><td>Expand macro</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rc</kbd></td><td>Open Cargo.toml</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rp</kbd></td><td>Parent module</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rj</kbd></td><td>Join lines</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ra</kbd></td><td>Code action (Rust)</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ct</kbd></td><td>Crates: Toggle info</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cr</kbd></td><td>Crates: Reload</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cu</kbd></td><td>Crates: Update crate</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cU</kbd></td><td>Crates: Upgrade crate</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ca</kbd></td><td>Crates: Update all crates</td></tr>
  </tbody>
</table>

### Java (jdtls — only active in .java files)

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;co</kbd></td><td>Organize imports</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cxv</kbd></td><td>Extract variable</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cxc</kbd></td><td>Extract constant</td></tr>
    <tr><td><kbd>v</kbd></td><td><kbd>&lt;leader&gt;cxm</kbd></td><td>Extract method</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;dt</kbd></td><td>Test class</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;dm</kbd></td><td>Test nearest method</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;dc</kbd></td><td>Debug continue</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;db</kbd></td><td>Debug toggle breakpoint</td></tr>
  </tbody>
</table>

---

## Language Servers

| Server          | Language                                                                 |
| --------------- | ------------------------------------------------------------------------ |
| `lua_ls`        | Lua                                                                      |
| `rust_analyzer` | Rust                                                                     |
| `ts_ls`         | JavaScript / TypeScript                                                  |
| `pyright`       | Python                                                                   |
| `gopls`         | Go                                                                       |
| `clangd`        | C / C++                                                                  |
| `zls`           | Zig                                                                      |
| `yamlls`        | YAML (with SchemaStore — GitLab CI, K8s, Docker Compose, GitHub Actions) |
| `bashls`        | Bash                                                                     |
| `jsonls`        | JSON (with SchemaStore)                                                  |
| `terraformls`   | Terraform                                                                |
| `dockerls`      | Dockerfile                                                               |
| `html`          | HTML                                                                     |
| `eslint`        | JavaScript / TypeScript linting                                          |
| `jdtls`         | Java                                                                     |

---

## Linters (nvim-lint)

| Linter                 | Language                 |
| ---------------------- | ------------------------ |
| `yamllint`             | YAML                     |
| `jsonlint`             | JSON                     |
| `markdownlint`         | Markdown                 |
| `hadolint`             | Dockerfile               |
| `tflint`               | Terraform                |
| `shellcheck`           | Bash / Sh / Zsh          |
| `eslint_d`             | JavaScript / TypeScript  |
| `htmlhint`             | HTML                     |
| `stylelint`            | CSS                      |
| `ruff`                 | Python                   |
| `clippy`               | Rust (runs on save only) |
| `zlint`                | Zig                      |
| `cpplint` + `cppcheck` | C / C++ (GNU style)      |
| `pmd`                  | Java                     |
| `golangci-lint`        | Go                       |
| `luacheck`             | Lua                      |

---

## Formatters (conform.nvim)

| Formatter             | Language                                      |
| --------------------- | --------------------------------------------- |
| `stylua`              | Lua                                           |
| `ruff_format`         | Python                                        |
| `shfmt`               | Bash / Sh / Zsh                               |
| `prettier`            | JS / TS / HTML / CSS / JSON / YAML / Markdown |
| `clang_format` (GNU)  | C / C++                                       |
| `rustfmt`             | Rust                                          |
| `zigfmt`              | Zig                                           |
| `google_java_format`  | Java                                          |
| `gofmt` + `goimports` | Go                                            |
| `terraform_fmt`       | Terraform                                     |

---

## Install

```bash
git clone git@github.com:caos-obliquo/nvim.git ~/.config/nvim
nvim
:Lazy sync
:Mason

# Node.js provider
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
npm install -g neovim

# Python provider
pip install pynvim --break-system-packages

# System packages (not in Mason)
sudo pacman -S luarocks luacheck cppcheck pmd

# Java
sudo pacman -S jdk21-openjdk
sudo archlinux-java set java-21-openjdk

# Mason packages
:MasonInstall yamllint jsonlint hadolint tflint shellcheck eslint_d htmlhint stylelint ruff cpplint golangci-lint markdownlint luacheck shfmt prettier stylua google-java-format goimports

:checkhealth
```

---

Built on Arch Linux + DWL + foot terminal

---

## Special Thanks

- [TJ DeVries](https://github.com/tjdevries) — Neovim core maintainer, creator of Kickstart.nvim, telescope.nvim and plenary.nvim. Without him none of this would be possible.
- [ThePrimeagen](https://github.com/ThePrimeagen) — Creator of harpoon and refactoring.nvim. For teaching effective Vim usage through his video tutorials, remaps and workflow philosophy that shaped this config.
- [jonkero9](https://github.com/jonkero9) — For pushing the extra mile on Neovim debugging and LSP configuration, directly inspiring the Dracula layer and syntax colors.
