# MVP User Stories and Acceptance Criteria

## Purpose

This document links product intent to the implementation-aware backlog in `MVP_BACKLOG.md`. It is the source for planning, issue creation, estimation, and QA traceability. It does not authorize broad implementation outside the named story and its dependencies.

## Priority Definitions

* **P0:** Required before a safe pilot with real users or real incident data.
* **P1:** Required to complete the intended MVP experience after the secure reporting loop.
* **P2:** Deferred planning only; not authorized for current MVP implementation.

## Personas

* **Citizen:** Submits incidents and views their own private reports.
* **Nearby citizen:** Receives privacy-safe alerts and views approved public information.
* **Reviewer:** Reviews evidence, verification recommendations, alerts, and publication decisions.
* **Administrator:** Manages roles, reference configuration, audit review, and moderation oversight.
* **Helper requester:** Requests limited assistance while protecting identity and exact location.
* **Verified helper:** Receives only the minimum information allowed by request state and consent scope.

## P0 Stories

### US-00 — Reproducible build and contract baseline

**Backlog link:** BL-00  
**User story:** As an engineering team, we need reproducible builds and aligned contracts so every agent works from the same verified foundation.

**Acceptance criteria:**

* Flutter analyze/tests and .NET restore/build/tests run through documented commands.
* SQL schema, EF models, DTOs, statuses, and seed data have a documented parity result.
* Configuration examples contain no usable production secrets.
* Build or contract failures are documented as blockers rather than bypassed.

**QA focus:** Build reproducibility, configuration safety, contract mismatch detection.

### US-01 — Secure registration, login, and role enforcement

**Backlog link:** BL-01  
**User story:** As a user, I want secure authentication so private reports and privileged actions are protected.

**Acceptance criteria:**

* Registration and login validate inputs and never expose password hashes.
* Tokens are signed, expire, and validate issuer and audience.
* Server authorization distinguishes Citizen, Reviewer, and Admin.
* Missing authentication returns `401`; insufficient role returns `403`.
* Privileged identity and role changes are audited.

**Privacy and safety:** Authentication errors must not leak private account details. Rate limiting and abuse controls are required before public exposure.

**QA focus:** Valid/invalid login, token expiry, role denial, duplicate account, audit creation.

### US-02 — Privacy-safe incident submission

**Backlog link:** BL-02  
**User story:** As a citizen, I want to report a hazard quickly without unnecessarily exposing my identity or exact location.

**Acceptance criteria:**

* Supported categories, description limits, location values, and consent fields are validated server-side.
* Submission begins in the documented initial workflow state.
* Clients cannot set verification, publication, reviewer, scoring, or audit-actor fields.
* Incident creation is linked to the authenticated citizen and creates an audit event.
* Public-safe responses omit reporter identity, contact details, exact coordinates, raw evidence locations, and private notes.

**Privacy and safety:** Approximate location is the default. Exact location requires an approved purpose and explicit consent.

**QA focus:** Required fields, unsupported category, invalid coordinates, unauthorized submission, redaction, audit event.

### US-03 — Private report history and incident details

**Backlog link:** BL-03  
**User story:** As a citizen, I want to track my own reports and open details without seeing another reporter's private information.

**Acceptance criteria:**

* “My reports” data is filtered by authenticated user on the server.
* A citizen cannot access another citizen's report by changing an identifier.
* Report lists are bounded and deterministically ordered.
* Mobile supports loading, empty, success, error, retry, and unauthorized states.
* Incident details show only fields allowed for the owner view.

**QA focus:** Ownership enforcement, direct-ID attack, empty/error states, navigation.

### US-04 — Controlled verification status workflow

**Backlog link:** BL-04  
**User story:** As a reviewer, I want controlled incident states so unreviewed or sensitive information cannot become trusted public information automatically.

**Acceptance criteria:**

* Supported states and transitions are consistent across DB, backend, mobile, docs, and QA.
* Invalid transitions return `409` and do not modify state.
* Reviewer actions require the correct role and a reason where required.
* Previous state, new state, actor, timestamp, and reason are audited.
* Sensitive incidents cannot be automatically published.

**QA focus:** Every valid transition, invalid transition, missing reason, role denial, audit persistence.

### US-05 — Explainable deterministic verification scoring

**Backlog link:** BL-05  
**User story:** As a reviewer, I want explainable rule-based recommendations so I can prioritise incidents without giving AI final authority.

**Acceptance criteria:**

* Scoring returns severity, confidence, sensitivity, department, alert radius, recommended status, and rationale.
* The same input produces the same MVP output.
* Sensitive triggers require human review.
* Automated output never finalises `verified`, `published`, or `resolved`.
* Reviewer overrides require a reason and audit event.

**Privacy and safety:** Private identity, exact location, and unnecessary media metadata must not be sent to an external model.

**QA focus:** Flood, electric hazard, road hazard, vague report, duplicate reports, sensitive allegation, reviewer override.

### US-06 — Complete sensitive-action audit trail

**Backlog link:** BL-06  
**User story:** As an administrator, I want sensitive actions recorded so decisions can be reviewed and accountability history cannot be silently rewritten.

**Acceptance criteria:**

* Audit entries identify the authenticated actor, action, target, time, reason, and safe change metadata.
* Required events include incident creation, verification decisions, alert changes, publication/moderation, consent grant/revoke/access, privileged evidence access, and role changes.
* Audit metadata excludes secrets, passwords, tokens, raw evidence, and unnecessary exact coordinates.
* Audit access is restricted to authorised roles.
* Sensitive state changes fail safely if their mandatory audit record cannot be stored.

**QA focus:** Required-event coverage, authorization, safe metadata, failure behaviour.

### US-07 — Privacy-safe geo-fenced alerts

**Backlog link:** BL-07  
**User story:** As a nearby citizen, I want relevant safety alerts without exposing the reporter or exact incident location.

**Acceptance criteria:**

* Only active, non-expired, reviewer-approved alerts are public.
* Eligibility is connected to verification state.
* Radius values are validated; overrides require a reason and audit event.
* Responses contain an approximate risk area and safe action but no reporter identity, private evidence, or exact incident coordinates.
* Missing, invalid, inside-radius, outside-radius, expired, and cancelled cases are handled predictably.

**QA focus:** Eligibility, distance matching, expiry, cancellation, no-location response, redaction.

### US-08 — Explicit public, owner, reviewer, and admin DTO boundaries

**Backlog link:** BL-08  
**User story:** As a privacy-conscious user, I want the server to return only the information permitted for my role and relationship to a record.

**Acceptance criteria:**

* Separate response contracts exist for public, citizen-owner, reviewer, and admin use cases.
* EF/domain entities are not serialized directly from controllers.
* Public response tests assert that restricted fields are absent.
* Unauthorized access does not reveal whether another user's private record exists.
* Exact location is available only through an explicitly consented and authorised workflow.

**QA focus:** Field-level redaction, role matrix, ownership, resource enumeration resistance.

### US-09 — Automated merge quality gate

**Backlog link:** BL-09  
**User story:** As an engineering manager, I want every pull request automatically validated so broken or unsafe changes do not merge silently.

**Acceptance criteria:**

* Pull requests run Flutter analysis/tests and .NET restore/build/tests.
* A failed required command fails the workflow.
* Workflow configuration contains no committed credentials.
* README build/test commands match CI commands.
* Mandatory tests include at least one authorization test and one public-redaction test before pilot.

**QA focus:** Green build, intentional failure, secret handling, required-check enforcement.

## P1 Stories

### US-10 — Public accountability board

**Backlog link:** BL-10  
**User story:** As a nearby citizen, I want to view verified civic issues and progress without seeing private reporter data.

**Acceptance criteria:**

* Only reviewer-approved privacy-safe records are public.
* Items show category, approximate area, severity, department guidance, status, and public history.
* Visibility changes and moderation actions are audited.
* Records are corrected, hidden, resolved, or archived through explicit states rather than silent deletion.

**QA focus:** Publication gate, redaction, history, moderation reason, archive behaviour.

### US-11 — Public issue progress updates

**Backlog link:** BL-11  
**User story:** As a reviewer, I want to publish safe progress updates while preserving previous public history.

**Acceptance criteria:**

* Updates require an authorised reviewer and an eligible public issue.
* Public text excludes private notes, exact location, identity, and unreviewed allegations.
* Previous and new public values are audited.
* Removal from public display requires a moderation or safety reason.

**QA focus:** Update creation, unsafe-field rejection, history, moderation.

### US-12 — Practical solution suggestions

**Backlog link:** BL-12  
**User story:** As a citizen, I want safe next-step guidance for a verified issue.

**Acceptance criteria:**

* Suggestions are tied to verified category and severity.
* Guidance includes safety precautions and department routing.
* Guidance avoids legal advice, accusations, guarantees, and dangerous instructions.
* Sensitive suggestions require reviewer approval.
* Creation and reviewer edits are audited.

**QA focus:** Rule mapping, wording guardrails, sensitivity gate, audit.

### US-13 — Consent-scoped verified helper requests

**Backlog link:** BL-13  
**User story:** As a helper requester, I want assistance while exposing only an approximate area until I explicitly consent to more information sharing.

**Acceptance criteria:**

* Helper-visible requests begin with approximate area and minimum necessary details.
* Exact location access is requester-consented, recipient-specific, purpose-specific, time-scoped, revocable, and audited.
* Helper/request visibility requires verification or reviewer approval.
* A requester can revoke access and the recipient loses future access.
* Request state changes and exact-location views are audited.

**QA focus:** Consent grant, recipient mismatch, expiry, revoke, visibility gate, audit.

### US-14 — Helper safety and misuse prevention

**Backlog link:** BL-14  
**User story:** As a requester or helper, I want clear safety guidance and reporting controls so the platform does not encourage unsafe contact or replace emergency services.

**Acceptance criteria:**

* Emergency disclaimer and approximate-location explanation appear before helper visibility.
* The flow discourages unsafe direct contact and oversharing.
* Users can report abuse or unsafe behaviour.
* Safety-copy changes require Product, Security, and QA review.

**QA focus:** Copy visibility, emergency disclaimer, abuse reporting, regression review.

### US-15 — Restricted evidence and media handling

**Backlog link:** BL-15  
**User story:** As a reporter, I want evidence protected until it is authorised and redacted for a specific use.

**Acceptance criteria:**

* Upload validation restricts allowed type, size, and metadata.
* Raw storage references are never public.
* EXIF/location metadata is removed from public derivatives.
* Privileged evidence access and redaction/publication actions are audited.
* Faces, plates, minors, vulnerable people, and private-property details require review before public use.

**QA focus:** Type/size validation, unauthorised access, metadata stripping, redaction state, audit.

### US-16 — Backup and restore validation

**Backlog link:** BL-16  
**User story:** As an operator, I want tested backups so data can be restored without exposing sensitive records or relying on an unverified procedure.

**Acceptance criteria:**

* A non-production backup is created and restored into a separate environment.
* Restore verification confirms schema and representative record integrity.
* Backup files remain outside source control and use restricted access.
* Production planning documents encryption, retention, operator authorization, and audit requirements.

**QA focus:** Restore drill, checksum/integrity, access restriction, repository exclusion.

## P2 Deferred Stories

### US-17 — Petition and legal-aid automation planning

**Backlog link:** BL-17  
No implementation is authorised in the current MVP. A future initiative requires dedicated legal, governance, security, privacy, human-review, and audit design.

### US-18 — Authority and real-time dispatch integrations

**Backlog link:** BL-18  
No real-time dispatch, authority ticketing, payment, or unsupported third-party commitment is authorised in the current MVP.

### US-19 — External model-backed AI

**Backlog link:** BL-19  
External AI remains deferred until deterministic scoring, evaluation, redaction, human review, auditability, and vendor/privacy controls are proven.

## Story Readiness Checklist

A story may become a GitHub implementation issue only when:

1. Its dependencies are complete or represented by an approved interface/mock.
2. Allowed folders and explicit exclusions are stated.
3. Public, owner, reviewer, and admin visibility is clear.
4. Required audit events are named.
5. QA cases cover happy path, negative path, authorization, privacy, misuse, and failure behaviour.
6. The issue is small enough for one reviewable pull request.
