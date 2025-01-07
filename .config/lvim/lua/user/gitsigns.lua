lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  b = lvim.builtin.which_key.mappings["g"]["b"],
  C = { lvim.builtin.which_key.mappings["g"]["C"][1], "Checkout commit (for current file)" },
  c = lvim.builtin.which_key.mappings["g"]["c"],
  d = { lvim.builtin.which_key.mappings["g"]["d"][1], "Git diff" },
  l = { lvim.builtin.which_key.mappings["g"]["l"][1], "Blame line" },
  g = nil, -- unbind <leader> g g (Lazygit)
  j = nil, -- unbind <leader> g j (Next Hunk)
  k = nil, -- unbind <leader> g k (Prev Hunk)
  L = nil, -- unbind <leader> g L (Blame Line (full))
  o = nil, -- unbind <leader> g o (Open changed file)
  p = nil, -- unbind <leader> g p (Preview Hunk)
  r = nil, -- unbind <leader> g r (Reset Hunk)
  R = nil, -- unbind <leader> g R (Reset Buffer)
  s = nil, -- unbind <leader> g s (Stage Hunk)
  u = nil, -- unbind <leader> g u (Undo Stage Hunk)
}
