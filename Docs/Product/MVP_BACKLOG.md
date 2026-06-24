# MVP Product Backlog

## Purpose

This backlog translates the SurakshaNet AI MVP scope into small, reviewable work items for Product, Architecture, Database, Backend, Flutter, AI, QA, Security, and Documentation agents.

The backlog is implementation-aware. It distinguishes between functionality that is currently mocked or scaffolded and functionality that is genuinely usable. A screen, model, controller, or status endpoint does not by itself make a backlog item complete.

## Priority Model

* **P0 — Safe pilot blocker:** Required before any external pilot involving real users or real incident data.
* **P1 — MVP completion:** Required for the intended MVP experience, but may follow the first secure reporting loop.
* **P2 — Deferred planning:** Explicitly outside the implementation scope of the current MVP.

## Current Implementation Baseline — 24 June 2026

| Area | Current state | Backlog consequence |
| --- | --- | --- |
| Flutter application | Splash, mock login, home, mock incident form, mock report list, mock nearby alerts, and profile placeholder exist. No API integration or generated platform runners are included. | Mobile work must replace mock repositories incrementally rather than recreate screens blindly. |
| Backend API | Health/module endpoints, basic incident create/read flow, audit write on incident creation, and approximate-location nearby alert lookup exist. Most other modules are status-only foundations. | Backend work should first secure and complete the existing incident flow before expanding to public board or helper features. |
| SQL Server | MVP schema and seed scripts exist, but EF models and the SQL schema are not fully aligned and there is no migration workflow. | Schema parity and migration safety are P0 technical prerequisites. |
| Verification | Deterministic verification rules are documented, but no verification service or reviewer workflow is implemented. | AI-assisted verification remains a P0 blocker for trusted alert/publication workflows. |
| Security | Privacy rules are documented; real authentication, consent records, role management, and complete authorization are not implemented. | Authentication, RBAC, DTO redaction, and consent enforcement must precede sensitive workflows. |
| QA/CI | Flutter widget tests cover a few mock flows. No backend test project or CI workflow is present. | Automated P0 privacy, authorization, transition, and audit tests are mandatory before pilot. |

## Backlog

| ID | Priority | Backlog item | Current maturity | Pilot outcome | Primary owner | Dependencies |
| --- | --- | --- | --- | --- | --- | --- |
| BL-00 | P0 | Build and contract baseline | Partially implemented | Flutter and .NET projects build in CI; API/DB contracts are aligned and documented. | Engineering Manager + Architecture + QA | None |
| BL-01 | P0 | Secure identity and role foundation | Scaffolded | Citizens, reviewers, and administrators authenticate through secure flows with server-enforced roles. | Backend + Security | BL-00 |
| BL-02 | P0 | Privacy-safe incident intake | Partially implemented | Authenticated citizens can submit validated incident reports; private and public-safe data remain separated. | Mobile + Backend + DB | BL-01 |
| BL-03 | P0 | Incident ownership and private report history | Mock only | Citizens can list and view only their own private reports through authenticated endpoints. | Backend + Mobile | BL-01, BL-02 |
| BL-04 | P0 | Verification status workflow | Not started | Reports move through controlled states with reasons, reviewer authorization, and audit history. | Backend + DB + Security | BL-01, BL-02 |
| BL-05 | P0 | Deterministic AI-assisted scoring | Documentation only | Rule-based scoring produces explainable severity, confidence, sensitivity, department, and radius recommendations without final-publishing authority. | AI + Backend | BL-04 |
| BL-06 | P0 | Sensitive action audit trail | Partially implemented | Every sensitive state change is recorded with a real actor, target, timestamp, reason, and safe change metadata. | Backend + DB | BL-01, BL-04 |
| BL-07 | P0 | Privacy-safe geo-fenced alerts | Partially implemented | Only eligible reviewer-approved hazards produce active alerts; responses expose approximate risk areas, not reporter identity or exact incident coordinates. | Backend + Mobile + Security | BL-04, BL-05, BL-06 |
| BL-08 | P0 | Public/private DTO and authorization boundary | Partially documented | Public, citizen, reviewer, and administrator responses are explicitly separated and covered by authorization/redaction tests. | Architecture + Backend + Security + QA | BL-01, BL-02 |
| BL-09 | P0 | Automated quality gate | Not started | Pull requests automatically build, lint, and test Flutter and .NET code; P0 privacy/security failures block merge. | QA + Engineering Manager | BL-00 |
| BL-10 | P1 | Public accountability board | Scaffolded | Users can view verified, privacy-safe issues and status history; moderation never silently deletes accountability history. | Backend + Mobile/Web | BL-04, BL-06, BL-08 |
| BL-11 | P1 | Public issue progress updates | Not started | Authorized reviewers publish safe progress updates with history and audit records. | Backend + Mobile/Web | BL-10 |
| BL-12 | P1 | Practical solution suggestions | Scaffolded | Verified issues receive safe, non-legal, rule-based guidance and department routing. | AI + Backend + Mobile | BL-05, BL-10 |
| BL-13 | P1 | Verified helper requests | Scaffolded | Requests begin with approximate location; exact-location access is recipient-scoped, time-scoped, consented, revocable, and audited. | Backend + Mobile + Security | BL-01, BL-06, BL-08 |
| BL-14 | P1 | Helper safety and misuse prevention | Documentation only | Helper flows include emergency disclaimers, safety guidance, abuse reporting, and visibility controls before launch. | Product + Security + Mobile + QA | BL-13 |
| BL-15 | P1 | Evidence and media handling | Schema only | Evidence upload, restricted access, metadata stripping, redaction state, and safe publication are implemented and audited. | Backend + Mobile + Security | BL-01, BL-02, BL-06 |
| BL-16 | P1 | Operational backup and restore validation | Documentation only | Non-production backup and restore procedures are tested; production strategy defines encryption, access control, retention, and restore verification. | DB + Security + Engineering Manager | BL-00 |
| BL-17 | P2 | Petition and legal-aid automation | Deferred | Remains documentation-only pending legal, safety, privacy, and governance approval. | Product + Security | Future approval |
| BL-18 | P2 | Real-time authority/dispatch integrations | Deferred | No real-time dispatch, authority ticketing, payment, or unsupported third-party commitment is included in the MVP. | Product + Architecture | Future approval |
| BL-19 | P2 | External model-backed AI service | Deferred | External AI is considered only after deterministic scoring, privacy boundaries, reviewer workflows, and evaluation are stable. | AI + Security + Architecture | BL-05 complete and evaluated |

## Measurable Acceptance Criteria

### BL-00 — Build and contract baseline

* `flutter analyze` and `flutter test` run successfully from the documented mobile path.
* `dotnet restore`, `dotnet build`, and backend tests run successfully from the documented server path.
* SQL schema, seed scripts, EF entities, and endpoint DTOs have a documented parity review with no unexplained field or status mismatch.
* Development configuration contains no usable production secrets.

### BL-01 — Secure identity and role foundation

* Registration and login validate inputs and never return password hashes.
* Passwords use an approved password-hashing implementation; tokens have issuer, audience, expiry, and signing validation.
* Server authorization distinguishes at minimum Citizen, Reviewer, and Admin roles.
* Missing authentication returns `401`; insufficient role returns `403`.
* Role assignment and privileged identity changes create audit events.
* Automated tests cover valid login, invalid credentials, expired/invalid token, and role denial.

### BL-02 — Privacy-safe incident intake

* The server validates supported category, description limits, coordinate ranges, and consent fields.
* Clients cannot set verification outcome, publication state, reviewer identity, audit actor, or internal scoring fields.
* A successful submission starts in the documented initial state and creates an audit event linked to the authenticated actor.
* Public-safe responses exclude reporter identity, contact details, exact coordinates, raw evidence locations, and internal notes.
* Failed validation returns the stable documented error shape.

### BL-03 — Incident ownership and private report history

* `GET` endpoints for “my reports” require authentication and filter by the authenticated user on the server.
* A citizen cannot read another citizen's private report by changing an identifier.
* Lists support deterministic ordering and bounded pagination or result limits.
* Mobile report cards open an incident detail view with loading, empty, error, and retry states.
* Authorization and ownership tests are present.

### BL-04 — Verification status workflow

* Supported states and transitions are defined once and used consistently by DB, backend, mobile, and QA.
* Invalid transitions return `409` without changing persisted state.
* Reviewer actions require an authorized role and a non-empty reason where required.
* Previous state, new state, actor, timestamp, and reason are audit recorded.
* Sensitive incidents cannot become public through an automated transition.

### BL-05 — Deterministic AI-assisted scoring

* The scorer implements the documented input and output contract.
* Repeated execution with the same inputs produces the same MVP result.
* Outputs include score components and concise rationale suitable for reviewer inspection.
* The scorer never returns `verified`, `published`, or `resolved` as an automated final decision.
* Sensitive triggers force human review.
* Automated examples cover flood, electric hazard, road hazard, vague report, duplicate reports, and sensitive allegations.

### BL-06 — Sensitive action audit trail

* Audit events use the authenticated actor rather than a generic hardcoded actor for user actions.
* Required events include incident creation, verification/reviewer decisions, alert changes, publication/moderation changes, consent grant/revoke/access, evidence privilege access, and role changes.
* Audit metadata excludes secrets, tokens, passwords, raw evidence, and unnecessary exact coordinates.
* Audit access requires Reviewer or Admin authorization and is itself auditable when enabled.
* Sensitive state changes fail safely when the required audit event cannot be persisted.

### BL-07 — Privacy-safe geo-fenced alerts

* Only active, non-expired, reviewer-approved alerts are returned publicly.
* Alert eligibility is connected to verification state rather than seeded status alone.
* Radius validation and reviewer override reason are enforced.
* Alert responses do not include reporter identity, private evidence, or exact incident coordinates.
* Location matching handles missing, invalid, and out-of-radius coordinates predictably.
* Backend and mobile tests cover inside radius, outside radius, expired alert, cancelled alert, and no-location behavior.

### BL-08 — Public/private DTO and authorization boundary

* Separate response contracts exist for public, citizen-owner, reviewer, and admin use cases.
* Domain/EF entities are not serialized directly from controllers.
* Public endpoints are covered by tests asserting absence of restricted fields.
* Unauthorized resource access does not reveal whether another user's private record exists.
* Exact location is available only through an explicitly approved consent-scoped workflow.

### BL-09 — Automated quality gate

* Pull requests run Flutter analyze/tests and .NET restore/build/tests.
* Workflow files use no committed credentials and reference repository secrets only when required.
* A failing test or analysis step fails the workflow.
* Build/test instructions in README files match the CI commands.
* At least one privacy test and one authorization test are part of the mandatory backend suite before pilot.

## MVP Release Slices

### Slice 0 — Engineering and security foundation

BL-00, BL-01, BL-08, BL-09.

### Slice 1 — Trusted reporting loop

BL-02, BL-03, BL-04, BL-06.

### Slice 2 — Verification and protection

BL-05, BL-07.

### Slice 3 — Accountability and guidance

BL-10, BL-11, BL-12.

### Slice 4 — Community help and evidence

BL-13, BL-14, BL-15, BL-16.

## Definition of Ready

A backlog item is ready for implementation only when:

1. Its user story and measurable acceptance criteria are linked.
2. Public, citizen-owner, reviewer, and admin data visibility is stated.
3. Required audit events are identified.
4. Dependencies are completed or explicitly mocked behind a documented interface.
5. QA can derive functional, negative, privacy, authorization, and misuse cases.
6. Allowed folders and out-of-scope behavior are listed in the GitHub issue.

## Definition of Done

A backlog item is done only when:

1. Acceptance criteria are implemented and traceable to tests.
2. Mock or fixture-backed behavior is not represented as production functionality.
3. Required authorization, redaction, consent, and audit controls are enforced server-side.
4. Loading, empty, validation, error, retry, and unauthorized states are handled where applicable.
5. Relevant README, architecture, security, QA, and API documentation is updated.
6. CI passes and no secret or production credential is introduced.
7. Remaining limitations and follow-up work are recorded explicitly.

## Deferred Scope Guardrail

BL-17 through BL-19 remain planning items only. They must not be implemented through unrelated MVP issues or silently introduced as dependencies. Any movement into active scope requires a dedicated Product, Architecture, Security, and Legal/Governance review.
