---
name: forage:working-session
description: This skill automates setting up isolated working sessions for the fe-monorepo. It creates a git worktree, tmux session, installs dependencies, and starts dev servers for selected apps.
args: "[linear-ticket-url]"
---

# Working Session Setup

This skill automates the complete setup of an isolated development environment for the fe-monorepo.

## What This Skill Does

1. **Validates repository** - Checks if current directory is fe-monorepo
2. **Creates worktree** - Sets up isolated git worktree from specified base branch
3. **Creates tmux session** - Named after the worktree for easy identification
4. **Installs dependencies** - Runs `pnpm i` and `pnpm reset`
5. **Opens VS Code** - Opens the worktree in VS Code
6. **Starts dev servers** - For each selected app in separate tmux windows

## Optional Linear Ticket Argument

If a Linear ticket URL is provided as an argument, the skill will automatically derive:
- **Worktree name**: Lowercase issue ID (e.g., `fox-124`)
- **Branch name**: `francisco/{issue-id}-{title-slug}` (e.g., `francisco/fox-124-fe-update-copy-to-reflect-support-for-non-ebt-refunds`)

**URL Format:** `https://linear.app/{workspace}/issue/{ISSUE-ID}/{title-slug}`

**Example:**
```
/forage:working-session https://linear.app/joinforage/issue/FOX-124/fe-update-copy-to-reflect-support-for-non-ebt-refunds
```

Generates:
- Worktree name: `fox-124`
- Branch name: `francisco/fox-124-fe-update-copy-to-reflect-support-for-non-ebt-refunds`

If no ticket URL is provided, the skill will prompt for worktree name and branch name manually.

## Constants

| Constant | Value |
|----------|-------|
| Main repo | `/Users/franciscogonzalez/dev/fe-monorepo` |
| Worktrees directory | `~/dev/worktrees/` |
| Apps directory | `apps/` |
| Default base branch | `staging` |

## Available Apps

- `checkout`
- `custom-checkout`
- `merchant-dashboard`
- `sdk`
- `refunds`
- `shop-gateway`
- `shop-addon`

## Workflow Steps

**CRITICAL:** Follow these steps exactly. Do NOT add extra questions about work type, categorization, or anything not explicitly listed below.

### Step 1: Validate Repository

Check if the current working directory is the fe-monorepo.

```bash
pwd
```

**Expected:** `/Users/franciscogonzalez/dev/fe-monorepo`

If NOT in fe-monorepo, display warning:

> ⚠️ Warning: You are not in the fe-monorepo (`/Users/franciscogonzalez/dev/fe-monorepo`). This skill is designed to work with the fe-monorepo. Continue anyway?

Use `AskUserQuestion` to confirm whether to proceed.

### Step 2: Determine Worktree Details

**IMPORTANT:** Only ask these exact questions. Do NOT ask about work type, feature vs bugfix, or any other categorization.

#### Option A: Linear Ticket URL Provided

If a Linear ticket URL was provided as an argument, parse it to extract the worktree name and branch name.

**URL Pattern:** `https://linear.app/{workspace}/issue/{ISSUE-ID}/{title-slug}`

**Parsing:**
1. Extract `{ISSUE-ID}` (e.g., `FOX-124`) → convert to lowercase for worktree name (e.g., `fox-124`)
2. Extract `{title-slug}` (e.g., `fe-update-copy-to-reflect-support-for-non-ebt-refunds`)
3. Generate branch name: `francisco/{lowercase-issue-id}-{title-slug}`

**Example:**
- URL: `https://linear.app/joinforage/issue/FOX-124/fe-update-copy-to-reflect-support-for-non-ebt-refunds`
- Worktree name: `fox-124`
- Branch name: `francisco/fox-124-fe-update-copy-to-reflect-support-for-non-ebt-refunds`

Then proceed to **Question: Base branch** below.

#### Option B: No Linear Ticket URL

If no ticket URL was provided, ask for worktree name and branch name manually:

**Question 1: Session name (text input)**

Simply ask the user: "What name would you like for this working session?"

Wait for text input. This name will be used for: worktree directory and tmux session.

**Question 2: New branch name (text input)**

Simply ask the user: "What should the new git branch be named?"

Wait for text input. This will be the name of the new branch created in the worktree.

#### Question: Base branch (Always Ask)

Use `AskUserQuestion` with these options:
- Question: "Which base branch should the worktree be created from?"
- Options:
  1. `staging` (Recommended) - Use the staging branch
  2. Custom - User provides a different branch name via "Other" input

### Step 3: Create Worktree

Create the worktree from the specified base branch:

```bash
cd /Users/franciscogonzalez/dev/fe-monorepo
git fetch origin {base-branch}
git worktree add ~/dev/worktrees/{name} -b {branch-name} origin/{base-branch}
```

Where:
- `{name}` = session name (worktree directory and tmux session)
- `{branch-name}` = new git branch name
- `{base-branch}` = base branch to create from (e.g., staging)

### Step 4: Create Tmux Session

Create a new tmux session with the worktree name:

```bash
tmux new-session -d -s {name} -c ~/dev/worktrees/{name}
```

### Step 5: Install Dependencies

Run dependency installation commands **sequentially in the worktree directory**, showing progress to the user:

**5a. Run pnpm install**

```bash
cd ~/dev/worktrees/{name} && pnpm i
```

Wait for this command to complete before proceeding.

**5b. Run pnpm reset**

```bash
cd ~/dev/worktrees/{name} && pnpm reset
```

Wait for this command to complete before proceeding.

### Step 6: Open VS Code

Open VS Code in the worktree directory:

```bash
code ~/dev/worktrees/{name} -r
```

### Step 7: Select Apps

**After dependencies are installed**, ask the user which apps to start.

Ask the user with this exact message:

```
Which apps would you like to start? (comma-separated)

Available apps: checkout, custom-checkout, merchant-dashboard, sdk, refunds, shop-gateway, shop-addon
```

**Validation:** After receiving input, validate that ALL entered apps are in the available list.

- If ANY app is invalid, show an error and ask again:
  ```
  Invalid app(s): {invalid-apps}

  Please enter only valid apps from: checkout, custom-checkout, merchant-dashboard, sdk, refunds, shop-gateway, shop-addon
  ```
- Keep asking until all entered apps are valid
- Only proceed to Step 8 once validation passes

### Step 8: Setup Each Selected App

For each selected app, perform these steps:

#### 8a. Copy .env file

Copy the `.env` file from the main repo to the worktree:

```bash
cp /Users/franciscogonzalez/dev/fe-monorepo/apps/{app}/.env ~/dev/worktrees/{name}/apps/{app}/.env
```

#### 8b. Create new tmux window

Create a new tmux window for the app:

```bash
tmux new-window -t {name} -n {app} -c ~/dev/worktrees/{name}/apps/{app}
```

#### 8c. Run direnv allow

Allow direnv in the app directory:

```bash
tmux send-keys -t {name}:{app} 'direnv allow' Enter
```

#### 8d. Start dev server

Start the development server:

```bash
tmux send-keys -t {name}:{app} 'pnpm dev' Enter
```

### Step 9: Attach to Session

Inform the user that the session is ready and provide the command to attach:

```bash
tmux attach -t {name}
```

Or if already in tmux:

```bash
tmux switch-client -t {name}
```

## Complete Example

### Example with Linear Ticket URL

For `/forage:working-session https://linear.app/joinforage/issue/FOX-124/fe-update-copy-to-reflect-support-for-non-ebt-refunds`:

- Parsed worktree name: `fox-124`
- Parsed branch name: `francisco/fox-124-fe-update-copy-to-reflect-support-for-non-ebt-refunds`
- Apps: `checkout` and `merchant-dashboard`
- Base branch: `staging`

```bash
# Create worktree (using staging as base branch)
cd /Users/franciscogonzalez/dev/fe-monorepo
git fetch origin staging
git worktree add ~/dev/worktrees/fox-124 -b francisco/fox-124-fe-update-copy-to-reflect-support-for-non-ebt-refunds origin/staging

# Create tmux session
tmux new-session -d -s fox-124 -c ~/dev/worktrees/fox-124

# Install dependencies (run separately, wait for each to complete)
cd ~/dev/worktrees/fox-124 && pnpm i
# Wait for completion...
cd ~/dev/worktrees/fox-124 && pnpm reset
# Wait for completion...

# Open VS Code
code ~/dev/worktrees/fox-124 -r

# Ask user which apps to start (Step 7)
# ...

# Setup checkout app
cp /Users/franciscogonzalez/dev/fe-monorepo/apps/checkout/.env ~/dev/worktrees/fox-124/apps/checkout/.env
tmux new-window -t fox-124 -n checkout -c ~/dev/worktrees/fox-124/apps/checkout
tmux send-keys -t fox-124:checkout 'direnv allow' Enter
tmux send-keys -t fox-124:checkout 'pnpm dev' Enter

# Setup merchant-dashboard app
cp /Users/franciscogonzalez/dev/fe-monorepo/apps/merchant-dashboard/.env ~/dev/worktrees/fox-124/apps/merchant-dashboard/.env
tmux new-window -t fox-124 -n merchant-dashboard -c ~/dev/worktrees/fox-124/apps/merchant-dashboard
tmux send-keys -t fox-124:merchant-dashboard 'direnv allow' Enter
tmux send-keys -t fox-124:merchant-dashboard 'pnpm dev' Enter

# Attach to session
tmux attach -t fox-124
```

### Example without Linear Ticket URL (Manual Input)

For a session named `feature-payments`, branch `instore-1234-payment-flow`, apps `checkout` and `merchant-dashboard`, using `staging` as base branch:

```bash
# Create worktree (using staging as base branch)
cd /Users/franciscogonzalez/dev/fe-monorepo
git fetch origin staging
git worktree add ~/dev/worktrees/feature-payments -b instore-1234-payment-flow origin/staging

# Create tmux session
tmux new-session -d -s feature-payments -c ~/dev/worktrees/feature-payments

# Install dependencies (run separately, wait for each to complete)
cd ~/dev/worktrees/feature-payments && pnpm i
# Wait for completion...
cd ~/dev/worktrees/feature-payments && pnpm reset
# Wait for completion...

# Open VS Code
code ~/dev/worktrees/feature-payments -r

# Ask user which apps to start (Step 7)
# ...

# Setup checkout app
cp /Users/franciscogonzalez/dev/fe-monorepo/apps/checkout/.env ~/dev/worktrees/feature-payments/apps/checkout/.env
tmux new-window -t feature-payments -n checkout -c ~/dev/worktrees/feature-payments/apps/checkout
tmux send-keys -t feature-payments:checkout 'direnv allow' Enter
tmux send-keys -t feature-payments:checkout 'pnpm dev' Enter

# Setup merchant-dashboard app
cp /Users/franciscogonzalez/dev/fe-monorepo/apps/merchant-dashboard/.env ~/dev/worktrees/feature-payments/apps/merchant-dashboard/.env
tmux new-window -t feature-payments -n merchant-dashboard -c ~/dev/worktrees/feature-payments/apps/merchant-dashboard
tmux send-keys -t feature-payments:merchant-dashboard 'direnv allow' Enter
tmux send-keys -t feature-payments:merchant-dashboard 'pnpm dev' Enter

# Attach to session
tmux attach -t feature-payments
```

## Cleanup

When done with the working session, clean up with:

```bash
# Kill tmux session
tmux kill-session -t {name}

# Remove worktree
cd /Users/franciscogonzalez/dev/fe-monorepo
git worktree remove ~/dev/worktrees/{name}

# Delete branch if needed
git branch -d {branch-name}
```

## Troubleshooting

### Worktree already exists

If a worktree with that name already exists:

```bash
git worktree list
```

Either use a different name or remove the existing worktree first.

### Tmux session already exists

If a tmux session with that name already exists:

```bash
tmux list-sessions
```

Either use a different name or kill the existing session:

```bash
tmux kill-session -t {name}
```

### .env file doesn't exist in main repo

If the .env file doesn't exist for an app in the main repo, skip copying and warn the user to create it manually.
