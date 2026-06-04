# Architecture Overview

## Architecture Decision

SurakshaNet AI uses a modular MVP architecture with a Flutter mobile client, optional admin/web surface, .NET 8 Web API, SQL Server persistence, and an in-backend MVP verification scoring service. A dedicated Python/FastAPI AI service is a future extension point, not an MVP dependency.

The system is organized around the civic safety lifecycle:

```text
Report → Verify → Protect → Solve → Account
```

## Reason

This design keeps the MVP practical, reviewable, and privacy-first while allowing backend, database, Flutter, AI, QA, and security agents to work incrementally. The backend remains the policy enforcement point for identity, role-based authorization, consent, redaction, location precision, public publishing, and audit logging. Mobile and web clients present workflow-specific views but never make final trust, publication, or consent decisions on their own.

## High-Level System Context

```text
Citizen / Helper / Reviewer / Admin
            |
            v
Flutter Mobile App  ---- optional later ----> Web/Admin App
            |                                  |
            +------------ HTTPS/JSON ----------+
                           |
                           v
                    .NET 8 Web API
       +-------------------+-------------------+
       |                   |                   |
 Auth/RBAC/DTOs     MVP Verification     Audit Logging
       |             Scoring Service           |
       +-------------------+-------------------+
                           |
                           v
                    SQL Server Database
```

## Affected Modules

| Layer | MVP Responsibility | Boundary |
| --- | --- | --- |
| Flutter mobile app | Incident reporting, alerts, helper requests, profile/consent, public-safe views | Uses public/mobile DTOs only; cannot final-verify, publish, or bypass consent. |
| Optional web/admin app | Future reviewer/admin workflows and public accountability management | Requires role-based access and audit logging; not required for first mobile flows. |
| .NET 8 Web API | Validation, authorization, workflow orchestration, DTO redaction, audit writes, Swagger contracts | Main trust boundary for all sensitive decisions. |
| MVP verification service | Scores severity, confidence, sensitivity, department routing, duplicate risk, and alert radius | Decision support only; human review required for sensitive/legal/public workflows. |
| SQL Server | Stores identity, incidents, evidence metadata, verification logs, alerts, public records, helper consent, and audit logs | Separates sensitive fields from public-safe fields wherever practical. |
| Future AI service | Advanced model-backed verification, media analysis, multilingual classification | Invoked by backend only after MVP scoring rules are validated. |

## Report → Verify → Protect → Solve → Account Flow

### 1. Report

1. Citizen submits an incident from the mobile app with category, description, optional media metadata, and location.
2. The mobile app labels whether the location is exact, approximate, or user-redacted, but the backend validates and stores the authoritative precision state.
3. The backend validates required fields, normalizes category/status values, stores the private incident record, and writes an audit event for incident creation.
4. Public/mobile responses return redacted identity and approximate location unless a workflow explicitly permits more detail.

### 2. Verify

1. The backend runs MVP verification scoring after incident creation or update.
2. Verification outputs may include confidence, severity, suspected duplicate status, sensitivity flags, recommended department, recommended alert radius, and human-review requirements.
3. AI/scoring output is stored as decision support and cannot directly publish sensitive records, corruption complaints, petitions, or legal allegations.
4. Reviewer/admin actions approve, reject, escalate, or request more information and must be audited.

### 3. Protect

1. Verified or reviewer-approved high-risk incidents can produce geo-fenced alerts.
2. Alert payloads use approximate location, radius, category, severity, safety instructions, and expiry; they must not expose reporter identity or exact coordinates.
3. Helper requests begin with approximate location and limited requester details.
4. Exact location sharing for helper flows requires explicit consent, records who received it, and writes an audit event.

### 4. Solve

1. Solution suggestions connect incident categories to practical safety steps, department guidance, and escalation paths.
2. Suggestions must avoid legal advice and must clearly separate automated recommendations from official decisions.
3. Department routing and solution text can be seeded and refined without changing mobile workflow contracts.

### 5. Account

1. Public accountability board records are created only from verified, privacy-safe incident summaries or reviewer-approved civic issues.
2. Public records use redacted identity, approximate area, status history, department, timestamps, and non-sensitive evidence summaries.
3. Public accountability records must not be silently deleted. Status changes, removals from public visibility, moderation actions, and corrections require audit logs.
4. Corruption complaints, petitions, and sensitive public publishing require human review before public exposure.

## API Impact

* The backend exposes module-oriented endpoint groups for auth, users/consent, incidents, verification, geo-fences/alerts, public board, solutions, helper requests, and audit logs.
* Endpoint contracts must use separate request DTOs, internal models, admin/reviewer DTOs, public DTOs, and mobile summary DTOs.
* Public/mobile DTOs must omit sensitive identity, private contact details, exact coordinates, raw evidence storage locations, internal verification notes, and audit internals.
* Admin/reviewer DTOs may include more context only under RBAC and audit controls.
* Every endpoint that changes verification state, consent state, alert status, helper exact-location access, public board visibility, or sensitive records must create an audit event.

## DB Impact

* Database work should model identity, incidents, evidence metadata, verification logs, geo-fences, alerts, public board records, solution suggestions, helper requests, consent events, and audit logs.
* Incident data should retain private source data while maintaining public-safe fields such as approximate area, category, status, and severity.
* Verification logs should be append-only enough to explain score changes, reviewer decisions, and human override reasons.
* Audit logs should capture actor, action, target module/entity, timestamp, reason, and relevant metadata without storing secrets or unnecessary sensitive content.

## Security and Privacy Boundaries

| Area | Boundary | Enforcement Point |
| --- | --- | --- |
| Identity | Reporter identity and contact details are private by default. | API DTO mapping, RBAC, database field separation. |
| Exact location | Exact coordinates are never public and are shared only when the workflow permits and consent exists. | API validation, consent records, helper workflow checks. |
| Evidence/media | Raw media URLs, storage keys, metadata, and sensitive attachments are not public. | Private evidence tables, signed-access future design, reviewer-only DTOs. |
| Helper requests | Approximate location first; exact location requires explicit consent and recipient tracking. | Helper service rules, consent events, audit logs. |
| Public board | Only verified privacy-safe summaries are public; no silent deletion. | Reviewer/admin RBAC, redaction, status history, audit logs. |
| Corruption complaints | Treated as sensitive allegations requiring human review before publishing or routing. | Sensitivity flags, reviewer workflow, restricted DTOs. |
| Petitions | Future module requiring legal/human review before public launch. | Disabled or reviewer-gated MVP endpoints. |
| Audit logs | Sensitive actions are traceable but audit access is restricted. | Admin RBAC, append-focused repository/service pattern. |
| AI verification | AI/scoring supports decisions but does not become final authority for sensitive outcomes. | Backend workflow rules and human-review gates. |

## Integration Order

1. **Database foundation:** Create SQL Server schema for core identity, incidents, verification logs, audit logs, and public/private field separation.
2. **Backend foundation:** Implement .NET API health, Swagger, configuration placeholders, DTO mapping, validation, repositories, services, and audit service pattern.
3. **Incident reporting:** Add create/read incident flows with private storage and public/mobile redacted responses.
4. **MVP verification:** Add mock/scoring verification service and reviewer decision states without external AI dependency.
5. **Flutter foundation:** Wire mobile screens to mock/API service contracts for reporting, my reports, alerts, helper request, solutions, and profile/consent.
6. **Geo-fenced alerts:** Implement alert radius/risk-area contracts after incident and verification states are stable.
7. **Public board and solutions:** Publish only privacy-safe verified summaries and route solution suggestions to departments/categories.
8. **Helper request consent:** Implement approximate-first helper flow and exact-location consent audit trail.
9. **QA and security hardening:** Validate privacy redaction, RBAC, audit coverage, negative cases, and sensitive workflow human-review gates.
10. **Future AI service:** Introduce external AI only after MVP contracts, logs, and human review workflows are validated.

## Risks

* False reports, duplicate reports, and coordinated abuse can reduce public trust.
* Exact location, evidence metadata, or reporter identity leakage can endanger users.
* Public board misuse can create harassment, public shaming, or legal exposure if moderation is weak.
* Treating AI output as final authority can create unsafe or unfair outcomes.
* Building advanced AI or dashboards before stable incident and audit flows can slow MVP delivery.

## Recommended Implementation

Start with contracts and schema that preserve privacy boundaries. Implement one module at a time, keep DTOs explicit, add audit logs alongside sensitive actions, and require human review before legal, corruption, petition, exact-location sharing, or public accountability publishing workflows. Defer advanced AI, full admin dashboards, and complex petition functionality until MVP report, verification, alert, public board, helper consent, and audit flows are reliable.
