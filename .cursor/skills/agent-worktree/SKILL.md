---
name: agent-worktree
description: Create a git worktree for a subtask, open a tmux window split, and start a new agent with an initial prompt.
---
# Agent Worktree

Create a new worktree for a subtask and launch a new agent in a tmux window split.

## When to Use
- You need to delegate a small, well-scoped subtask to a new agent.
- You want a dedicated worktree and tmux window for that subtask.

## Inputs Required
- Current worktree root (the skill is invoked from inside a worktree).
- Subtask identifier and short description (e.g. `ABC-124` or `123` + `localization_management_migration`).
- Base branch to branch from (detect from `origin/HEAD` if not provided).
- Initial prompt content derived from the spec doc task list.

## Instructions
1. Identify the repo root and verify the current worktree is clean. If there are uncommitted changes, stop and ask the user to clean or stash them.
2. Assume the current directory is the worktree root.
3. Build a worktree name:
   - If a Jira subtask ID or GitHub issue number exists: `<ID>_<brief_description>`
   - Otherwise: `<brief_description>`
   - Use ASCII, replace spaces with underscores, avoid special characters.
4. Determine the base branch:
   - Prefer `origin/HEAD` (e.g. `origin/master` or `origin/main`).
5. Ensure the worktree does not already exist:
   - Check `git worktree list` and the target directory.
6. Create the worktree and branch as a sibling directory:
   - Use the worktree name as the branch name.
7. Open a tmux window in the new worktree, split vertically, start the agent, using the `agent` CLI command (NOT `cursor`), and send the initial prompt.
8. Continue the parent conversation after the initial prompt is sent.

## Example Commands
Detect base branch:
```
git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'
```

Check clean status:
```
git status --porcelain
```

Create worktree and branch (sibling to current worktree):
```
git worktree add -b "<worktree_name>" "../<worktree_name>" "<base_branch>"
```

Start tmux window and agent in plan mode:
```
tmux new-window -c "../<worktree_name>" \; \
  split-window -h -c "../<worktree_name>" \; \
  send-keys agent Space -p Space --approve-mcps Space "<initial_prompt>" C-m
```

## Notes
- Do not create a worktree if it already exists.
- Do not proceed if there are uncommitted changes.
- The right pane is for the agent, the left pane is for review and git commands.
