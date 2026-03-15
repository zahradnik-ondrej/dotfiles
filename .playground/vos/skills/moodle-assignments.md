# Moodle Assignment Solver

Solve and submit unfinished Moodle assignments for a given course.

## Input

The user provides:
1. **MoodleSession cookie** — the session cookie value from their browser
2. **Moodle URL** — the base URL of the Moodle instance (ask if not already known)
3. **Course name** — a short name or keyword to identify the course

## Procedure

### Phase 1: Discovery

1. Set variables:
   - `COOKIE="MoodleSession=<value>"`
   - `BASE` — the Moodle instance URL (ask the user if not already known)
   - `SESSKEY` — extract from any Moodle page: `grep -oP '"sesskey":"[^"]+' | cut -d'"' -f4`
   - `USERID` — extract from any Moodle page: `grep -oP '"userId":\d+' | grep -oP '\d+'`

2. List enrolled courses via AJAX:
   ```bash
   curl -s -b "$COOKIE" \
     "$BASE/lib/ajax/service.php?sesskey=$SESSKEY&info=core_course_get_enrolled_courses_by_timeline_classification" \
     -H "Content-Type: application/json" \
     -d '[{"index":0,"methodname":"core_course_get_enrolled_courses_by_timeline_classification","args":{"offset":0,"limit":0,"classification":"all","sort":"fullname"}}]'
   ```
   Parse the JSON to find courses matching the user's keyword. Match against both `fullname` and `shortname`. A course keyword like "uds" may match multiple courses (e.g. exercises + materials). Identify which are exercise/assignment courses and which are material/lecture courses.

3. For each matching course, fetch the course page:
   ```bash
   curl -s -b "$COOKIE" "$BASE/course/view.php?id=<COURSE_ID>"
   ```
   Extract all activity links using grep/python — look for `mod/assign/view.php?id=`, `mod/resource/view.php?id=`, `mod/page/view.php?id=`, `mod/folder/view.php?id=`, `mod/url/view.php?id=`.

4. For each assignment (`mod/assign`), fetch the assignment page and extract:
   - Title
   - Description/instructions (the HTML inside the assignment intro)
   - Due date
   - Submission status ("Dosud nebyla odeslána" = not submitted, "Odesláno k hodnocení" = submitted)
   - Grading status
   - Any attached files (download them)
   - Any linked pages (`mod/page/view.php`) referenced in the description — fetch and extract their content too

5. Identify **unsubmitted assignments** — these are the ones to solve.

### Phase 2: Scraping (backup)

The session cookie can expire at any time (logout, timeout). Before doing any work, scrape and cache everything needed locally so that solving can proceed even if access is lost.

1. **Check for existing course directory:**
   - Look for `<working-dir>/<course>/`
   - If it doesn't exist, create it

2. **Scrape to /tmp/ first:**
   - Save all raw HTML pages to `/tmp/moodle_<course>/` as a working cache
   - For each unsubmitted assignment, fetch and save:
     - The assignment page HTML (description, requirements, due date)
     - Any files attached to the assignment
     - Any pages/resources linked from the assignment description
   - From material/lecture courses, fetch only the resources that are relevant to the unsubmitted assignments (don't scrape the entire course if not needed)
   - Convert assignment descriptions and referenced pages to plain text or markdown for easy reading

3. **What to scrape:**
   - Only what is needed to complete the unsubmitted assignments
   - Assignment descriptions and their linked reference pages
   - Attached template files or starter code
   - Relevant lecture materials (slides, example scripts, reference docs) that the assignment references or that cover the assignment topic
   - Do NOT scrape the entire course — be targeted

### Phase 3: Solving

For each unsubmitted assignment:

1. **Analyze the requirements** — read the assignment description carefully and extract a numbered list of specific requirements.

2. **Write the solution** following these rules:
   - **Minimal code** — no extra features, no unnecessary error handling, no comments beyond what the assignment explicitly requires. Just enough to meet each requirement.
   - **Language split** — all user-facing text (prints, menus, prompts, output) in Czech. All code-level identifiers (variables, functions, classes) in English.
   - **No extra dependencies** — use only the standard library of the language unless the assignment explicitly requires an external library or the user requests one.
   - Keep the solution straightforward and student-appropriate — no over-engineering.

3. **Check prerequisites** — if the solution requires any tools, runtimes, or packages that aren't installed on the user's machine (e.g. `php`, `dotnet`, `mysql`, `python`, a specific library), don't attempt to install them automatically. Instead, ask the user to install them and provide the exact commands for their current OS/distro so they can copy-paste without friction.

4. **Save the solution** to `<working-dir>/<course>/<assignment-slug>/`
   - The course directory contains ONLY assignment solution directories — no scraped materials, no index files
   - Each assignment gets its own directory named after the assignment (slugified, e.g. `bash-zaklady`, `python-1`)
   - Scraped source materials stay in `/tmp/` and are not part of the final output

### Phase 4: Verification

For each solved assignment, perform two control actions:

1. **Test the solution:**
   - Run the code to verify it executes without errors
   - Test with multiple inputs covering normal cases, edge cases, and boundary values
   - For interactive programs, pipe in various input sequences
   - For scripts with CLI args, test different flags and invalid inputs
   - Fix any issues found

2. **Requirements checklist:**
   - Create a table with all requirements extracted from the assignment
   - Verify each requirement is met in the code
   - Print the table with ✅ or ❌ next to each requirement
   - If any requirement has ❌, fix the code and re-verify

### Phase 5: User Review

Present the user with:
- A summary of what was solved
- The requirements checklist table for each assignment
- Ask: **"Chcete odevzdat úkoly v této podobě?"** (Do you want to submit the assignments in this form?)

Only proceed to submission if the user confirms.

### Phase 6: Submission

For each assignment to submit:

1. **Fetch the submission form:**
   ```bash
   curl -s -b "$COOKIE" "$BASE/mod/assign/view.php?id=<ID>&action=editsubmission"
   ```
   Extract from the HTML:
   - `itemid` — draft file area ID: `grep -oP '"itemid":(\d+)'`
   - `client_id` — file manager client: `grep -oP '"client_id":"([^"]+)"'`
   - `ctx_id` — context ID: `grep -oP 'ctx_id=(\d+)'` (from the filemanager URL params)
   - `maxfiles` — max allowed files: `grep -oP 'maxfiles=(\d+)'`
   - `maxbytes` — max file size: `grep -oP 'maxbytes=(\d+)'`
   - `lastmodified` — from hidden input: `name="lastmodified" value="..."`
   - All other hidden form fields (`_qf__mod_assign_submission_form`, `mform_isexpanded_id_submissionheader`)

2. **Prepare files:**
   - If the number of files to submit exceeds `maxfiles`, create a .zip archive containing all files
   - Otherwise, submit files individually

3. **Upload files to draft area:**
   ```bash
   curl -s -b "$COOKIE" "$BASE/repository/repository_ajax.php?action=upload" \
     -F "repo_upload_file=@<filepath>" \
     -F "title=<filename>" \
     -F "author=Student" \
     -F "license=unknown" \
     -F "itemid=<itemid>" \
     -F "repo_id=5" \
     -F "p=" -F "page=" \
     -F "env=filemanager" \
     -F "sesskey=$SESSKEY" \
     -F "client_id=<client_id>" \
     -F "maxbytes=<maxbytes>" \
     -F "areamaxbytes=-1" \
     -F "ctx_id=<ctx_id>" \
     -F "savepath=/"
   ```
   Verify the response contains `"file": "<filename>"`.

4. **Save the submission:**
   ```bash
   curl -s -b "$COOKIE" "$BASE/mod/assign/view.php" \
     -d "lastmodified=<lastmodified>" \
     -d "id=<assignment_page_id>" \
     -d "userid=<USERID>" \
     -d "action=savesubmission" \
     -d "sesskey=$SESSKEY" \
     -d "_qf__mod_assign_submission_form=1" \
     -d "mform_isexpanded_id_submissionheader=1" \
     -d "files_filemanager=<itemid>" \
     --data-urlencode "submitbutton=Uložit změny" \
     -L
   ```

5. **Verify submission:**
   ```bash
   curl -s -b "$COOKIE" "$BASE/mod/assign/view.php?id=<ID>"
   ```
   Confirm the page shows "Odesláno k hodnocení" and lists the uploaded file(s).

6. Report results to the user.

### Phase 7: Outstanding Items Overview

After all submissions are done (or if the user just asks for an overview), scan **all** enrolled courses and present a summary table of items that still need attention.

1. **Fetch all enrolled courses** via the AJAX API.
2. **Fetch every course page** and extract all `mod/assign` and `mod/quiz` activity links.
3. **Fetch each activity page** and determine its status:
   - **Assignments**: check for "Odesláno k hodnocení" (submitted) vs "Dosud nebyla odeslána" (not submitted). Skip assignments that don't require submission ("Tento úkol nevyžaduje").
   - **Quizzes/Tests**: check current grade, max grade, number of attempts used vs allowed, and whether a start/retry button exists.
4. **Include in the table only:**
   - Unsubmitted assignments (excluding pure bonus/activity grade slots that are already graded)
   - Tests where the user has **not reached the full score** AND still has **attempts remaining**
   - Do NOT include submitted assignments or fully completed tests
5. **Extract for each item:** course name, type (Úkol/Test), activity name, due date (even if past — mark as "prošlý"), and a short note (description summary, current score/attempts for tests).
6. **Output the table** with the heading: `## Neodevzdané úkoly a nedokončené testy`

| Kurz | Typ | Aktivita | Termín | Poznámka |
|------|-----|----------|--------|----------|

### Phase 8: Moodle Tests

When a course has unfinished quizzes/tests (identified in Phase 7), they can be attempted programmatically.

**Before attempting any test, ALWAYS ask the user for approval.** The prompt must include:
- The test name and course
- Current score (if any previous attempts)
- Number of attempts remaining out of total allowed
- The time limit
- A clear warning that this will consume one attempt

Only attempt the test **once** per run (do not retry even if the score is not perfect), unless the user explicitly asks for another attempt.

#### Procedure

1. **Start the attempt:**
   ```bash
   curl -s -b "$COOKIE" "$BASE/mod/quiz/startattempt.php" \
     -d "cmid=<ID>" -d "sesskey=$SESSKEY" \
     -d "_qf__mod_quiz_form_preflight_check_form=1" \
     --data-urlencode "submitbutton=Zahájení pokusu" -L
   ```
   Extract the `attempt=<ATTEMPT_ID>` from the redirect URL.

2. **Fetch all question pages** — quizzes are paginated (one question per page, `page=0..N`). Fetch all pages in parallel to save time against the timer.

3. **Parse each question** by type:
   - `multichoice` — radio buttons: `name="q<ID>:<SLOT>_answer" value="<N>"`
   - `multichoice` (multi-select) — checkboxes: `name="q<ID>:<SLOT>_choice<N>" value="1"`
   - `truefalse` — radio: value `1` = Pravda, value `0` = Nepravda
   - `multianswer` (cloze) — text inputs: `name="q<ID>:<SLOT>_sub<N>_answer"`
   - `shortanswer` / `numerical` — text input: `name="q<ID>:<SLOT>_answer"`
   - `match` — select dropdowns: `name="q<ID>:<SLOT>_sub<N>"`

4. **Answer each question** based on domain knowledge. Submit each page:
   ```bash
   curl -s -b "$COOKIE" "$BASE/mod/quiz/processattempt.php" \
     -d "attempt=<ATTEMPT_ID>" -d "thispage=<N>" -d "nextpage=<N+1>" \
     -d "timeup=0" -d "sesskey=$SESSKEY" -d "slots=<SLOT>" \
     -d "q<ID>:<SLOT>_:sequencecheck=1" -d "<answer fields>" \
     -d "q<ID>:<SLOT>_:flagged=0" -d "next=Další+stránka"
   ```
   Expect 303 redirects on success.

5. **Finalize the attempt:**
   ```bash
   curl -s -b "$COOKIE" "$BASE/mod/quiz/processattempt.php" \
     -d "attempt=<ATTEMPT_ID>" -d "finishattempt=1" -d "timeup=0" \
     -d "slots=" -d "cmid=<ID>" -d "sesskey=$SESSKEY" -L
   ```

6. **Check the result** on the quiz view page — extract the new highest grade and report it to the user.

7. **Save the test record** to `<working-dir>/<course>/<test-slug>/` (same structure as assignment solutions). Save a markdown file containing:
   - Each question's text (and any images/materials referenced in the question)
   - The possible answers (for multiple choice / true-false / matching)
   - The answer you submitted
   - The result per question (if available from the review page)
   - The overall score

### Submission Types

Assignments can have different submission types. When fetching the `editsubmission` page, check which are present:

- **File upload** (`files_filemanager` in form) — upload files or a zip to the draft area, then save
- **Online text** (`onlinetext_editor[text]` in form) — submit text directly (often used for GitHub links)
- **Both** — some assignments have both; fill in whichever is relevant

For **online text** submissions (e.g. GitHub link), include these fields in the save POST:
```bash
--data-urlencode "onlinetext_editor[text]=<the text or URL>"
-d "onlinetext_editor[format]=1"
-d "onlinetext_editor[itemid]=<itemid from form>"
```

### GitHub Workflow

Some assignments require submitting a link to a public GitHub repository. When an assignment says "odevzdejte formou odkazu na GitHub" or similar:

1. **Check GitHub access:**
   - Ask the user for their GitHub username (if not already known)
   - Rely on the SSH agent for key selection — do not specify any explicit SSH key
   - `gh` CLI should be authenticated — verify with `gh auth status`. If not, ask the user to run `gh auth login`.
   - Ask the user for their git name and email (if not already configured globally or in the repo).

2. **Create a public repo:**
   ```bash
   gh repo create <github-username>/<repo-name> --public --description "<description>"
   ```

3. **Initialize git and configure:**
   ```bash
   cd <project-dir>
   git init
   git config user.name "<user's name>"
   git config user.email "<user's email>"
   git remote add origin git@github.com:<github-username>/<repo-name>.git
   ```

4. **Make multiple commits** (assignments often require demonstrating version history):
   - Commit 1: project structure (.csproj, Program.cs, .gitignore)
   - Commit 2: main logic/forms
   - Commit 3: documentation (README.md) or final touches

5. **Push:**
   ```bash
   git push -u origin main
   ```

6. **Submit the repo URL** via Moodle online text submission:
   ```
   https://github.com/<github-username>/<repo-name>
   ```

7. **Always include if the assignment requires it:**
   - `README.md` — Czech description of what the app does and how to use it
   - `.gitignore` — appropriate for the language (e.g. for C#: `bin/`, `obj/`, `.vs/`, `*.user`)

## Course Naming Convention

The user may refer to courses by an abbreviation (e.g. first letters of each word + optional semester number). Map this to the Moodle course name by matching against the enrolled course list. If ambiguous, ask the user to clarify.

The course directory under the working directory uses this same abbreviation (lowercase).

## Directory Structure

```
<working-dir>/
├── <course>/                      # course dir (abbreviation, lowercase)
│   ├── <assignment-slug>/         # assignment solution
│   │   └── solution files...
│   └── <assignment-slug>/
│       └── solution files...
└── ...

/tmp/moodle_<course>/              # temporary scrape cache (not preserved)
├── assign_<id>.html
├── assign_<id>.md
├── page_<id>.md
└── ...
```

## Important Notes

- The session cookie expires when the user logs out or after a period of inactivity. If requests start returning login pages, ask for a fresh cookie.
- `repo_id` for "Upload file" repository may vary per Moodle instance — extract it from the submission form if needed (look for repository options in the filemanager config).
- Always use `ctx_id` from the specific assignment's submission form, not from other pages — it differs per assignment.
- The `lastmodified` value comes from the submission form's hidden input and must match exactly.
- Each time you fetch `editsubmission`, Moodle generates a new `itemid` for the draft area. Files must be uploaded to the same `itemid` that you then reference in the save POST.
- If a save submission silently fails (redirects back to edit page, status unchanged), the most likely cause is a stale `itemid` — refetch the form and re-upload.
