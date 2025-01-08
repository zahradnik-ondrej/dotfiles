require("todo-comments").setup {
  highlight = {
    comments_only = false,
    pattern = [[.*#\s*(KEYWORDS).*]],
  },
  colors = {
    background = { "#282A36" },
    current_line = { "#44475A" },
    foreground = { "#F8F8F2" },
    comment = { "#6272A4" },
    cyan = { "#8BE9FD" },
    green = { "#50FA7B" },
    orange = { "#FFB86C" },
    pink = { "#FF79C6" },
    purple = { "#BD93F9" },
    red = { "#FF5555" },
    yellow = { "#F1FA8C" },
  },
  keywords = {
    TODO = { icon = "", color = "background" },
    HACK = { icon = "", color = "background" },
    WARN = { icon = "", color = "background" },
    PERF = { icon = "", color = "background" },
    FIX = { icon = "", color = "red", alt = { "BUG" } },
    FIXED = { icon = "", color = "green" },
    NOTE = { icon = "", color = "comment" },
    TEST = { icon = "", color = "cyan" },
    DONE = { icon = "", color = "green" },
    TODO_HIGH = { icon = "", color = "red" },
    TODO_MID = { icon = "", color = "orange" },
    TODO_LOW = { icon = "", color = "yellow" },
  },
}

-- #TODO
-- #HACK
-- #WARN
-- #PERF
-- #TEST
-- #FIX
-- #BUG
-- #FIXED

-- #NOTE
-- #DONE
-- #TODO_HIGH
-- #TODO_MID
-- #TODO_LOW
