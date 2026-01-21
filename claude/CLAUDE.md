# Core Principles

## Command Usage

- Use `rm -f` (not `rm`) to avoid prompts

## Communication

- Challenge assumptions, suggest alternatives
- Keep explanations concise, no flattery

## Package Management

- Use `pnpm` over `npm` for Node.js

## Code Organization

- Public methods top, implementation details bottom

## Tools

- When I ask you to do a code review of a GitHub’s PR, always use GitHub’s CLI

## Testing

- Test behavior; mock minimally (external services, network, slow ops) at boundaries
- Do not write snapshot tests
- Only write tests that make sense and that are actually testing the code

## Version Control

- Use conventional commits: feat:, fix:, docs:, refactor:, test:, chore:

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
