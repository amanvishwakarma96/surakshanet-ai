# Architecture Overview

## Architecture Decision

Use a modular MVP architecture with a Flutter mobile client, optional web/admin app, .NET 8 Web API backend, SQL Server database, and an MVP mock verification service inside backend planning before any dedicated AI service is introduced.

## Reason

This keeps the MVP small, testable, and compatible with future expansion into advanced AI verification, public dashboards, and pilot deployments.

## System Flow

1. Citizen submits an incident from the mobile app.
2. Backend validates input, stores private data, and writes an audit event.
3. Verification logic scores severity, sensitivity, department, and alert radius.
4. Human review is required for sensitive or public accountability actions.
5. Verified critical incidents can create geo-fenced alerts.
6. Public board publishes privacy-safe issue summaries.
7. Solution suggestions and helper requests use privacy-preserving defaults.

## Security Boundaries

* Mobile clients cannot final-verify incidents.
* Public board views cannot expose reporter identity or exact coordinates.
* Admin operations require role-based authorization and audit logs.
* AI outputs are recommendations only.

## Risks

* False reports or duplicate reports can reduce trust.
* Exact location leakage could endanger users.
* Public shaming or misuse can occur without moderation.
* Overbuilding AI before validation can slow delivery.

## Recommended Implementation

Start with documented contracts, schema planning, and mock flows. Implement one module at a time: incidents, verification, alerts, public board, solutions, helpers, then QA/security hardening.
