# LunarVim Cheat Sheet

## Core

- **File Explorer**: `<leader> e`
- **Move Backward in the Jump List**: <C-o>
- **Move Forward  in the Jump List**: <C-i>
- **Execute Command**: `:!command`
- **Show Documentation**: `K`
- **Enter Terminal**: `<leader> T`
- **Open Cheat Sheet**: `<leader> cs`
- **Switch Color Scheme**: `<leader> sc`

## Modes

- **Enter Normal Mode**:                `<Esc>`
- **Enter Insert Mode**:                `i`
- **Enter Append Mode**:                `a`
- **Enter Append Mode at End of Line**: `A`
- **Enter Character-Wise Visual Mode**: `v`
- **Enter Line-Wise      Visual Mode**: `V`
- **Enter Replace Mode**:               `R`

## Navigation

- **Move Cursor Left**:  `h`
- **Move Cursor Down**:  `j`
- **Move Cursor Up**:    `k`
- **Move Cursor Right**: `l`

- **Move to Next Word**:     `W`
- **Move to Previous Word**: `B`

- **Move to Start of Line**: `0`
- **Move to End   of Line**: `$`
- **Move to First Non-Blank Character**: `^`

- **Move Down by Number of Lines**: `number j`
- **Move Up   by Number of Lines**: `number k`

- **Move Down a Paragraph**: `}`
- **Move Up   a Paragraph**: `{`

- **Move Down Half Page**: `<C-d>`
- **Move Up   Half Page**: `<C-u>`

- **Move to Start of File**: `gg`
- **Move to End   of File**: `G`

- **Move to Line**: `number G`

## Search

- **Search**:                  `/query`
- **Search Case Insensitive**: `/query\c`

- **Next     Result**: `n`
- **Previous Result**: `N`

- **Clear Search**: `<C-l>`

- **Find Matching Bracket**: `%`

## Manipulation

- **Add New Line Below**: `o`
- **Add New Line Above**: `O`

- **Comment Out Block of Code**: `gc`
- **Comment Out Line**:          `gcc`

- **Replace Char**: `r`
- **Replace Word**: `ciw`
- **Replace Line**: `cc`
- **Replace Every Occurrence in File**: `:%s/old/new/g`

- **Delete Char**:               `x`
- **Delete Word**:               `daw`
- **Delete Line**:               `dd`
- **Delete to the End of Line**: `D`
- **Delete Entire File**:        `DA`

- **Delete the Inside of Matching Pair**: `di char`
- **Replace Matching Pair for Another**:  `cs char1 char2`

- **Copy**:             `y`
- **Copy Word**:        `yiw`
- **Copy Line**:        `yy`
- **Copy Entire File**: `YA`

- **Swap Lines**: `ddp`
- **Join Lines**: `J`

- **Paste**: `p`

- **Undo**: `u`
- **Redo**: `<C-r>`

## Windows

- **Vertical   Window Split**: `<C-w> v`
- **Horizontal Window Split**: `<C-w> h`

- **Cycle Through Windows**: `<C-w>`
- **Fullscreen Window Toggle**: `<leader> m`

- **Close Window**:                     `:q`
- **Close Window and Save Changes**:    `:wq name`
- **Close Window and Discard Changes**: `:q!`

## Tabs

- **New      Tab**: `<leader> t`
- **Close    Tab**: `<leader> q`
- **Next     Tab**: `<C-n>`
- **Previous Tab**: `<C-p`

## Telescope

- **Open File in New Tab**: `<C-t>`

- **Find Files**:         `<leader> f f`
- **Live Grep**:          `<leader> f g`
- **View Buffers**:       `<leader> f b`
- **View Recent Files**:  `<leader> f r`
- **Search Neovim Docs**: `<leader> f h`

- **Find References**:   `<leader> r r` 
- **Find Definitions**:  `<leader> r d` 
- **Find Declarations**: `<leader> r D` 

- **Switch from Telescope to Quickfix**:  `<C-q>`
- **Switch from Quickfix  to Telescope**: `<C-g>`

## Git

- **Open Diff View**:    `<leader> g d`
- **Open Repo History**: `<leader> g h`
- **Open File History**: `<leader> g f`
- **Close Diff View**:   `<leader> g q`

## Calendar

- **Open Calendar**: `<leader> cc`

