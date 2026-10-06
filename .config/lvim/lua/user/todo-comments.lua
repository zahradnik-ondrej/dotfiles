local p = require("user.palette")

require("todo-comments").setup {
  highlight = {
    comments_only = false,
    pattern = [[.*#\s*(KEYWORDS).*]],
  },
  colors = {
    background   = { p.bg },
    current_line = { p.bg_alt },
    foreground   = { p.tan },
    comment      = { p.cyan },
    cyan         = { p.teal },
    green        = { p.olive },
    orange       = { p.orange },
    pink         = { p.accent },
    purple       = { p.accent },
    red          = { p.red },
    yellow       = { p.yellow },
  },
  keywords = {
    HACK = { icon = "", color = "background" },
    PERF = { icon = "", color = "background" },

    NOTE = { icon = "", color = "comment" },
    INFO = { icon = "", color = "comment" },
    LEGACY = { icon = "", color = "comment" },
    DOCS = { icon = "󰧮", color = "comment" },

    TASK = { icon = "󰧑", color = "cyan" },
    IDEA = { icon = "", color = "cyan" },
    CLEANUP = { icon = "󰃢", color = "cyan" },
    REFACTOR = { icon = "󱑞", color = "cyan" },
    OPTIMIZE = { icon = "󰓅", color = "cyan" },
    REVIEW = { icon = "", color = "cyan" },
    TEST = { icon = "", color = "cyan" },
    TODO = { icon = "", color = "cyan" },

    TESTED = { icon = "", color = "green" },
    FIXED = { icon = "", color = "green" },
    DONE = { icon = "", color = "green" },

    TODO_LOW = { icon = "", color = "yellow" },
    TEST_LOW = { icon = "", color = "yellow" },

    WARN = { icon = "", color = "orange" },
    TODO_MID = { icon = "", color = "orange" },
    TEST_MID = { icon = "", color = "orange" },
    WIP = { icon = "󰖷", color = "orange" },
    TEMP = { icon = "󰖷", color = "orange" },
    DEPRECATED = { icon = "", color = "orange" },

    CRITICAL = { icon = "", color = "red" },
    TODO_HIGH = { icon = "", color = "red" },
    SECURITY = { icon = "󰒃", color = "red" },
    TEST_HIGH = { icon = "", color = "red" },
    FIX = { icon = "", color = "red", alt = { "BUG" } },
  },
}

-- #HACK
-- #PERF

-- #NOTE
-- #INFO
-- #LEGACY
-- #DOCS

-- #TASK
-- #IDEA
-- #CLEANUP
-- #REFACTOR
-- #OPTIMIZE
-- #REVIEW
-- #TEST
-- #TODO

-- #TESTED
-- #FIXED
-- #DONE

-- #TODO_LOW
-- #TEST_LOW

-- #WARN
-- #TODO_MID
-- #TEST_MID
-- #WIP
-- #TEMP
-- #DEPRECATED

-- #CRITICAL
-- #TODO_HIGH
-- #TEST_HIGH
-- #SECURITY
-- #FIX
-- #BUG
