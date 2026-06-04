# Privacy and User Protection Review

## Review Scope

This review defines MVP privacy and user-protection rules for SurakshaNet AI workflows that collect identity, location, incident evidence, helper-request, verification, public-board, and audit data.

The rules are intended to keep the MVP practical while ensuring the platform does not expose sensitive user identity, exact location, or unreviewed allegations through public or helper-facing experiences.

## Core Principles

* Protect user identity by default.
* Share approximate location first.
* Require explicit consent for exact location sharing.
* Keep audit logs for sensitive actions.
* Treat public publishing as a moderated workflow.
* Use AI as decision support only.
* Minimize collected data to what is required for the safety workflow.
* Keep private evidence and internal reviewer notes out of public DTOs and public pages.
* Prefer reversible visibility status changes over silent deletion for public accountability records.

## MVP Privacy Rules

### 1. Identity Protection

* Reporter, requester, helper, reviewer, and admin identity must not be exposed in public views unless the user explicitly chooses a public display option approved by product and security review.
* Public incident and public board views should use anonymous labels, public-safe status, approximate area, category, severity, and redacted summary only.
* User IDs, phone numbers, email addresses, auth identifiers, device identifiers, and internal role details are private fields.
* Reviewer and admin names should remain internal unless there is an approved accountability disclosure policy.

### 2. Location Protection

* Exact latitude and longitude are private by default.
* Public views must use approximate area, ward/neighborhood label, radius, or truncated location representation.
* Sensitive categories, helper requests, unsafe-area reports, corruption/legal reports, and reports involving vulnerable people must never publish exact location automatically.
* Exact location sharing must require explicit, time-scoped consent and must be auditable.
* Location precision, EXIF GPS data, and live-location indicators should be stripped or hidden from public media and public DTOs.

### 3. Consent and Helper Safety

* Verified helper requests must start with approximate matching only.
* Exact requester location or contact details can be shared only after explicit requester consent for a specific helper, purpose, and time window.
* Helper access must be revocable and should expire automatically.
* Helper matching, exact-location grants, exact-location views, revocations, cancellations, completions, and safety escalations must create audit events.
* The MVP should avoid exposing requester contact details directly; use mediated contact or masked channels when implemented.

### 4. Public Publishing and Accountability

* Public board records must be based on verified or approved reports only.
* Human review is required before publishing sensitive reports, corruption complaints, legal allegations, petitions, or reports that may identify a private person.
* AI scores may recommend severity, duplicate status, category routing, or review priority, but must not be the final authority for sensitive publication.
* Public records should support corrections, hidden-pending-review status, resolved status, and removal-from-public-view with documented reason.
* Public accountability records must not be silently deleted.

### 5. Evidence and Media Protection

* Evidence files, storage keys, upload URLs, device metadata, EXIF data, faces, license plates, and raw media review notes are private.
* Media should be accessible only to authorized reviewers/admins until reviewed and redacted.
* Public media thumbnails or summaries should be published only after human review confirms they do not expose identities, exact locations, minors, vulnerable people, or sensitive private property details.
* Evidence access should be logged for sensitive categories and privileged roles.

### 6. Role-Based Access Control

* Citizen users may create and view their own private submissions and public-safe records.
* Reviewers may access verification queues, private incident details required for review, and limited evidence for assigned workflows.
* Administrators may manage users, roles, configuration, and audit review through least-privilege access.
* Helper users may view only public-safe or consent-scoped helper request details.
* Public unauthenticated users, if supported, may view only approved public-safe board records and alerts.

### 7. Audit Logging

Sensitive actions must create append-focused audit events with actor, action, target module/entity, timestamp, and safe metadata. Audit logs must not store secrets, passwords, JWTs, raw evidence, exact coordinates unless strictly necessary, or full private descriptions when a reference ID is sufficient.

Required MVP audit events:

* Incident creation and status changes.
* Verification decisions, AI recommendation changes, and human overrides.
* Public-board publish, correction, hide, resolve, and remove-from-public-view actions.
* Helper request creation, match, consent grant, exact-location access, revoke, cancel, complete, and safety escalation.
* Evidence upload, privileged evidence view, redaction, and removal from public visibility.
* Role assignment, privileged login/configuration changes, and audit export attempts.

### 8. Data Retention, Redaction, and Deletion

* Public accountability history should be preserved through status history and redacted summaries rather than silent deletion.
* User privacy requests should be handled through redaction, anonymization, or restricted retention where safety, legal, or audit obligations require preserving a record.
* Raw evidence retention should be shorter and more restrictive than public-safe summaries unless policy requires otherwise.
* Audit logs should be protected from user-driven deletion and available only to authorized roles.

## MVP Risk Controls

| Risk | Affected Module | Severity | Recommended Protection | MVP Implementation Note |
| --- | --- | --- | --- | --- |
| Reporter identity exposure | Incidents, Public Board | High | Separate private reporter fields from public views. | Public issue DTOs must hide identity, contact data, auth IDs, and role data. |
| Exact location leakage | Incidents, Alerts, Helpers, Media | High | Store exact location privately and display approximate area. | Exact location requires consent; strip EXIF GPS from public media. |
| Misuse of helper flow | Helper Requests | High | Verify helper status and limit visible requester data. | Start with approximate matching only; log consent grants and exact-location views. |
| False or defamatory reports | Public Board, Verification | High | Human review before public publishing. | Sensitive categories remain unpublished until reviewed; AI cannot final-approve. |
| Unauthorized admin access | Backend, Audit, Public Board | High | JWT, role-based authorization, least privilege. | Admin and reviewer actions must be audited. |
| Silent deletion of public records | Public Board | Medium | Use status transitions and audit history. | Hide/remove from public view only with documented reason and history. |
| Evidence misuse | Incident Media | High | Restrict access and log evidence views. | Media access requires role checks and redaction before publication. |
| Sensitive category exposure | Unsafe Area, Corruption/Legal, Helper Requests | High | Require human review and public-safe summaries. | Do not publish exact location, private identities, or unverified allegations. |
| Overcollection of personal data | Auth, Incidents, Helpers | Medium | Collect only fields required for MVP workflow. | Avoid unnecessary profile fields and direct contact disclosure. |
| Audit log privacy leakage | Audit | Medium | Store safe metadata and references instead of raw private content. | Audit logs are restricted and should not contain secrets or raw evidence. |
| Public alert panic or misinformation | Alerts, Verification | Medium | Alert only verified or safety-critical reviewed reports. | Use cautious copy and expiry; keep internal uncertainty notes private. |
| Reviewer overreach | Verification, Evidence, Audit | Medium | Least-privilege access and audit privileged views. | Restrict queues by role/module where possible. |

## Required Security Review Checklist

Before implementing or changing a workflow, confirm:

* Does the public DTO exclude reporter/requester/helper identity?
* Does the public DTO use approximate location only?
* Does exact location sharing require explicit consent, scope, expiry, and audit logging?
* Are helper request details limited to approximate matching before consent?
* Are public board records human-reviewed before publication?
* Are corruption, legal, petition, unsafe-area, vulnerable-person, and sensitive cases blocked from auto-publication?
* Are evidence files private by default and stripped of public EXIF/location metadata?
* Are privileged evidence views and status changes audited?
* Are roles and permissions least-privilege for citizen, helper, reviewer, and admin users?
* Does the audit event avoid secrets, tokens, raw evidence, and unnecessary exact coordinates?
* Is there a documented status transition instead of silent public record deletion?
* Is AI output treated as recommendation only for sensitive workflows?

## Public vs. Private Data Boundary

| Data Area | Private / Restricted | Public-Safe |
| --- | --- | --- |
| User identity | User ID, name, phone, email, auth provider ID, device ID, role assignments | Anonymous label or user-selected display alias only after review. |
| Location | Exact coordinates, precision, live location, EXIF GPS, consent recipient | Approximate area, ward/neighborhood, radius, truncated coordinates. |
| Incident | Reporter ID, exact location, raw description if sensitive, private evidence, internal notes | Category, verified status, redacted summary, approximate area, severity label. |
| Helper request | Requester identity/contact, exact location, helper match details, safety notes | Need category, approximate area, urgency label, consent state. |
| Public board | Private incident reference, moderation notes, reviewer identity, evidence links | Public issue title, redacted description, department, status history, public timestamps. |
| Audit | Actor ID, target IDs, internal metadata | Not public; restricted admin/reviewer access only. |

## Review Outcome

The MVP privacy posture is acceptable for planning if implementation follows these rules. The highest-priority protections are public DTO redaction, approximate-location defaults, consent-scoped exact-location sharing, human review before sensitive publication, restricted evidence access, and append-focused audit logs.

## Known Limitations and Follow-Up Tasks

* Define exact approximate-location method for MVP, such as radius, ward/neighborhood label, or truncated coordinate/geohash.
* Define role-permission matrix for citizen, helper, reviewer, administrator, and unauthenticated public users.
* Define media redaction requirements for EXIF stripping, faces, license plates, minors, and private property.
* Define retention windows for raw evidence, incident records, helper consent events, and audit logs.
* Define privacy-request handling for redaction/anonymization while preserving accountability and safety audit obligations.
