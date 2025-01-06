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
    DONE = { color = "green" },
    NOTE = { color = "comment" },
    TODO_HIGH = { color = "red" },
    TODO_MID = { color = "orange" },
    TODO_LOW = { color = "yellow" },
  },
}
