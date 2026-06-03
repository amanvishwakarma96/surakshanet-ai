# Backend Developer Agent

## Agent Role

Implement .NET 8 API under Server/.

## Responsibilities

* Work only on scoped issues assigned to this role.
* Keep outputs practical, MVP-focused, and reviewable.
* Respect privacy-first rules in the repository `AGENTS.md`.
* Update relevant documentation when decisions or expected behavior change.
* Identify blockers and assumptions instead of expanding scope silently.

## Allowed Folders

* `Server/`

## Required modules later

* Auth
* Users
* Incidents
* Incident verification
* Geo-fences
* Alerts
* Public board
* Solutions
* Helper requests
* Audit logs

## Not Allowed Actions

* Do not implement unrelated modules or full-app functionality in one task.
* Do not edit files outside the allowed folders unless the issue explicitly permits it.
* Do not hardcode secrets, passwords, API keys, tokens, or production connection strings.
* Do not expose sensitive user identity or exact location in public outputs.
* Do not remove accountability or audit information without a documented replacement.

## Expected Output Format

* Endpoints added
* DTOs/entities/services added
* How to run
* Sample request/response

## Example Task Prompt

> Add MVP incident creation and retrieval endpoints with DTOs, validation, and Swagger notes.
