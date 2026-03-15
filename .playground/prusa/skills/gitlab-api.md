## GitLab API Notes
- Use `glab` for all GitLab interactions
- `glab ci list --pipeline <id>` does not work — always use the API directly to list jobs:
  `glab api projects/prusa3d%2Fsl1%2Fmeta-sl1/pipelines/<pipeline_id>/jobs`
- `glab job artifact` returns 404 for this repo — do not use it
- `glab ci artifact` is deprecated — do not use it
- `glab api` does not support binary file output — always use `curl` for artifact downloads
- The numeric project ID for `meta-sl1` is `12500645`

## Triggering Jobs
- Trigger a pipeline manually:
  `glab ci run --branch <branch_name>`
- Start a specific job manually via API:
  `glab api --method POST projects/prusa3d%2Fsl1%2Fmeta-sl1/jobs/<job_id>/play`
- List jobs for a pipeline:
  `glab api projects/prusa3d%2Fsl1%2Fmeta-sl1/pipelines/<pipeline_id>/jobs`
- Parse job ID and status with python3:
  `... | python3 -c "import sys,json; jobs=json.load(sys.stdin); [print(j['id'], j['name'], j['status']) for j in jobs]"`

## Monitoring Jobs
- Poll job status every 60 seconds using a bash while loop
- Check status via: `glab api projects/prusa3d%2Fsl1%2Fmeta-sl1/jobs/<job_id> | python3 -c "import sys,json; print(json.load(sys.stdin)['status'])"`
- Print timestamp and status each iteration: `echo "$(date '+%H:%M:%S') - Job status: $STATUS"`
- Break the loop when status is either `success` or `failed`
- Sleep 60 seconds between each check

## Downloading Artifacts
- `glab api` does not support binary file output — always use `curl`
- The GitLab token is stored as OAuth2 and is `None` in the YAML config — do not try to read it from the config file
- Extract the token from `glab auth status -t` output by parsing the `Token found:` line:
  `TOKEN=$(glab auth status -t 2>&1 | grep -oP 'Token found: \K\S+')`
- Always use `Authorization: Bearer <token>` header (never `PRIVATE-TOKEN` — that returns 401)
- Always use `-L` to follow redirects
- Download artifacts to a temporary directory:
  `TMPDIR=$(mktemp -d)`
  `curl -L --header "Authorization: Bearer $TOKEN" -o $TMPDIR/artifacts.zip "https://gitlab.com/api/v4/projects/12500645/jobs/<job_id>/artifacts"`
- Extract and locate the image:
  `cd $TMPDIR && unzip -o artifacts.zip && find . -name "*.dev-key.raucb"`
- Copy only the `.dev-key.raucb` file to `~/.playground/prusa/images/`
- Clean up: `rm -rf $TMPDIR`
