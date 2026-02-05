---
name: forage:remove-session
description: This skill removes a working session by deleting the worktree, local branch, optionally the remote branch, and the tmux session.
---

# Remove Working Session

This skill cleans up a working session by removing all associated resources.

## What This Skill Does

1. **Asks for session name** - User provides session/worktree name
2. **Deletes worktree** - Removes the worktree from ~/dev/worktrees/
3. **Deletes local branch** - Removes the git branch locally
4. **Optionally deletes remote branch** - If branch exists on origin, asks user
5. **Deletes tmux session** - Kills the tmux session

## Constants

| Constant | Value |
|----------|-------|
| Main repo | `/Users/franciscogonzalez/dev/fe-monorepo` |
| Worktrees directory | `~/dev/worktrees/` |

## Workflow Steps

**CRITICAL:** Follow these steps exactly. Do NOT add extra questions.

### Step 1: Ask for Session Name

Simply ask the user: "What is the name of the session to remove?"

Wait for text input. The user will provide the session name (e.g., `FOX-123`).

### Step 2: Validate Session Exists

Check if the worktree exists:

```bash
ls -d ~/dev/worktrees/{name} 2>/dev/null
```

If the worktree doesn't exist, inform the user and stop:

> Session `{name}` not found at `~/dev/worktrees/{name}`. No action taken.

### Step 3: Get Branch Name from Worktree

Get the branch name associated with the worktree:

```bash
git -C ~/dev/worktrees/{name} branch --show-current
```

Store this as `{branch-name}` for later steps.

### Step 4: Kill Tmux Session

Check if tmux session exists and kill it:

```bash
tmux has-session -t {name} 2>/dev/null && tmux kill-session -t {name}
```

If session existed, inform user: "Killed tmux session `{name}`"

If session didn't exist, inform user: "No tmux session `{name}` found (skipping)"

### Step 5: Remove Worktree

Navigate to main repo and remove the worktree:

```bash
cd /Users/franciscogonzalez/dev/fe-monorepo
git worktree remove ~/dev/worktrees/{name}
```

Inform user: "Removed worktree at `~/dev/worktrees/{name}`"

### Step 6: Delete Local Branch

Delete the local branch:

```bash
cd /Users/franciscogonzalez/dev/fe-monorepo
git branch -d {branch-name}
```

If deletion fails (unmerged changes), ask user if they want to force delete:

> Branch `{branch-name}` has unmerged changes. Force delete? (y/n)

If yes:
```bash
git branch -D {branch-name}
```

Inform user: "Deleted local branch `{branch-name}`"

### Step 7: Check Remote Branch

Check if branch exists on origin:

```bash
cd /Users/franciscogonzalez/dev/fe-monorepo
git ls-remote --heads origin {branch-name}
```

If the branch exists on origin (command returns output), ask the user:

> Branch `{branch-name}` exists on origin. Do you want to delete it? (y/n)

If yes:
```bash
git push origin --delete {branch-name}
```

Inform user: "Deleted remote branch `origin/{branch-name}`"

If no, inform user: "Kept remote branch `origin/{branch-name}`"

If the branch doesn't exist on origin, skip this step silently.

### Step 8: Summary

Provide a summary of what was done:

```
✅ Session {name} removed:
   - Worktree: ~/dev/worktrees/{name} (deleted)
   - Local branch: {branch-name} (deleted)
   - Remote branch: {deleted/kept/not found}
   - Tmux session: {killed/not found}
```

## Complete Example

For removing a session named `FOX-123` with branch `FOX-123-feature`:

```bash
# Get branch name
git -C ~/dev/worktrees/FOX-123 branch --show-current
# Returns: FOX-123-feature

# Kill tmux session
tmux kill-session -t FOX-123

# Remove worktree
cd /Users/franciscogonzalez/dev/fe-monorepo
git worktree remove ~/dev/worktrees/FOX-123

# Delete local branch
git branch -d FOX-123-feature

# Check if remote exists
git ls-remote --heads origin FOX-123-feature
# If exists, ask user, then:
git push origin --delete FOX-123-feature
```

## Troubleshooting

### Worktree has uncommitted changes

If the worktree has uncommitted changes, `git worktree remove` will fail. Ask user if they want to force remove:

```bash
git worktree remove --force ~/dev/worktrees/{name}
```

### Branch is checked out elsewhere

If the branch is checked out in another worktree, the deletion will fail. Inform the user which worktree has the branch checked out.
