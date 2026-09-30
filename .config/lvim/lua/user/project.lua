lvim.builtin.project = {
  active = true,
  manual_mode = false,
  detection_methods = { "lsp", "pattern" },
  patterns = {
    -- general
    ".git",
    "Makefile",

    -- Python
    "pyproject.toml",
    "setup.py",
    "requirements.txt",
    ".venv",

    -- C#
    "*.csproj",

    -- JavaScript/TypeScript
    "package.json",
    "tsconfig.json",

    -- HTML/CSS
    "index.html",
    "style.css",
  },
  show_hidden = true,
  silent_chdir = false,
  scope_chdir = "global",
  sync_root_with_cwd = true,
  update_focused_file = false,
  rescan_on_change = false,
}
