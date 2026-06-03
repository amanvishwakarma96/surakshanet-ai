# Agent Workflow

SurakshaNet AI uses role-based task sequencing so future Codex work stays organized, scoped, and reviewable.

## Standard Workflow

1. Product Manager creates user stories.
2. Architect defines technical plan.
3. DB Engineer creates schema.
4. Backend Developer implements APIs.
5. Flutter Developer implements app screens.
6. AI Agent adds verification logic.
7. QA Agent tests.
8. Security Agent reviews.
9. Documentation Agent updates README.
10. Engineering Manager reviews status and next tasks.

## Working Rules

* Each agent should work from a GitHub issue template matching its role.
* Each task should list objective, scope, allowed files, acceptance criteria, testing notes, and security/privacy notes.
* Agents must avoid expanding a task into a full-project implementation.
* Cross-module dependencies should be recorded as blockers or follow-up tasks.
* Sensitive behavior requires documentation and audit expectations before implementation.

## Engineering Manager Review Checklist

* Is the task scoped to the correct phase?
* Are files limited to the allowed folder set?
* Are privacy and audit rules considered?
* Are tests or documentation updates included?
* Is the next task clear and small enough for a future PR?
