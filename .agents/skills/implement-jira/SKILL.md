---
name: implement-jira
description: Fetch a Jira task, set it up, implement the changes, verify, review, and hand over.
---

# Implement Jira Task

End-to-end implementation of a Jira task — from ticket pickup to review-ready code.

## Inputs

- **Jira issue ID** (required): e.g. `AWHL-1234`
- **Additional context** (optional): free-text hints or a design-doc reference (e.g. `@../../studies/AWHL-1234.md`)

## Prerequisites

This skill depends on the **atlassian-cli** skill for all Jira interactions. Refer to it for `acli` command syntax, authentication, and best practices.

## Workflow

### 1. Gather Context

Using `acli`, fetch the Jira issue details (summary, description, acceptance criteria).
If the user provided a design-doc reference, read that file too and use it as high-level project context.

### 2. Claim the Issue

Using `acli`:
- Assign the issue to the current user.
- Transition the issue to "In Progress". If the transition fails, check the available transitions and adapt.

### 3. Create a Feature Branch

Derive a short, snake_case description from the Jira summary (ASCII only, max ~5 words).

```sh
git checkout -b "feature/<ISSUE_ID>_<short_description>"
```

Branch from the **current branch**.

### 4. Implement

- Read the relevant codebase to understand the existing patterns and architecture **before** making changes.
- Implement the changes described in the Jira task.
- Follow existing code style and conventions in the project.
- Keep changes focused — only what the ticket asks for.

### 5. Verify

Run the project's verification suite. Try, in order:

1. `make verify` — if a `Makefile` with a `verify` target exists.
2. Otherwise, look for project-level agent skills, rules, or docs (e.g. `CLAUDE.md`, `AGENTS.md`, `README.md`, `Makefile`) that describe how to lint, format, and test.
3. If nothing is found, ask the user how to verify.

Fix any issues surfaced by verification before proceeding.

### 6. Commit

Create a conventional commit that references the Jira issue:

```
<type>(<scope>): <brief description>
```

Where `<type>` is `feat`, `fix`, `refactor`, etc. as appropriate.
The commit message should concisely describe **what** changed and **why**.

### 7. Review (Sub-Agent)

Spawn a **sub-agent** to review the changes with a clean context window, to avoid implementation bias.

The sub-agent must:

1. Look for a review skill or command in the current project (search for skills/commands containing "review" in the repo's `.claude/`, `.cursor/`, or `.agents/` directories).
2. If a review skill exists, follow its instructions.
3. If no review skill exists, perform a structured review covering:
   - Correctness: does the implementation match the ticket requirements?
   - Code quality: readability, naming, duplication.
   - Safety: no security vulnerabilities, no broken error handling.
   - Tests: are relevant cases covered?

Provide the sub-agent with:
- The Jira issue description (so it can verify requirements).
- The diff of changes (`git diff HEAD~1`).

### 8. Iterate on Review Findings

After receiving the review:

- Fix all **critical** and **major** issues.
- Minor and cosmetic issues may be noted but do not block.
- Run verification again after fixes.
- Commit the fixes as a separate conventional commit.

**Maximum 2 review rounds.** If critical issues remain after 2 rounds, stop and hand over to the user with a summary of outstanding items.

### 9. Hand Over

Once the review passes (or the 2-round cap is reached):

- Present a summary to the user:
  - What was implemented and why.
  - Key decisions made during implementation.
  - Outstanding items (if any) from the review.
  - The branch name, ready for the user to push and open a PR.
- **Do NOT** push, create a PR, or merge. The user handles that.

## Notes

- This skill is agent-agnostic — it works in both Claude Code and Cursor CLI.
- Do not over-engineer or add features beyond what the ticket requests.
- If something is ambiguous in the ticket, ask the user before guessing.
