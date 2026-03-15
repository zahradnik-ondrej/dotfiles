## Workflow: Generate Release Notes

Follow these steps in order without stopping for approval:

### 0. Input
- The user provides two version tags from the `meta-sl1` repository (e.g. `2.0.0-beta.8` and `2.0.0-beta.9`)
- The older tag is the baseline, the newer tag is the release being documented

### 1. Pre-flight Checks
- Check if `~/.playground/prusa/repos/meta-sl1` exists
  - If not, clone it: `git clone git@gitlab.com:prusa3d/sl1/meta-sl1.git ~/.playground/prusa/repos/meta-sl1`
- Fetch latest: `git -C ~/.playground/prusa/repos/meta-sl1 fetch --tags`
- Verify both tags exist: `git -C ~/.playground/prusa/repos/meta-sl1 tag -l '<old_tag>' '<new_tag>'`
- Check if `~/.playground/prusa/release-notes` exists
  - If not, create it: `mkdir -p ~/.playground/prusa/release-notes`

### 2. Identify Changed Recipes
- Diff the two tags to find which `.bb` recipe files changed:
  `git -C ~/.playground/prusa/repos/meta-sl1 diff <old_tag>..<new_tag> -- '*.bb'`
- Extract the old and new `SRCREV` for each changed recipe
- Also extract the git URL (`SRC_URI`) and the machine override (e.g. `prusa-rpi-slx`, `prusa64-sl1`) if present
- Build a mapping of: recipe name → repo URL → old SRCREV → new SRCREV

### 3. Ensure Repos Are Cloned
- For each changed recipe, check if the corresponding repo is cloned under `~/.playground/prusa/repos/`
- If not, clone it — use SSH URLs for GitLab repos (`git@gitlab.com:...`), HTTPS for GitHub
- Fetch latest in each repo: `git fetch`
- Only clone repos that have actually changed — do not clone all firmware repos

### 4. Gather Commit Logs
- For each changed recipe, run in the local repo:
  `git log --oneline --no-merges <old_srcrev>..<new_srcrev>`
- Record the commit hashes and messages

### 5. Analyze Commit Content
- Do NOT rely solely on commit messages — read the actual diffs to understand what changed
- For each commit, run `git show <hash>` to see the full diff
- Use parallel agents to analyze multiple repos simultaneously
- For each commit, determine:
  - What actually changed in the code (not just what the message says)
  - Which device(s) it affects (SLX, WX, CX, SL1, or all)
  - Whether it is user-facing or developer-facing
  - The correct conventional commit type: `feat`, `fix`, `refactor`, `chore`, `ci`
  - The Jira issue ID if present in the commit message (pattern: `SL1SW-XXXX`)

### 6. Categorize Changes
- Split all changes into two groups:
  1. **User-facing** — anything an end user would notice (UI changes, new features, behavior changes, crash fixes)
  2. **Developer-facing** — internal plumbing (refactoring, logging, CI, dependency bumps, code formatting)
- Within each group, organize by device:
  - Device-independent changes come first, with no device heading
  - Then per-device sections: SLX, WX, CX, SL1, or combinations (e.g. WX + CX) to avoid duplicate entries
- Within each device section, organize by change type: Features, then Bug Fixes (user-facing) or Features, Refactoring, Maintenance (developer-facing)
- Within each type, sort by importance (descending)

### 7. Write Release Notes
- Save to `~/.playground/prusa/release-notes/<new_tag>.md`
- Follow this format exactly:

```markdown
# Version <new_tag>

## Firmware for <devices>

#### Features
- **feat: user-friendly description of the change** *(SL1SW-XXXX)*

#### Bug Fixes
- **fix**: user-friendly description of the fix *(SL1SW-XXXX)*

### <Device>

#### Features
- **feat: user-friendly description** *(SL1SW-XXXX)*

#### Bug Fixes
- **fix**: description *(SL1SW-XXXX)*

---

#### Features
- **feat(<repo>): technical description** *(SL1SW-XXXX)*

#### Refactoring
- **refactor**(<repo>): technical description

#### Maintenance
- **chore**(<repo>): technical description
- **ci**(<repo>): technical description

### <Device>

#### Features
- **feat(<repo>): technical description** *(SL1SW-XXXX)*
```

### 8. Formatting Rules
- The `## Firmware for ...` line lists the device families that have changes (e.g. `SLX/WX/CX`)
- User-facing and developer-facing sections are separated by a single `---` with no headings
- Feature entries are fully bold: `- **feat: ...**` or `- **feat(<repo>): ...**`
- Non-feature entries have only the type bold: `- **fix**: ...` or `- **fix**(<repo>): ...`
- Jira issue IDs go at the end in italic parentheses: `*(SL1SW-XXXX)*`
  - Only include if the commit message contains one — do not fabricate IDs
- Names, identifiers, and technical terms should be bold (e.g. **printer0**, **DBus**, **SLA**)
  - Exception: inside fully-bold feature lines, everything is already bold — do not nest `**`
- Do not include the repository in user-facing entries — users don't care which repo changed
- Do include the repository in developer-facing entries — developers need to know where the change happened
  - Exception: omit the repository if the change already makes it obvious (e.g. "resolve cooling fans not working" is clearly base-board-fw)
- User-facing entries should be written from the user's perspective:
  - Describe what changed for the user, not the technical implementation
  - Avoid internal jargon (e.g. "unclosed file descriptor" → "display subsystem not releasing resources")
  - Use natural language (e.g. "resin can now be stirred automatically" not "add resin stirring control")
- Developer-facing entries use conventional commit style with imperative mood (e.g. "add", "resolve", "move", "rename")
- Do not include the device name in entries when they are already grouped under that device's heading
- Use combined device headings (e.g. `WX + CX`) to avoid duplicate entries
- Heading hierarchy: `#` version, `##` firmware subtitle, `###` devices, `####` change types
