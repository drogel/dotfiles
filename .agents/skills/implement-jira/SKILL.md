---
name: implement-jira
description: Fetch a Jira task, distill context, and delegate implementation to a sub-agent.
---

# Implement Jira Task

End-to-end implementation of a Jira task — from ticket pickup to review-ready code.

The main agent acts as an **orchestrator**: it gathers context, distills it, and delegates the actual implementation to a sub-agent with a fresh context window. This keeps the implementation agent focused and avoids running out of context after lengthy research.

## Invocation

```
/implement-jira AWHL-1234
/implement-jira AWHL-1234 @../../studies/AWHL-1234.md
/implement-jira AWHL-1234 "use the new payments SDK for this"
```

## Inputs

- **Jira issue ID** (required): e.g. `AWHL-1234`
- **Additional context** (optional): free-text hints or a design-doc reference (e.g. `@../../studies/AWHL-1234.md`)

## Prerequisites

This skill depends on the **atlassian-cli** skill for all Jira interactions. Refer to it for `acli` command syntax, authentication, and best practices.

**Before starting:** verify that `acli` is installed (`which acli`) and authenticated (`acli auth status`). If either check fails, **stop and ask the user** — do not proceed without a working `acli` setup.

## Workflow

### 1. Gather Context

Using `acli`, fetch the Jira issue details (summary, description, acceptance criteria).
If the user provided a design-doc reference, read that file too and use it as high-level project context.

### 2. Claim the Issue

Using `acli`:
- Assign the issue to the current user.
- Transition the issue to "In Progress". If the transition fails, check the available transitions and adapt.

### 3. Create a Feature Branch

Derive a short, kebab-case description from the Jira summary (ASCII only, max ~5 words).

```sh
git checkout -b "feature/<ISSUE_ID>-<short-description>"
```

Branch from the repo's **main branch** (e.g. `master` or `main`) unless the user explicitly says otherwise.

### 4. Distill an Implementation Brief

Before delegating, prepare a **concise implementation brief** for the sub-agent. This is the most critical step — the quality of the brief determines the quality of the implementation.

The brief must include:

1. **Objective** — one or two sentences describing what needs to be done and why.
2. **Acceptance criteria** — the concrete conditions from the Jira ticket that the implementation must satisfy.
3. **Key files and locations** — list the specific files, modules, or directories the sub-agent should read and modify. Include paths, not vague references.
4. **Patterns to follow** — describe (or point to) the existing code patterns, naming conventions, and architectural style the sub-agent should match. If there is a similar feature already implemented, reference it as a model.
5. **Verification instructions** — how to run linting, formatting, and tests (e.g. `make verify`, or the specific commands).
6. **Out of scope** — anything the sub-agent should explicitly **not** do (e.g. refactoring unrelated code, adding features not in the ticket).

**Guidelines for the brief:**
- Be specific and actionable. Prefer concrete file paths and code references over abstract descriptions.
- Strip out noise — only include what the sub-agent needs to implement the feature. Do not dump the entire design doc or Jira ticket verbatim.
- If the design doc contains architectural decisions or trade-offs relevant to implementation, summarize them in a sentence or two.
- If something in the ticket is ambiguous, resolve it with the user **before** writing the brief.

### 5. Implement (Sub-Agent)

Spawn a **sub-agent** (using the Agent tool with `subagent_type: "general-purpose"` and a description like `"implement <ISSUE_ID>"`) to perform the implementation with a fresh context window.

Pass the sub-agent the implementation brief from Step 4 and instruct it to:

1. Read the key files listed in the brief to understand the existing code.
2. Implement the changes described in the objective, satisfying all acceptance criteria.
3. Follow the patterns and conventions specified in the brief.
4. Keep changes focused — only what the brief asks for.
5. Run verification using the instructions in the brief and fix any issues.
6. Create a conventional commit:
   ```
   <type>(<scope>): <brief description>
   ```
   Where `<type>` is `feat`, `fix`, `refactor`, etc. as appropriate.

### 6. Review (Sub-Agent)

Spawn a **separate sub-agent** to review the changes with a clean context window, to avoid implementation bias.

The review sub-agent must:

1. Look for a review skill or command in the current project (search for skills/commands containing "review" in the repo's `.claude/`, `.cursor/`, or `.agents/` directories).
2. If a review skill exists, follow its instructions.
3. If no review skill exists, perform a structured review covering:
   - Correctness: does the implementation match the ticket requirements?
   - Code quality: readability, naming, duplication.
   - Safety: no security vulnerabilities, no broken error handling.
   - Tests: are relevant cases covered?

Provide the review sub-agent with:
- The acceptance criteria from the Jira ticket.
- The diff of changes (`git diff HEAD~1`).

### 7. Iterate on Review Findings

After receiving the review:

- Fix all **critical** and **major** issues — these fixes may be done by spawning another implementation sub-agent with targeted instructions, or directly if the fixes are small.
- Minor and cosmetic issues may be noted but do not block.
- Run verification again after fixes.
- Commit the fixes as a separate conventional commit.

**Maximum 2 review rounds.** If critical issues remain after 2 rounds, stop and hand over to the user with a summary of outstanding items.

### 8. Hand Over

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
- If something is ambiguous in the ticket, ask the user **before** delegating to the implementation sub-agent.
- The orchestrator (main agent) should avoid reading large amounts of source code itself — that is the sub-agent's job. The orchestrator's role is to identify *what* to read, not to read it all.
