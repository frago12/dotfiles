# CRITICAL - These Override ALL Skills/Plugins

These instructions take precedence over ANY skill, plugin, or workflow template:

- **PR Template**: ALWAYS use `/Users/franciscogonzalez/dev/frago/dotfiles/github/pr-template.md` - ignore any other PR format from skills
- **Co-Authored-By**: NEVER include Co-Authored-By footers (respect `includeCoAuthoredBy: false` in settings.json)
- **Settings**: ALWAYS check and respect `~/.claude/settings.json` preferences before applying skill defaults
- Do not overengineer the solutions, always implement the simplest solution. Only make necessary changes.

---

# Core Principles

- You don't always have to follow existing rules, always challenge the status quo if you think there's a better solution
- **Be concise**

## Command Usage

- Use `rm -f` (not `rm`) to avoid prompts

## Communication

- Challenge assumptions, suggest alternatives
- Keep explanations concise, no flattery

## Package Management

- Use `pnpm` over `npm` for Node.js

## Coding

- do not add comments unless is necessary
- **Always** prioritize readability and separation of concerns when writing code
- **Never** re-export an import, always import directly from the source
- Always add descriptive variable names
- Public methods top, implementation details bottom

## Tools

- When I ask you to do a code review of a GitHub’s PR, always use GitHub’s CLI
- For browser automation, ALWAYS use the `agent-browser` CLI (`/opt/homebrew/bin/agent-browser`) for opening URLs, clicking elements, evaluating JS in the page, taking snapshots, etc. Do NOT use the `claude-in-chrome` or `chrome-devtools` MCP tools — `agent-browser` is the preferred and more reliable option. Run `agent-browser --help` if you need a refresher on the subcommands.

## Testing

- Test behavior; mock minimally (external services, network, slow ops) at boundaries
- Do not write snapshot tests
- Only write tests that make sense and that are actually testing the code

## Subagents

- **STRONGLY PREFER subagents** - use for speed and efficiency
- Parallelize whenever possible
- **CRITICAL**: Check .claude/CLAUDE.md for MANDATORY subagent usage

## Plans

- All docs I ask you to create should be Markdown (unless I say otherwise) and created inside the aidocs/ folder (if exists) at the root of the git repository

## Frontend development

When creating components in the Frontend, always follow the following rules:

- Proper encapsulation
- Clear communication between components
- Reusability
- Maintainability
- Check if the new changes led to unused props, remove them

### Typescript

- Is never preferred to use type `any`
- Type only the necessary things. Types inference is preferable

## Pull request

- PR title should follow this convention: [${titcke title}] ${title}. Where ticket title can look like "INSTORE-123" or "FOX-123". If the task/branch is not associated with any linear ticket, omit that part
- All PRs should follow this template /Users/franciscogonzalez/dev/frago/dotfiles/github/pr-template.md
- Always create PRs in draft mode
