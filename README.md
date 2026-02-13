# 🧛 caos.nvim

> Personal Neovim IDE — Arch Linux · DWL · foot terminal
> Built on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with a custom Dracula layer inspired by [jonkero9](https://github.com/jonkero9/dotfiles)

![Neovim](https://img.shields.io/badge/Neovim-0.11-57A143?style=flat-square&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)
![Arch](https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white)
![Dracula](https://img.shields.io/badge/Theme-Dracula-BD93F9?style=flat-square)

---

## 📁 Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── kickstart/plugins/      ← Core IDE
    │   ├── lsp.lua             ← Language servers (nvim 0.11 API)
    │   ├── cmp.lua             ← Autocompletion
    │   ├── treesitter.lua      ← Syntax + text objects
    │   ├── debug.lua           ← DAP debugging
    │   ├── neo-tree.lua        ← File explorer (RIGHT side)
    │   ├── autopairs.lua
    │   ├── gitsigns.lua
    │   ├── indent_line.lua
    │   └── lint.lua
    └── custom/plugins/         ← Personal layer
        ├── dracula.lua         ← Theme + full transparency
        ├── dracula-syntax.lua  ← LSP-aware colors
        ├── lualine.lua         ← Custom statusline
        ├── telescope.lua
        ├── harpoon.lua
        ├── which-key.lua
        ├── rust-ide.lua        ← rustaceanvim + crates.nvim
        ├── devops.lua          ← YAML/Docker/K8s/Terraform
        └── extras.lua          ← LazyGit · hardtime · zen-mode
```

---

## ⌨️ Keybindings

> Leader key = `Space`

### General

<table>
  <thead>
    <tr>
      <th>Mode</th>
      <th>Key</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;Esc&gt;</kbd></td><td>Clear search highlight</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ss</kbd></td><td>Save file</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;gg</kbd></td><td>Open LazyGit</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;z</kbd></td><td>Zen Mode</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-d&gt;</kbd></td><td>Scroll down and keep cursor centered</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-u&gt;</kbd></td><td>Scroll up and keep cursor centered</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>n</kbd></td><td>Next search result and keep it centered</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>N</kbd></td><td>Previous search result and keep it centered</td></tr>
    <tr><td><kbd>x</kbd></td><td><kbd>&lt;leader&gt;p</kbd></td><td>Paste without losing register</td></tr>
    <tr><td><kbd>t</kbd></td><td><kbd>&lt;Esc&gt;&lt;Esc&gt;</kbd></td><td>Exit terminal mode</td></tr>
  </tbody>
</table>

### Window Navigation

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-h&gt;</kbd></td><td>Move focus to left split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-j&gt;</kbd></td><td>Move focus to lower split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-k&gt;</kbd></td><td>Move focus to upper split</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-l&gt;</kbd></td><td>Move focus to right split</td></tr>
  </tbody>
</table>

### LSP — Language Intelligence

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>gd</kbd></td><td>Go to Definition</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>gr</kbd></td><td>Find References</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>gI</kbd></td><td>Go to Implementation</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>gD</kbd></td><td>Go to Declaration</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>K</kbd></td><td>Hover Documentation</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ca</kbd></td><td>Code Actions</td></tr>
    <tr><td><kbd>v</kbd></td><td><kbd>&lt;leader&gt;ca</kbd></td><td>Code Actions (visual selection)</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rn</kbd></td><td>Rename Symbol</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;wf</kbd></td><td>Format File</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;k</kbd></td><td>Signature Help</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;D</kbd></td><td>Type Definition</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ds</kbd></td><td>Document Symbols</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ws</kbd></td><td>Workspace Symbols</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;E</kbd></td><td>Diagnostic Float</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>[d</kbd></td><td>Previous Diagnostic</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>]d</kbd></td><td>Next Diagnostic</td></tr>
  </tbody>
</table>

### Autocompletion

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-j&gt;</kbd> / <kbd>&lt;C-n&gt;</kbd></td><td>Next suggestion</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-k&gt;</kbd> / <kbd>&lt;C-p&gt;</kbd></td><td>Previous suggestion</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;CR&gt;</kbd></td><td>Confirm selection</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-Space&gt;</kbd></td><td>Force open completion</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-e&gt;</kbd></td><td>Abort completion</td></tr>
    <tr><td><kbd>i/s</kbd></td><td><kbd>&lt;Tab&gt;</kbd></td><td>Next item / jump snippet placeholder</td></tr>
    <tr><td><kbd>i/s</kbd></td><td><kbd>&lt;S-Tab&gt;</kbd></td><td>Previous item / jump back in snippet</td></tr>
    <tr><td><kbd>i</kbd></td><td><kbd>&lt;C-b&gt;</kbd> / <kbd>&lt;C-f&gt;</kbd></td><td>Scroll documentation</td></tr>
  </tbody>
</table>

### Telescope — Fuzzy Finder

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;&lt;leader&gt;</kbd></td><td>Find Files</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sg</kbd></td><td>Live Grep</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sr</kbd></td><td>Recent Files</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sb</kbd></td><td>Search Buffers</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sw</kbd></td><td>Search Current Word</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sd</kbd></td><td>Search Diagnostics</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sh</kbd></td><td>Search Help Tags</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sk</kbd></td><td>Search Keymaps</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sc</kbd></td><td>Search Commands</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sG</kbd></td><td>Git Files</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;/</kbd></td><td>Search in Current Buffer</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;s:</kbd></td><td>Command History</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;sR</kbd></td><td>Resume Last Search</td></tr>
  </tbody>
</table>

### Harpoon — Quick File Navigation

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;a</kbd></td><td>Add file to Harpoon</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-e&gt;</kbd></td><td>Toggle Harpoon menu</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;fl</kbd></td><td>Harpoon list in Telescope</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;M-1&gt;</kbd></td><td>Jump to Harpoon file 1</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;M-2&gt;</kbd></td><td>Jump to Harpoon file 2</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;M-3&gt;</kbd></td><td>Jump to Harpoon file 3</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;M-4&gt;</kbd></td><td>Jump to Harpoon file 4</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-p&gt;</kbd></td><td>Previous Harpoon file</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;C-n&gt;</kbd></td><td>Next Harpoon file</td></tr>
  </tbody>
</table>

### File Explorer — Neo-tree

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;e</kbd></td><td>Toggle Explorer</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;E</kbd></td><td>Toggle Explorer (cwd)</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>h</kbd></td><td>Close / collapse node</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>l</kbd></td><td>Open / expand node</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>a</kbd></td><td>Add file</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>A</kbd></td><td>Add directory</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>d</kbd></td><td>Delete</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>r</kbd></td><td>Rename</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>y</kbd></td><td>Copy to clipboard</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>x</kbd></td><td>Cut to clipboard</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>p</kbd></td><td>Paste from clipboard</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>q</kbd></td><td>Close explorer</td></tr>
  </tbody>
</table>

### Debug — DAP

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>F5</kbd></td><td>Start / Continue</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>F1</kbd></td><td>Step Into</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>F2</kbd></td><td>Step Over</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>F3</kbd></td><td>Step Out</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>F7</kbd></td><td>Toggle DAP UI</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;b</kbd></td><td>Toggle Breakpoint</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;B</kbd></td><td>Conditional Breakpoint</td></tr>
  </tbody>
</table>

### Treesitter — Text Objects

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>gnn</kbd></td><td>Start incremental selection</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>grn</kbd></td><td>Expand selection by node</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>grc</kbd></td><td>Expand to scope</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>grm</kbd></td><td>Shrink selection</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>vaf</kbd> / <kbd>vif</kbd></td><td>Select around / inside function</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>vac</kbd> / <kbd>vic</kbd></td><td>Select around / inside class</td></tr>
    <tr><td><kbd>n/v</kbd></td><td><kbd>vaa</kbd> / <kbd>via</kbd></td><td>Select around / inside parameter</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>]f</kbd> / <kbd>[f</kbd></td><td>Next / previous function</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>]c</kbd> / <kbd>[c</kbd></td><td>Next / previous class</td></tr>
  </tbody>
</table>

### Rust — rustaceanvim + crates.nvim

<table>
  <thead>
    <tr><th>Mode</th><th>Key</th><th>Action</th></tr>
  </thead>
  <tbody>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rr</kbd></td><td>Runnables</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rd</kbd></td><td>Debuggables</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;re</kbd></td><td>Expand Macro</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rc</kbd></td><td>Open Cargo.toml</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rp</kbd></td><td>Parent Module</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;rj</kbd></td><td>Join Lines</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ra</kbd></td><td>Rust Code Action</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ct</kbd></td><td>Toggle crate info</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cu</kbd></td><td>Update crate</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;cU</kbd></td><td>Upgrade crate</td></tr>
    <tr><td><kbd>n</kbd></td><td><kbd>&lt;leader&gt;ca</kbd></td><td>Update all crates</td></tr>
  </tbody>
</table>

---

## 🌐 Language Servers

| Server | Language |
|--------|----------|
| `lua_ls` | Lua (nvim API aware) |
| `rust_analyzer` | Rust |
| `ts_ls` | JavaScript / TypeScript |
| `pyright` | Python |
| `gopls` | Go |
| `clangd` | C / C++ |
| `zls` | Zig |
| `yamlls` | YAML |
| `bashls` | Bash |
| `jsonls` | JSON |
| `terraformls` | Terraform |
| `dockerls` | Dockerfile |
| `html` | HTML |
| `eslint` | JS/TS linting |

---

## 🎨 Theme — Dracula

Full transparency so your wallpaper shows through. LSP-aware syntax colors:

| Token | Color |
|-------|-------|
| Parameters | `#ffb86c` Orange |
| Properties | `#8be9fd` Cyan |
| Functions | `#50fa7b` Green |
| Keywords | `#ff79c6` Pink |
| Types / Structs | `#8be9fd` Cyan |
| Strings | `#f1fa8c` Yellow |
| Numbers | `#bd93f9` Purple |
| Comments | `#6272a4` Muted Blue *(italic)* |

---

## 📦 Fresh Install

```bash
# 1. Clone config
git clone <your-repo> ~/.config/nvim

# 2. Open nvim — lazy bootstraps itself
nvim

# 3. Sync all plugins
:Lazy sync

# 4. Install language servers
:Mason

# 5. Node.js provider
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
npm install -g neovim

# 6. Python provider
pip install pynvim --break-system-packages

# 7. Verify everything
:checkhealth
```

---

*Built with ❤️ on Arch Linux + DWL + foot terminal*
