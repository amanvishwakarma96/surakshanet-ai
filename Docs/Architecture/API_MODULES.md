# API Modules

## MVP API Module Plan

The .NET 8 Web API is the policy enforcement boundary for validation, RBAC, DTO redaction, consent checks, verification state changes, public publishing, and audit logging. Mobile and future web/admin clients must receive workflow-specific DTOs rather than database entities.

| Module | Purpose | MVP Endpoint Groups | Public/Private DTO Boundary | Audit-Sensitive Actions |
| --- | --- | --- | --- | --- |
| Health | Runtime readiness checks | `GET /health`, `GET /modules` | Public operational status only; no secrets, connection strings, or internal host details. | Usually none unless status changes become admin-managed. |
| Auth | Register, login, issue tokens, identify current user | `POST /auth/register`, `POST /auth/login`, `GET /auth/me` | Requests accept credentials; responses return tokens/profile summary only. Never return password hashes or token internals. | Failed login abuse tracking later; role changes belong to Users/Admin. |
| Users and Consent | Manage profile, notification preferences, helper consent, location-sharing preferences | `GET /users/me`, `PATCH /users/me`, `PATCH /users/me/consent` | User DTO can include own private profile; public DTO exposes display-safe alias only. Consent DTO records scope, expiry, and target recipient/workflow. | Consent grant/revoke, role/profile changes, privacy setting changes. |
| Incidents | Submit, update, and retrieve civic safety reports | `POST /incidents`, `GET /incidents/{id}`, `GET /incidents/my`, `PATCH /incidents/{id}/status` | Create DTO may include exact location/evidence metadata. Public/mobile summary DTO uses approximate area, category, status, severity, and redacted reporter. Reviewer DTO may include sensitive fields under RBAC. | Create/update, status changes, evidence changes, sensitive flag changes. |
| Verification | Run MVP scoring and record human review decisions | `POST /incidents/{id}/verification/run`, `GET /incidents/{id}/verification`, `POST /incidents/{id}/verification/review` | Public DTO exposes only final safe status/severity. Internal/reviewer DTO includes score details, duplicate risk, sensitivity flags, reviewer notes, and override reason. | Score runs, reviewer decisions, human overrides, escalation decisions. |
| Geo-fences and Alerts | Define risk areas and notify nearby users | `GET /geofences/alerts/nearby`, `POST /geofences`, `POST /alerts`, `PATCH /alerts/{id}/status` | Alert DTO returns approximate center/radius or named area, category, severity, instructions, and expiry. Never expose reporter identity or exact incident coordinates. | Alert create/update/expire/cancel, geo-fence adjustment, emergency escalation. |
| Public Board | Publish verified civic issues and accountability status | `GET /public-issues`, `GET /public-issues/{id}`, `POST /public-issues`, `PATCH /public-issues/{id}/status` | Public DTO contains redacted summary, approximate area, department, status history, and safe evidence summary. Admin DTO may include moderation notes under RBAC. | Publish/unpublish, status changes, department assignment, corrections, moderation actions. |
| Solutions | Suggest safety actions and department routing | `GET /solutions`, `GET /incidents/{id}/solutions`, `POST /solutions` | Public/mobile DTO includes practical guidance and disclaimers. Internal DTO can include scoring/routing rationale. Avoid legal advice in MVP. | Create/update solution templates, department routing changes. |
| Helper Requests | Coordinate verified help while protecting location and identity | `POST /helper-requests`, `GET /helper-requests/{id}`, `PATCH /helper-requests/{id}/status`, `POST /helper-requests/{id}/consent/exact-location` | Default DTO uses approximate location and limited requester info. Exact-location DTO is returned only to consented recipients and should include scope/expiry. | Request create/update, helper match, exact-location consent grant/revoke, completion/cancel. |
| Audit Logs | Review sensitive workflow history | `GET /audit-logs`, `GET /audit-logs/{id}` | Admin-only DTO includes actor, action, target, timestamp, reason, and sanitized metadata. No secrets, passwords, tokens, or raw private evidence. | Audit reads may be logged later; writes are created by other modules. |
| Admin/Reference Data | Manage categories, departments, seeded guidance, role assignments | `GET /departments`, `POST /departments`, `PATCH /users/{id}/roles` | Public reference DTOs expose active departments/categories. Admin DTOs include management metadata under RBAC. | Role assignment, department/category edits, disabling reference data. |

## DTO Boundary Rules

### Request DTOs

* Validate category, severity, status, coordinates, media metadata, and consent fields server-side.
* Accept only fields the caller is allowed to set; do not allow clients to set verification outcome, public publishing status, audit actor, or reviewer-only fields.
* Use explicit fields for location precision, consent scope, and intended workflow.

### Internal Domain Models

* May contain exact coordinates, reporter user ID, evidence metadata, verification details, internal flags, and reviewer/admin notes.
* Must not be serialized directly to mobile, public, or unauthenticated clients.
* Should preserve enough state to support auditability and non-silent public board changes.

### Mobile/User DTOs

* Return the user's own private reports where appropriate, but avoid exposing other reporters' identity or exact location.
* Prefer incident summary, approximate area, category, status, severity, guidance, alert radius, and user-specific consent state.
* Hide internal score details unless converted to simple user-facing confidence/status language.

### Public DTOs

* Include only redacted, verified, privacy-safe summaries.
* Exclude reporter identity, exact coordinates, private contact details, raw evidence links, internal notes, audit metadata, and unreviewed sensitive allegations.
* Public board status changes should be visible as history rather than silent deletion.

### Reviewer/Admin DTOs

* Require RBAC and should be scoped by role.
* May include sensitive details required for review, such as evidence metadata, exact location, duplicate signals, and sensitivity flags.
* Must trigger audit events when used to change verification, alert, helper consent, public publishing, role, or moderation state.

## RBAC and Endpoint Ownership

| Role | Allowed MVP Capabilities | Explicit Restrictions |
| --- | --- | --- |
| Anonymous | Health checks, public board read-only, public-safe reference data | Cannot submit reports, view private details, or access audit logs. |
| Citizen | Submit incidents, view own reports, see nearby alerts, request help, manage own consent/profile | Cannot final-verify, publish public board records, view other users' private details, or access audit logs. |
| Helper | Citizen capabilities plus accepted helper workflows | Cannot receive exact location unless consent exists for that helper request. |
| Reviewer | Review incidents, run/inspect verification, approve alerts/public board summaries, moderate sensitive cases | Cannot bypass audit logging or publish unredacted sensitive data. |
| Admin | Manage reference data, users/roles, audit review, public board administration | Cannot silently delete public accountability records or expose secrets. |

## Audit Requirements by Endpoint Category

Audit events should capture actor, action, target module/entity, timestamp, reason or workflow source, and sanitized metadata.

Mandatory MVP audit points:

1. Incident creation and sensitive incident updates.
2. Verification scoring runs, reviewer decisions, overrides, and escalations.
3. Alert creation, cancellation, expiry override, and geo-fence changes.
4. Public board publish, unpublish, status change, correction, moderation, and department assignment.
5. Helper request state changes and exact-location consent grant/revoke/access.
6. User role changes and privacy/consent setting changes.
7. Audit log access by admins once audit review UI/API exists.

## Error and Validation Rules

* Return stable error shapes for Flutter clients, including `code`, `message`, and optional field-level details.
* Use `401` for missing/invalid authentication, `403` for authenticated but unauthorized, `404` when a resource is unavailable to the caller, and `409` for invalid workflow transitions.
* Do not reveal whether another user's private incident, helper request, or evidence exists when the caller lacks access.
* Validate location ranges, accepted category/status enums, media metadata size/type, consent scope, and reviewer/admin transition reasons.

## Incremental API Implementation Sequence

1. Health/modules and Swagger contracts.
2. Auth/users/profile with placeholder-safe configuration.
3. Incidents create/read/my reports with DTO redaction.
4. Audit service/repository integration for incident changes.
5. MVP verification run/review endpoints.
6. Alerts and geo-fence endpoints. Initial implementation includes `GET /api/geofences/alerts/nearby` for published active alerts matched against optional approximate coordinates.
7. Public board read/publish/status endpoints.
8. Solution suggestion endpoints.
9. Helper request and exact-location consent endpoints.
10. Admin/reference-data and audit review endpoints.
