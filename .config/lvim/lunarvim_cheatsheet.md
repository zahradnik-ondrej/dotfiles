# LunarVim Cheatsheet

## Core

- **Move Backward in the Jump List**: `<C-o>`
- **Move Forward  in the Jump List**: `<C-i>`
- **Execute Command**: `:!command`
- **Show Documentation**: `K`
- **Toggle Terminal**: `<C-t>`

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

- **Find Matching Bracket**: `%`

## Manipulation

- **Add New Line Below**: `o`
- **Add New Line Above**: `O`

- **Replace Char**:               `r`
- **Replace Word**:               `ciw`
- **Replace Line**:               `cc`
- **Replace to the End of Line**: `C`
- **Replace Every Occurrence in File**: `:%s/old/new/g`

- **Delete Char**:                  `x`
- **Delete Word**:                  `daw`
- **Delete Line**:                  `dd`
- **Delete to the End of Line**:    `D`
- **Delete Entire File's Content**: `DA`

- **Delete the Inside of Matching Pair**: `di char`
- **Replace Matching Pair for Another**:  `cs char1 char2`

- **Copy**:                       `y`
- **Copy Word**:                  `yiw`
- **Copy Line**:                  `yy`
- **Copy to the End of Line**:    `Y`
- **Copy Entire File's Content**: `YA`

- **Swap Lines**: `ddp`
- **Join Lines**: `J`

- **Paste**: `p`

- **Undo**: `u`
- **Redo**: `<C-r>`

## Windows

- **Vertical   Window Split**: `<C-w> v`
- **Horizontal Window Split**: `<C-w> h`

- **Maximize Window**: `<C-m>`

- **Cycle Through Windows**: `<C-w> <C-w>`

- **Close Window**:                     `:q`
- **Close Window and Save Changes**:    `:x name`
- **Close Window and Discard Changes**: `:q!`

## Tabs

- **Next     Tab**: `<C-n>`
- **Previous Tab**: `<C-p`

## Telescope

- **Open File in New Tab**: `<C-t>`

## File Explorer

- **Show Hidden Files**: `H`
