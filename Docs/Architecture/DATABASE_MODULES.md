# Database Modules

## MVP Database Baseline

SQL Server persistence should support privacy-first reporting, explainable verification, geo-fenced protection, public accountability, helper consent, and auditability. Schema scripts belong under `DB/Scripts/` and safe seed data belongs under `DB/SeedData/` in future database tasks.

No production secrets, user passwords, real evidence files, or real personal data should be added to seed data.

## Planned Entity Groups

| Module | Planned Tables | Primary Relationships | Sensitive/Public Boundary | Audit Touchpoints |
| --- | --- | --- | --- | --- |
| Identity | `Users`, `Roles`, `UserRoles`, `UserConsentSettings` | Users own incidents, helper requests, review actions, and audit actor references. | Store required identity/contact fields privately. Public views use alias/display-safe values only. | Role changes, consent changes, profile privacy changes. |
| Incidents | `Incidents`, `IncidentMedia`, `IncidentStatusHistory` | Incident belongs to reporter; may have media, verification logs, alerts, public board records, solutions, helper requests. | Exact coordinates, reporter ID, contact, raw media metadata, and internal notes are private. Approximate area/category/status/severity can be public after review. | Create/update, status transition, media change, sensitive flag change. |
| Verification | `IncidentVerificationLogs`, `ReviewerDecisions` | Verification logs belong to incident; reviewer decisions reference reviewer user and optional previous log/result. | Detailed scores, duplicate signals, sensitivity flags, reviewer notes, and override reasons are reviewer/admin only. Public gets final safe status/severity. | Scoring run, reviewer decision, override, escalation. |
| Departments and Reference Data | `Departments`, `IncidentCategories`, `SolutionTemplates` | Categories route incidents to departments and solution templates. | Public can read active department/category names and safe guidance. Management metadata is admin-only. | Department/category/template create/update/disable. |
| Geo-fences and Alerts | `GeoFences`, `Alerts`, `AlertStatusHistory` | Alerts may reference incident and geo-fence; geo-fences define approximate risk area/radius. | Store risk geometry/radius without exposing reporter exact location. Public alert output uses approximate center/radius or named area. | Alert create/update/cancel/expire, geo-fence change. |
| Public Board | `PublicBoardRecords`, `PublicBoardStatusHistory` | Public records reference verified incident or civic issue; may reference department and moderation actor. | Public fields include redacted summary, approximate area, department, status, safe evidence summary. Private link to incident remains restricted. | Publish/unpublish, correction, status change, moderation, department assignment. |
| Solutions | `SolutionSuggestions`, `IncidentSolutionLinks` | Suggestions can be generated from category, department, and incident verification result. | Public/mobile guidance is practical and non-legal. Internal routing/scoring rationale remains restricted. | Template changes, incident-specific suggestion approval/update. |
| Helper Requests | `HelperRequests`, `HelperRequestMatches`, `HelperLocationConsentEvents`, `HelperRequestStatusHistory` | Helper request may reference incident/requester; matches reference helper user; consent events reference requester, helper, scope, expiry. | Approximate location first. Exact coordinates only stored/accessed through consent-scoped records and restricted DTOs. | Request create/update, match, status transition, exact-location grant/revoke/access. |
| Petitions | `Petitions`, `PetitionSupporters`, `PetitionReviewDecisions` | Future records may reference public board issue or incident. | Future-only or disabled in MVP; requires human/legal review before public exposure. Supporter identity must be protected. | Review, publish, support/withdraw, moderation. |
| Audit | `AuditLogs` | Audit entries reference actor user when available and target module/entity by ID/type. | Audit metadata is sanitized; no secrets, passwords, tokens, raw evidence, or unnecessary sensitive content. Access restricted to admins/reviewers as appropriate. | Append event for sensitive actions; audit reads can be logged later. |

## Core Relationship Narrative

```text
User
 ├─ Incidents ── IncidentMedia
 │      ├─ IncidentVerificationLogs ── ReviewerDecisions
 │      ├─ Alerts ── GeoFences
 │      ├─ PublicBoardRecords ── PublicBoardStatusHistory
 │      ├─ IncidentSolutionLinks ── SolutionSuggestions
 │      └─ HelperRequests ── HelperRequestMatches ── HelperLocationConsentEvents
 ├─ UserConsentSettings
 ├─ UserRoles ── Roles
 └─ AuditLogs (as actor)
```

Key relationship rules:

1. A user can submit many incidents, but public outputs must not expose the reporter relationship.
2. An incident can have many verification logs because scoring and reviewer decisions may change over time.
3. A public board record can reference an incident but must store its own public-safe summary and status history.
4. A helper request can exist with approximate location only; exact-location access must be represented by consent events.
5. Audit logs should reference target module/entity without becoming a dumping ground for raw sensitive data.

## Sensitive and Public Field Boundaries

| Data Type | Private/Internal Fields | Public-Safe Fields |
| --- | --- | --- |
| User identity | User ID, phone/email, auth identifiers, role assignments, contact preferences | Display alias or anonymized label where needed. |
| Location | Exact latitude/longitude, capture precision, requester/reporter live location, consent recipient | Approximate area, radius, ward/neighborhood label, geohash/truncated coordinate where approved. |
| Incident | Reporter ID, exact location, raw evidence metadata, internal notes, sensitive flags, duplicate signals | Category, approximate area, status, severity, created date, redacted summary after verification. |
| Evidence | Storage key, upload URL, EXIF/device metadata, faces/plates/sensitive image notes | Safe thumbnail/summary only after review, if needed. |
| Verification | Raw score components, model/rule details, reviewer notes, override reason | Final verification status and simplified severity/confidence label. |
| Helper request | Requester identity/contact, exact location, helper match details before consent | Approximate area, need category, safe urgency level, consent state. |
| Public board | Private incident reference, moderation notes, reviewer identity if not meant for public view | Issue title, redacted description, approximate area, department, status history, public timestamps. |
| Audit | Actor IDs, target IDs, restricted metadata | Not public; admin/reviewer access only. |

## Status and History Expectations

Use status/history tables where a record must not be silently overwritten or deleted:

* `IncidentStatusHistory` for report lifecycle changes.
* `ReviewerDecisions` or verification history for human review and overrides.
* `AlertStatusHistory` for alert publication, cancellation, expiry, and geo-fence changes.
* `PublicBoardStatusHistory` for accountability status, correction, removal from visibility, and department updates.
* `HelperRequestStatusHistory` for request state, match state, cancellation, completion, and safety escalation.
* `AuditLogs` for cross-module sensitive action history.

## Recommended MVP Index Planning

Future scripts should consider indexes for:

* Incident status, category, reporter user, created date, verification status, and approximate area.
* Verification incident ID, created date, sensitivity flag, and reviewer decision status.
* Alert active status, expiry date, severity, category, and geo-fence/radius lookup fields.
* Public board status, department, approximate area, created date, and updated date.
* Helper request status, approximate area, urgency, consent state, and created date.
* Audit actor, action, target module/entity, created date, and correlation/request ID if introduced.

## Data Retention and Deletion Principles

* Public accountability records should not be silently deleted; prefer status changes such as corrected, resolved, hidden pending review, or removed with documented reason.
* Sensitive evidence should support future retention policies and access controls without making storage locations public.
* Audit logs should be append-focused and protected from routine user deletion.
* User privacy requests must be handled carefully so public accountability and legal/safety audit obligations are preserved through redaction or anonymization where appropriate.

## Incremental Database Implementation Sequence

1. Identity and audit base tables.
2. Incidents, incident media metadata, and incident status history.
3. Verification logs and reviewer decisions.
4. Departments, categories, and solution templates seed data.
5. Geo-fences, alerts, and alert status history.
6. Public board records and public board status history.
7. Helper requests, matches, location consent events, and helper status history.
8. Petition tables only after legal/human-review workflow is explicitly approved.
9. Indexes, constraints, and retention/anonymization refinements after endpoint behavior stabilizes.
