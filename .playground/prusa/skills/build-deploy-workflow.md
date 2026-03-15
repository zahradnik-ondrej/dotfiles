## Workflow: Build and Deploy Image

Follow these steps in order without stopping for approval:

### 0. Pre-flight Checks
- Check if `~/.playground/prusa/repos` directory exists
  - If not, create it: `mkdir -p ~/.playground/prusa/repos`
- Check if `~/.playground/prusa/repos/meta-sl1` directory exists
  - If not, clone it:
    `git clone git@gitlab.com:prusa3d/sl1/meta-sl1.git ~/.playground/prusa/repos/meta-sl1`
- Check if `~/.playground/prusa/images` directory exists
  - If not, create it: `mkdir -p ~/.playground/prusa/images`

### 1. Gather MR Details
- For each provided MR link use `glab` to retrieve the source branch:
  `glab api projects/<encoded_repo_path>/merge_requests/<mr_id> | python3 -c "import sys,json; d=json.load(sys.stdin); print('SOURCE:', d['source_branch'])"`
- Store these for use in step 3

### 2. Create a New Branch
- Checkout and pull the latest `sl2` branch
- Deduce a short description from the MR titles
- Name the new branch following this convention:
  `SL1SW-<issue_id>-fix/feat-<scope>-<issue_description>`
  e.g. `SL1SW-3266-fix-slx-shutdown-from-job-finished`
  e.g. `SL1SW-XXXX-feat-slx-loadcell-weight-calculation`
- If no issue ID is available use `XXXX` as the placeholder

### 3. Modify Yocto Recipes
- Update the source branch references in all relevant Yocto recipes
  based on the source branches gathered in step 1
- Do not commit anything

### 4. Run Update Script
- Run `./update_project.py` from the root of the `meta-sl1` repository
- This must always run after recipe modifications

### 5. Push and Trigger Pipeline
- Push the new branch to origin
- Manually trigger the pipeline: `glab ci run --branch <branch_name>`
- List pipeline jobs and locate `b:raucb-development-slx` job ID
- Cancel unnecessary jobs to free up CI resources:
  - Cancel all `b:*` and `d:*` jobs **except** `b:raucb-development-slx` and `d:raucb-development-slx`
  - Use: `glab api --method POST projects/prusa3d%2Fsl1%2Fmeta-sl1/jobs/<job_id>/cancel`
  - Only cancel jobs that are in `created`, `pending`, or `running` status
- Check the `b:raucb-development-slx` job status before attempting to play it — it may have already started automatically
- If status is `running` or `success`, skip playing it and proceed to polling
- If status is `created` or `pending`, start it: `glab api --method POST projects/prusa3d%2Fsl1%2Fmeta-sl1/jobs/<job_id>/play`
- If the job returns `400 Unplayable Job`, wait 10 seconds and retry
- Poll build job status every 60 seconds until it succeeds or fails
- If the build job fails, report the failure log and stop
- Once the build job succeeds, start the deploy job `d:raucb-development-slx` and do not wait for it to finish

### 6. Download Artifacts
- Follow the artifact download steps in the GitLab API skill
- If the user chose not to deploy, stop here and report the saved image path
