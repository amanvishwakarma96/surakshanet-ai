# MVP User Stories and Acceptance Criteria

## Purpose

This document expands the MVP backlog into Product Manager-ready user stories for planning, estimation, QA coverage, and agent handoff. It does not define implementation details or authorize broad development work beyond the story scope.

## Story Priority Definitions

* **P0:** Required for a safe, useful MVP pilot release.
* **P1:** Important for launch quality, but can be staged after the core reporting, verification, and alert loop.
* **P2:** Future planning item that should be documented now but not implemented in the MVP build.

## Personas

* **Citizen reporter:** A person submitting a civic safety or public hazard report.
* **Nearby citizen:** A person who may receive safety alerts or view public board records.
* **Reviewer/operator:** A trusted human reviewer who verifies, rejects, publishes, or resolves reports.
* **Administrator:** A privileged user responsible for oversight, moderation, audit review, and configuration.
* **Helper requester:** A person asking for limited community assistance while protecting exact location by default.

## P0 Stories

### US-01: One-Tap Incident Reporting

**Backlog link:** BL-01

**Feature name:** One-tap incident reporting

**User story:** As a citizen reporter, I want to submit a civic safety incident quickly so nearby people and reviewers can understand the risk without exposing my private identity.

**Acceptance criteria:**

* A reporter can choose one MVP incident type: flood, electric hazard, pothole/road hazard, unsafe area, or general civic safety.
* A reporter can add a short description, optional media, and location metadata.
* The public-facing record uses approximate location by default.
* The submission is created with a `submitted` verification status.
* The submission records a creation audit event.

**Priority:** P0

**Dependencies:** Mobile intake flow, backend incident endpoint, database incident record, audit log requirements.

**Privacy and safety notes:** Do not expose reporter identity or exact location in public views. Exact location should be stored only for authorized workflows and future consent-based use.

**QA focus:** Required field validation, optional media handling, approximate-location display, audit creation, and submission failure states.

### US-02: MVP Incident Categories

**Backlog link:** BL-02

**Feature name:** Incident category taxonomy

**User story:** As a reviewer/operator, I want reports grouped into consistent MVP categories so that verification, routing, alerting, and solution guidance can be applied reliably.

**Acceptance criteria:**

* MVP incident categories include flood, electric hazard, pothole/road hazard, unsafe area, and general civic safety.
* Each submitted incident has exactly one primary category.
* Category labels are understandable to citizens and reviewers.
* Category values can be used consistently by backend, database, AI scoring, QA, and mobile flows.
* Category naming avoids assigning legal blame or implying that unverified allegations are facts.

**Priority:** P0

**Dependencies:** Product scope, incident model, mobile reporting form, backend validation, database reference data or enum.

**Privacy and safety notes:** Category labels should describe observable hazards, not private individuals or accusations.

**QA focus:** Category validation, unsupported category rejection, display consistency, and downstream routing compatibility.

### US-03: Incident Verification Status Workflow

**Backlog link:** BL-03

**Feature name:** Incident verification status

**User story:** As a reviewer/operator, I want each report to move through clear review states so public information is trusted and sensitive reports are not published automatically.

**Acceptance criteria:**

* Incidents support the MVP states: `submitted`, `needs_review`, `verified`, `rejected`, `published`, and `resolved`.
* Status changes require reviewer notes or a system-generated reason.
* Status changes create audit log entries with actor, timestamp, previous state, and new state.
* AI scoring can recommend a status but cannot final-approve legal, corruption, petition, helper safety, or sensitive public publishing workflows.
* Rejected or resolved records remain available for authorized audit review.

**Priority:** P0

**Dependencies:** Backend incident workflow, database status fields, audit logging, AI scoring rules.

**Privacy and safety notes:** Treat AI as decision support only. Do not silently delete public accountability records.

**QA focus:** Valid state transitions, invalid transition blocking, reviewer note requirements, audit entries, and human-review enforcement for sensitive cases.

### US-04: AI-Assisted Verification Scoring

**Backlog link:** BL-04

**Feature name:** AI-assisted verification scoring

**User story:** As a reviewer/operator, I want rule-based AI assistance so I can prioritize reports and apply consistent safety guidance without giving automated systems final authority.

**Acceptance criteria:**

* The MVP scoring service can suggest severity, confidence, department category, alert radius, sensitive flag, and recommended review status.
* Scoring inputs are limited to incident category, description, metadata, location approximation, and reviewer-safe evidence fields.
* The system displays AI output as a recommendation, not a final decision.
* Sensitive flags force or preserve human review before public publishing.
* AI recommendation generation is auditable when it materially affects status, alerting, or public display decisions.

**Priority:** P0

**Dependencies:** AI verification rules, backend incident workflow, department taxonomy, audit logging.

**Privacy and safety notes:** Do not send private identity, exact location, or sensitive media metadata to future external AI services without a separate privacy review.

**QA focus:** Deterministic scoring examples, sensitive flag behavior, reviewer override behavior, and audit coverage.

### US-05: Geo-Fenced Safety Alerts

**Backlog link:** BL-05

**Feature name:** Geo-fenced safety alerts

**User story:** As a nearby citizen, I want to receive relevant safety alerts so I can avoid immediate hazards in my area.

**Acceptance criteria:**

* Only verified critical incidents can trigger public safety alerts.
* Alert radius is based on incident type and severity, with reviewer override support.
* Alerts describe the hazard, approximate area, and recommended safety action.
* Alerts do not reveal reporter identity or exact reporter location.
* Alert creation and reviewer override actions create audit log entries.

**Priority:** P0

**Dependencies:** Verification workflow, location metadata, notification planning, AI radius suggestion rules.

**Privacy and safety notes:** Keep alert language practical and non-alarming. Avoid naming private individuals or disclosing sensitive evidence.

**QA focus:** Alert eligibility, radius calculation/override, approximate-area presentation, duplicate alert handling, and audit entries.

### US-06: Privacy Protection for Public Views

**Backlog link:** BL-06

**Feature name:** Privacy protection

**User story:** As a citizen reporter, I want my identity and exact location protected so I can report safety issues without unnecessary personal risk.

**Acceptance criteria:**

* Public views hide reporter name, contact details, exact coordinates, and private media metadata.
* Public records show only an approximate area suitable for civic awareness.
* Sensitive reports require human review before publishing.
* Exact location sharing requires explicit user consent for helper workflows.
* Privacy-related actions and exceptions are auditable.

**Priority:** P0

**Dependencies:** Security/privacy requirements, backend authorization, public board design, helper request consent flow.

**Privacy and safety notes:** Privacy constraints apply across mobile, web, backend, database, AI verification, and QA tasks.

**QA focus:** Public DTO redaction, authorization checks, sensitive-case publishing gates, consent enforcement, and audit visibility.

### US-07: Sensitive Action Audit Trail

**Backlog link:** BL-07

**Feature name:** Audit logs

**User story:** As an administrator, I want sensitive actions recorded in an audit trail so platform decisions can be reviewed and accountability records are not silently changed.

**Acceptance criteria:**

* Audit logs capture actor, action, target entity, timestamp, previous value, new value, and reason when applicable.
* Incident creation, verification changes, alert creation, reviewer overrides, public board visibility changes, helper consent, and exact-location access are auditable.
* Audit records are available only to authorized reviewer or administrator workflows.
* Audit records are append-oriented and are not silently deleted.
* Audit log failures are treated as blocking for sensitive state changes where practical in the MVP.

**Priority:** P0

**Dependencies:** Database audit model, backend audit service, authorization rules, sensitive workflow definitions.

**Privacy and safety notes:** Audit logs may contain sensitive operational metadata and must not be exposed publicly.

**QA focus:** Audit creation for each sensitive event, authorization boundaries, immutable/update restrictions, and failure behavior.

## P1 Stories

### US-08: Public Accountability Board

**Backlog link:** BL-08

**Feature name:** Public accountability board

**User story:** As a nearby citizen, I want to track verified civic issues so I can see public status, responsible department guidance, and progress updates.

**Acceptance criteria:**

* The board lists only verified or published incidents.
* Each board item shows incident type, approximate area, status, severity, department guidance, and latest public update.
* Reporter identity and exact location are never shown publicly.
* Updates to board visibility, status, and resolution are auditable.
* Records are not silently removed; removal from public display requires a documented moderation or safety reason.

**Priority:** P1

**Dependencies:** Verification workflow, public view model, backend listing endpoint, audit logs.

**Privacy and safety notes:** Board content should support accountability without turning unverified allegations into public claims.

**QA focus:** Public filtering, privacy redaction, status/update display, moderation reason capture, and non-deletion behavior.

### US-09: Public Issue Updates

**Backlog link:** BL-09

**Feature name:** Public issue updates

**User story:** As a reviewer/operator, I want to add public progress updates to verified issues so the community can understand what changed without losing history.

**Acceptance criteria:**

* A verified or published board item can receive a public update with status text, timestamp, and reviewer attribution suitable for public display.
* Updates do not expose reporter identity, exact location, private notes, or sensitive evidence.
* Updating a record creates an audit entry with previous and new public status details.
* Removing an update from public display requires a moderation or safety reason.
* Authorized users can still review historical updates and moderation reasons.

**Priority:** P1

**Dependencies:** Public accountability board, audit logs, reviewer workflow, public/private field separation.

**Privacy and safety notes:** Public update text must not publish unverified allegations or private user details.

**QA focus:** Update creation, public/private field separation, moderation flow, audit trail, and history review.

### US-10: Solution Suggestions

**Backlog link:** BL-10

**Feature name:** Solution hub

**User story:** As a nearby citizen, I want practical next-step suggestions so I can understand safe civic actions for a verified issue.

**Acceptance criteria:**

* Suggestions can include safety precautions, responsible department category, and recommended non-legal escalation path.
* Suggestions are tied to incident type, severity, and verification status.
* Suggestions avoid legal advice, accusations, or guaranteed outcomes.
* Sensitive suggestions are reviewed before public publishing.
* Suggestion creation or reviewer edits are auditable.

**Priority:** P1

**Dependencies:** AI rules, backend suggestion model, reviewer workflow, public board.

**Privacy and safety notes:** In MVP, suggestions can be rule-based. Do not integrate production AI models for this story.

**QA focus:** Rule mapping, sensitive suggestion gating, public wording review, and audit entries.

### US-11: Verified Helper Requests

**Backlog link:** BL-11

**Feature name:** Verified helper requests

**User story:** As a helper requester, I want to request assistance while showing only an approximate area until I consent to share exact location.

**Acceptance criteria:**

* Helper requests show approximate location first.
* Exact location sharing requires explicit requester consent.
* Helper request visibility depends on verification or reviewer approval.
* Helper actions involving consent, visibility, or exact location are auditable.
* The product flow includes safety copy that discourages unsafe in-person contact and emergency misuse.

**Priority:** P1

**Dependencies:** Mobile consent flow, backend helper request workflow, security/privacy review, audit logs.

**Privacy and safety notes:** This workflow is sensitive. Do not expose vulnerable users, exact location, or identity publicly.

**QA focus:** Consent flow, approximate-first display, exact-location access controls, helper visibility approval, and audit coverage.

### US-12: Helper Safety and Emergency Misuse Copy

**Backlog link:** BL-12

**Feature name:** Helper safety guidance

**User story:** As a helper requester, I want clear safety guidance so I understand when to use emergency services and how to avoid unsafe interactions.

**Acceptance criteria:**

* Helper request screens include copy stating the app is not a replacement for emergency dispatch.
* The flow discourages unsafe in-person contact with strangers.
* The flow explains approximate location first and consent-based exact location sharing.
* Safety guidance is visible before a request becomes public or helper-visible.
* Safety copy changes are reviewed as part of security/privacy QA.

**Priority:** P1

**Dependencies:** Helper request UX, privacy guidance, QA test plan.

**Privacy and safety notes:** Safety content should protect vulnerable users and reduce misuse of helper workflows.

**QA focus:** Copy visibility, consent explanation, emergency disclaimer, and safety regression checks.

## P2 Stories

### US-13: Petition and Legal-Aid Planning

**Backlog link:** BL-13

**Feature name:** Petition/legal-aid planning

**User story:** As a citizen reporter with an unresolved civic issue, I may need escalation guidance, but I need the product to avoid automated legal claims or unsafe public accusations.

**Acceptance criteria:**

* MVP documentation identifies petition and legal-aid workflows as future scope.
* No automated petition filing, legal advice, or legal-aid matching is included in the MVP.
* Future escalation workflows require human review and security/privacy review.
* Any future sensitive public publishing must include audit logs and documented reviewer decisions.

**Priority:** P2

**Dependencies:** Product planning, legal/privacy review, public accountability governance.

**Privacy and safety notes:** Keep this as planning only until a dedicated legal/privacy task is approved.

**QA focus:** Scope checks that prevent accidental MVP implementation of legal advice, legal matching, or automated petition filing.

### US-14: External Authority and Dispatch Integration Planning

**Backlog link:** BL-14

**Feature name:** External integration planning

**User story:** As an administrator, I want future external authority or dispatch integrations documented separately so MVP work does not overpromise real-time emergency response.

**Acceptance criteria:**

* MVP documentation states real-time dispatch, authority ticketing, payment, and production third-party alert integrations are out of scope.
* Future external data sharing requires data minimization, consent analysis, and security/privacy review.
* Any future integration must define audit requirements before implementation.
* MVP user-facing copy must not imply guaranteed emergency or government response.

**Priority:** P2

**Dependencies:** Product scope, architecture planning, security/privacy review.

**Privacy and safety notes:** External integrations can expose sensitive location or identity data and require separate governance.

**QA focus:** Scope guardrails, user-facing copy review, and prevention of unapproved external sharing.

## Story Traceability Matrix

| Story | Backlog item | Primary module(s) | Must-have audit coverage | Public privacy requirement |
| --- | --- | --- | --- | --- |
| US-01 | BL-01 | Mobile, Backend, DB | Incident creation | Approximate location and anonymous reporter display |
| US-02 | BL-02 | Product, Backend, DB | Category changes if admin-managed | Labels avoid accusations or private identity |
| US-03 | BL-03 | Backend, DB, AI | Status transitions and reviewer notes | Sensitive reports require human review before publishing |
| US-04 | BL-04 | AI, Backend | AI recommendations affecting workflow decisions | No unnecessary identity or exact-location data in AI context |
| US-05 | BL-05 | Backend, Mobile, AI | Alert creation and radius override | Alert uses approximate area only |
| US-06 | BL-06 | Security, Backend, Mobile | Privacy exceptions and consent events | Public DTOs redact identity, exact location, and private metadata |
| US-07 | BL-07 | Backend, DB | All sensitive actions | Audit logs are authorized-only, not public |
| US-08 | BL-08 | Web/Mobile, Backend | Board visibility, status, and resolution changes | Board lists verified/published records only |
| US-09 | BL-09 | Web/Mobile, Backend | Public update and moderation changes | Public updates exclude private notes and evidence |
| US-10 | BL-10 | AI, Backend | Suggestion creation and edits | Suggestions avoid legal advice and accusations |
| US-11 | BL-11 | Mobile, Backend, Security | Consent, visibility, exact-location access | Approximate location first; exact location by consent only |
| US-12 | BL-12 | Product, Mobile, QA | Safety copy approval if tracked | Copy explains privacy and emergency limitations |
| US-13 | BL-13 | Product, Security | Future workflow decisions | No MVP legal automation or sensitive publishing without review |
| US-14 | BL-14 | Product, Architecture, Security | Future external sharing decisions | No unapproved external sharing of identity or exact location |

## Cross-Story Product Guardrails

* Public pages must use approximate location and anonymous reporter presentation by default.
* Sensitive workflows require human review before public publishing.
* AI verification is decision support only and must never be the sole final authority for sensitive outcomes.
* Every sensitive action must leave an audit trail.
* MVP work should remain modular so future agents can implement mobile, backend, database, QA, AI, and security tasks independently.
