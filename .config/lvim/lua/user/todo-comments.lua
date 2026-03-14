require("todo-comments").setup {
  highlight = {
    comments_only = false,
    pattern = [[.*#\s*(KEYWORDS).*]],
  },
  colors = {
    background   = { "#2E222F" },
    current_line = { "#3E3546" },
    foreground   = { "#AB947A" },
    comment      = { "#625565" },
    cyan         = { "#0B8A8F" },
    green        = { "#A2A947" },
    orange       = { "#F79617" },
    pink         = { "#A24B6F" },
    purple       = { "#A24B6F" },
    red          = { "#B33831" },
    yellow       = { "#F9C22B" },
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
