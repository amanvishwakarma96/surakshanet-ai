# MVP Product Backlog

## Purpose

This backlog translates the SurakshaNet AI MVP scope into reviewable product work for issue #4. It is intentionally implementation-neutral so backend, mobile, database, AI, QA, security, and documentation agents can create follow-up tasks without changing the product intent.

## Prioritization Model

* **P0 - MVP critical:** Required before a safe pilot release.
* **P1 - Launch quality:** Important for a credible pilot, but can be staged after the core report-review-alert loop.
* **P2 - Future planning:** Documented now to prevent unsafe scope creep; not planned for MVP implementation.

## MVP Backlog

| ID | Priority | Epic | Backlog item | User value | Acceptance summary | Primary owner | Dependencies | Privacy / audit notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| BL-01 | P0 | Incident intake | One-tap incident reporting | Citizens can quickly report hazards without needing to understand internal workflows. | Reporter can choose an MVP incident type, add description, optional media, and location metadata; report starts as `submitted`; creation is audited. | Mobile + Backend | Incident model, create incident API, audit log model | Public views must use approximate location and anonymous reporter display. |
| BL-02 | P0 | Incident intake | MVP incident categories | Reviewers and future routing rules receive consistent incident types. | MVP supports flood, electric hazard, pothole/road hazard, unsafe area, and general civic safety categories. | Product + Backend | Product taxonomy, database enum/reference data | Categories must not imply unverified legal fault or public accusation. |
| BL-03 | P0 | Verification | Verification status workflow | Operators can move reports through trusted review states. | Incidents support `submitted`, `needs_review`, `verified`, `rejected`, `published`, and `resolved`; status changes require a reason and audit entry. | Backend + DB | Incident repository/service, audit logging | AI may recommend, but human review is required for sensitive publishing. |
| BL-04 | P0 | Verification | AI-assisted scoring rules | Reviewers receive consistent decision support for severity, department, radius, and sensitivity. | Mock/rule-based scoring can produce severity, confidence, recommended status, department hint, alert radius, and sensitive flag. | AI + Backend | Verification rules documentation, incident data | AI output must be labeled decision support and cannot final-approve sensitive workflows. |
| BL-05 | P0 | Alerts | Geo-fenced safety alerts | Nearby citizens receive relevant warning information for verified critical hazards. | Verified critical incidents can generate alerts containing hazard type, approximate area, safety action, and radius; overrides are audited. | Backend + Mobile | Verification status, location metadata, alert radius rules | Alerts must not expose reporter identity, exact reporter location, or private media metadata. |
| BL-06 | P0 | Privacy | Public privacy protection | Reporters can participate without unnecessary personal risk. | Public surfaces hide reporter identity, contact details, exact coordinates, and sensitive media metadata; exceptions require documented approval. | Security + Backend + Mobile | Public DTO/view-model design, authorization rules | Privacy exceptions and consent events must be auditable. |
| BL-07 | P0 | Auditability | Sensitive action audit trail | Admin, moderation, publishing, helper, and consent actions can be reviewed later. | Sensitive actions capture actor, action, target, timestamp, previous value, new value, and reason where applicable. | Backend + DB | Audit log schema/service | Audit logs are append-oriented and not silently deleted. |
| BL-08 | P1 | Public accountability | Public accountability board | Community members can track verified civic issues and resolution progress. | Board lists verified/published records with type, approximate area, severity, status, department guidance, and latest public update. | Web/Mobile + Backend | Verification workflow, public DTOs, audit logging | Unverified allegations are not published as public claims; removal needs a documented moderation reason. |
| BL-09 | P1 | Public accountability | Public issue updates | Reviewers can add progress updates without rewriting history. | Public records support status/update history for verified issues; changes are visible where safe and auditable. | Backend + Web/Mobile | Public board, audit logs | Public accountability records must not be silently deleted. |
| BL-10 | P1 | Solutions | Practical solution suggestions | Citizens see safe, non-legal next steps for verified civic problems. | Suggestions can include safety precautions, department category, and civic escalation guidance; sensitive suggestions require review. | AI + Backend | Rule-based suggestion mapping, public board | Avoid legal advice, accusations, and guaranteed outcomes. |
| BL-11 | P1 | Helper requests | Verified helper requests | People can request limited community help while protecting exact location by default. | Requests show approximate area first; visibility requires verification/reviewer approval; exact location sharing requires consent. | Mobile + Backend + Security | Consent model, helper request workflow, audit logs | Consent, visibility, and exact-location access must be audited. |
| BL-12 | P1 | Safety content | Helper safety and emergency misuse copy | Users understand that the app is not an emergency dispatch replacement. | Helper flow includes safety guidance, emergency escalation copy, and warnings against unsafe in-person contact. | Product + Mobile | Helper request UX | Safety copy should reduce misuse and protect vulnerable users. |
| BL-13 | P2 | Escalation | Petition and legal-aid planning | Future escalation is acknowledged without unsafe MVP automation. | Documentation states petition filing, legal advice, legal-aid matching, and automated public accusations are out of MVP scope. | Product + Security | Legal/privacy review in future task | Human review is required before future sensitive public publishing. |
| BL-14 | P2 | Integrations | External authority/dispatch integrations | Future integrations are planned separately from MVP. | MVP does not include real-time dispatch, payment, authority ticketing, or production third-party alert integrations. | Product + Architecture | Future integration requirements | External sharing requires privacy review and data minimization. |

## MVP Release Slices

### Slice 1: Safe reporting foundation

* BL-01 One-tap incident reporting
* BL-02 MVP incident categories
* BL-06 Public privacy protection
* BL-07 Sensitive action audit trail

### Slice 2: Trusted review and alert loop

* BL-03 Verification status workflow
* BL-04 AI-assisted scoring rules
* BL-05 Geo-fenced safety alerts

### Slice 3: Public accountability and guidance

* BL-08 Public accountability board
* BL-09 Public issue updates
* BL-10 Practical solution suggestions

### Slice 4: Community help and future guardrails

* BL-11 Verified helper requests
* BL-12 Helper safety and emergency misuse copy
* BL-13 Petition and legal-aid planning
* BL-14 External authority/dispatch integrations

## Definition of Ready for Follow-Up Implementation Issues

A backlog item is ready for implementation when it has:

1. A linked user story in `Docs/Product/MVP_USER_STORIES.md`.
2. Clear privacy expectations for public, reviewer, and admin views.
3. Acceptance criteria that QA can convert into test cases.
4. Known dependencies identified across mobile, backend, database, AI, security, and documentation.
5. A confirmation that the task does not introduce secrets, production credentials, or unsupported third-party commitments.

## Definition of Done for MVP Product Backlog Items

A backlog item is done when:

1. Acceptance criteria are met or explicitly deferred in release notes.
2. Sensitive actions are covered by audit logging requirements.
3. Public outputs avoid reporter identity and exact location unless a documented consent workflow applies.
4. Human review remains required for legal, corruption, petition, helper safety, and sensitive publishing workflows.
5. QA has traceable test coverage for happy path, edge cases, privacy, and misuse prevention.
