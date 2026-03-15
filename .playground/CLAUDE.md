@prusa/skills/gitlab-api.md
@prusa/skills/build-deploy-workflow.md
@prusa/skills/device-install.md
@prusa/skills/release-notes.md
@vos/skills/moodle-assignments.md

## Startup Checks
Run these automatically and immediately when the session starts, without waiting for any user input:

1. Ask the user what they want to work on and wait for their response:
   - **Prusa** — firmware build, deploy, or release notes
   - **School (VOŠ)** — Moodle assignments or tests
2. Based on their answer:
   - **Prusa**: Ask for one or more GitLab MR links and whether they want to deploy the image to a device after building
   - **School**: Ask for their MoodleSession cookie and which course they want to work on
