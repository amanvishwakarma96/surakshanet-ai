# Agent Task Assignments

Project: SurakshaNet AI  
Coordinator: Project Manager Agent  
Current execution stage: Phase 1 planning kickoff

## Assignment Rules

* Each agent must work only inside its allowed folders.
* Each agent must keep work small, issue-scoped, and reviewable.
* No agent should implement the full application in one task.
* Security and privacy notes are required for every workflow that touches identity, location, public publishing, evidence, helper requests, corruption complaints, petitions, or audit logs.
* Implementation agents must wait for required planning dependencies before writing runnable code.
* AI verification is decision support only; legal, corruption, petition, and sensitive public publishing workflows require human review.

---

## Phase 1 Task Assignments

These are the first tasks to assign now. They prepare the repository for safe module-by-module implementation.

| Order | Task | Assigned agent | Priority | Status | Allowed folders | Dependencies | Expected output |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Expand Product MVP Backlog | Product Manager Agent | High | Ready | `Docs/Product/`, `Docs/Management/` | Repository setup complete | Issue-sized user stories with acceptance criteria, dependencies, priorities, and privacy notes. |
| 2 | Expand Architecture Overview | System Architect Agent | High | Blocked until Task 1 baseline is reviewed | `Docs/Architecture/` | Product backlog | Updated architecture, API modules, DB modules, security boundaries, and integration order. |
| 3 | Expand AI Verification Rules | AI Verification Agent | High | Can start after Task 1 critical issue list is confirmed | `Docs/AI/` | Product backlog | Critical issue rules, scoring matrix, JSON contract, examples, and future AI upgrade path. |
| 4 | Security and Privacy MVP Review | Security and Privacy Agent | High | Can start after Tasks 1 and 2 draft sensitive flows | `Docs/Security/` | Product backlog, architecture | Risk register by module, protection requirements, blocker list, and security checklist. |
| 5 | QA MVP Test Matrix | QA Tester Agent | High | Can start after Tasks 1, 3, and 4 draft outputs | `Docs/QA/`, `Tests/` | Product backlog, AI rules, security review | Test cases for functional, negative, privacy, security, edge, and release-gate coverage. |
| 6 | Phase 1 Status and Blocker Tracking | Engineering Manager Agent | High | Ready | `Docs/Management/`, `Docs/Agents/` | This assignment document | Phase 1 status board, blockers, parallelization plan, and next issue prompts. |
| 7 | Business Pilot Strategy | Business Intelligence Agent | Medium | Can run parallel after Task 1 | `Docs/Product/`, `Docs/Business/` | Product backlog | Pilot targets, value proposition, revenue assumptions, risks, and recommendation. |
| 8 | Documentation Index Cleanup | Documentation Manager Agent | Medium | Can run after Phase 1 docs stabilize | `Docs/`, `README.md`, `.github/` | Tasks 1-6 | README/doc index updates linking final Phase 1 planning docs. |

---

## Engineering Implementation Assignments

These assignments should start only after Phase 1 exit criteria are met.

| Phase | Task | Assigned agent | Priority | Allowed folders | Required dependency | Definition of Ready |
| --- | --- | --- | --- | --- | --- | --- |
| Phase 2 | SQL Server MVP schema and seed data | Database Engineer Agent | High | `DB/`, `Backup/` | Product backlog and architecture approved | Required tables, entity relationships, privacy fields, and audit requirements are documented. |
| Phase 3 | .NET 8 backend API foundation | Backend Developer Agent | High | `Server/` | Architecture approved; DB schema in progress or complete | API module boundaries, DTO expectations, config rules, and audit service pattern are documented. |
| Phase 4 | Flutter mobile app foundation | Flutter Developer Agent | High | `Mobile/` | Product backlog and architecture approved | Required screens, navigation flow, mock mode, and API contract expectations are documented. |
| Phase 5 | Mock AI verification backend service | AI Verification Agent + Backend Developer Agent | High | `Docs/AI/`, `Server/` | AI rules and backend foundation complete | Scoring contract is stable and QA test scenarios exist. |
| Phase 6 | Geo-fence and active alert flow | Backend Developer Agent + Flutter Developer Agent + AI Verification Agent | High | `Server/`, `Mobile/`, `Docs/AI/` | Incident flow and AI verification rules complete | Critical incident status flow and alert DTO contract are available. |
| Phase 7 | Public board and solution hub | Backend Developer Agent + Flutter Developer Agent + Security and Privacy Agent | Medium | `Server/`, `Mobile/`, `Docs/Security/` | Incident flow, security review, and public DTO rules complete | Public publishing rules and no-silent-delete audit behavior are approved. |
| Phase 8 | Verified helper MVP | Backend Developer Agent + Flutter Developer Agent + Security and Privacy Agent | Medium | `Server/`, `Mobile/`, `Docs/Security/` | Helper safety review and consent model complete | Approximate-first location and exact-location consent behavior are approved. |
| Phase 9 | Release QA, security, and documentation cleanup | QA Tester Agent + Security and Privacy Agent + Documentation Manager Agent + Engineering Manager Agent | High | `Docs/QA/`, `Tests/`, `Docs/Security/`, `Docs/`, `Docs/Management/` | All MVP modules complete | P0 tests, privacy checks, security findings, and documentation gaps are tracked. |

---

## Agent-Specific Task Cards

### Product Manager Agent

**Current task:** Expand Product MVP Backlog.

**Prompt to assign:**

```text
You are the Product Manager Agent for SurakshaNet AI.

Update Docs/Product/MVP_SCOPE.md and Docs/Product/MVP_BACKLOG.md so the MVP backlog is ready for implementation agents.

Include one-tap incident reporting, AI-assisted verification, geo-fenced alerts, critical issue handling, public accountability board, solution suggestions, verified helper requests, audit logs, and privacy/user protection.

For each backlog item include:
- Feature name
- User story
- Acceptance criteria
- Priority
- Dependencies
- Assigned agent
- Expected files/folders
- Security/privacy notes

Allowed folders:
- Docs/Product/
- Docs/Management/

Do not implement Flutter, .NET, or SQL code.
```

**Definition of Done:** Backlog is issue-sized, includes all MVP modules, and each story has acceptance criteria, dependencies, and privacy notes.

### Business Intelligence Agent

**Current task:** Draft non-blocking pilot and business strategy.

**Prompt to assign:**

```text
You are the Business Intelligence Agent for SurakshaNet AI.

Create Docs/Business/PILOT_STRATEGY.md with market problem, target customer segments, value proposition, government/NGO/RWA pilot strategy, revenue assumptions, competitor/alternative analysis, risks, and recommendation.

Keep the pilot strategy practical and do not require government integration before the MVP can be built.

Allowed folders:
- Docs/Product/
- Docs/Business/
```

**Definition of Done:** Pilot plan identifies target customers, pilot success metrics, revenue assumptions, risks, and a recommendation without blocking engineering work.

### System Architect Agent

**Current task:** Expand architecture and module boundaries.

**Prompt to assign:**

```text
You are the System Architect Agent for SurakshaNet AI.

Update Docs/Architecture/ARCHITECTURE_OVERVIEW.md, Docs/Architecture/API_MODULES.md, and Docs/Architecture/DATABASE_MODULES.md with the MVP technical plan.

Define:
- Report → Verify → Protect → Solve → Account system flow
- API module boundaries
- Public/private DTO boundaries
- Database module relationships
- Security boundaries for identity, location, evidence, helper requests, public board, corruption complaints, petitions, and audit logs
- Implementation sequence for DB, backend, Flutter, AI, QA, and security work

Allowed folders:
- Docs/Architecture/

Do not implement code.
```

**Definition of Done:** Engineering agents can begin schema/API/mobile foundation tasks without guessing module boundaries.

### Flutter Developer Agent

**Current task:** Wait for Phase 1 output, then create mobile foundation.

**Prompt to assign after Phase 1:**

```text
You are the Flutter Developer Agent for SurakshaNet AI.

Create the Flutter mobile app foundation under Mobile/ with navigation, theme, mock API service layer, and placeholder MVP screens:
Splash, Login/Register, Home, Report Incident, My Reports, Incident Details, Risk Map placeholder, Alert Details, I Need Help, Solution Suggestion, and Profile.

Use mock data only. Do not connect real backend APIs yet.

Allowed folders:
- Mobile/
```

**Definition of Done:** App shell runs, screens are navigable, mock service layer exists, and privacy-safe placeholder UI shows protected identity/approximate location patterns.

### Backend Developer Agent

**Current task:** Wait for architecture baseline, then create API foundation.

**Prompt to assign after architecture baseline:**

```text
You are the Backend Developer Agent for SurakshaNet AI.

Create the .NET 8 Web API foundation under Server/ with module folders, Swagger, a health endpoint, placeholder configuration, validation pattern, and audit service interface.

Prepare module folders for Auth, Users, Incidents, Verification, GeoFences, Alerts, PublicBoard, Solutions, HelperRequests, and AuditLogs.

Do not implement the full incident workflow in this task.

Allowed folders:
- Server/
```

**Definition of Done:** API builds/runs, Swagger works, health endpoint exists, no secrets are committed, and audit/RBAC placeholders are ready.

### Database Engineer Agent

**Current task:** Wait for architecture baseline, then create schema.

**Prompt to assign after architecture baseline:**

```text
You are the Database Engineer Agent for SurakshaNet AI.

Create SQL Server MVP schema scripts and safe seed data under DB/ and backup notes under Backup/.

Required tables:
Users, Roles, UserRoles, Incidents, IncidentMedia, IncidentVerificationLogs, Departments, GeoFences, Alerts, PublicIssues, Solutions, Petitions, PetitionSupporters, HelperRequests, AuditLogs.

Include primary keys, foreign keys, practical constraints, indexes, roles/departments seed data, and audit/privacy fields.

Allowed folders:
- DB/
- Backup/
```

**Definition of Done:** Scripts are ordered, documented, safe for local dev, include required tables, and contain no real data/secrets/backups.

### AI Verification Agent

**Current task:** Expand mock verification rules.

**Prompt to assign:**

```text
You are the AI Verification Agent for SurakshaNet AI.

Update Docs/AI/VERIFICATION_RULES.md with deterministic MVP scoring rules for severity, critical issue detection, department routing, geo-fence radius suggestion, native-language alert templates, solution suggestions, sensitive report flagging, audit requirement, and closure proof requirement.

Cover all 14 critical issues:
live wire in flooded water, electric pole collapse, transformer spark/fire, open manhole in flooded area, major road accident, fire/smoke, building collapse, person trapped, flooded underpass, unsafe bridge/road collapse risk, women safety immediate threat, child/senior citizen distress, gas leakage, chemical spill.

Allowed folders:
- Docs/AI/

Do not implement backend code in this task.
```

**Definition of Done:** Every critical issue maps to high severity, urgent verification, suggested geo-fence, department routing, warning text, audit log, and closure proof requirement.

### QA Tester Agent

**Current task:** Prepare MVP QA test matrix after product/AI/security drafts.

**Prompt to assign after product, AI, and security drafts:**

```text
You are the QA Tester Agent for SurakshaNet AI.

Expand Docs/QA/MVP_TEST_PLAN.md and add Tests/MVP_TEST_CASES.md with test cases for incident reporting, verification status, critical AI rules, geo-fence alerts, public board, solution suggestions, helper requests, auth/RBAC, audit logs, privacy, and security.

Each test must include:
- Test case ID
- Module
- Scenario
- Steps
- Expected result
- Priority
- Test type

Allowed folders:
- Docs/QA/
- Tests/
```

**Definition of Done:** P0 functional, negative, edge, privacy, security, and release-gate tests are documented and traceable to MVP features.

### Security and Privacy Agent

**Current task:** Create MVP security/privacy review checklist.

**Prompt to assign:**

```text
You are the Security and Privacy Agent for SurakshaNet AI.

Update Docs/Security/PRIVACY_AND_USER_PROTECTION.md and add Docs/Security/MVP_SECURITY_REVIEW.md with implementation-ready requirements.

Review anonymous reporting, protected identity, exact-location consent, helper safety, public board privacy, corruption complaint protection, petition verification, citizen solution safety, role-based access, evidence access logging, audit logging, and misuse prevention.

For each finding include:
- Risk
- Affected module
- Severity
- Recommended protection
- MVP implementation note
- Blocker status

Allowed folders:
- Docs/Security/
```

**Definition of Done:** Sensitive workflows have clear protections, blockers, and QA-testable requirements.

### Documentation Manager Agent

**Current task:** Wait for Phase 1 outputs, then refresh doc index.

**Prompt to assign after Phase 1 docs stabilize:**

```text
You are the Documentation Manager Agent for SurakshaNet AI.

Update README.md and Docs/README.md to link the finalized Phase 1 planning docs, agent assignment doc, product backlog, architecture docs, AI rules, security review, QA plan, and roadmap.

Also verify .github templates still match the agent workflow.

Allowed folders:
- Docs/
- README.md
- .github/
```

**Definition of Done:** A new agent can find the current plan, assigned tasks, issue templates, and next execution step from the README and docs index.

### Engineering Manager Agent

**Current task:** Start Phase 1 coordination.

**Prompt to assign now:**

```text
You are the Engineering Manager Agent for SurakshaNet AI.

Use Docs/Management/PROJECT_MANAGEMENT_PLAN.md and Docs/Management/AGENT_TASK_ASSIGNMENTS.md as the source of truth.

Create Docs/Management/PHASE_1_STATUS.md that includes:
1. Active Phase 1 task board
2. Owner agent for each task
3. Blocked/unblocked status
4. Parallel task opportunities
5. Phase 1 exit criteria
6. First three issue prompts to execute
7. Security/privacy blockers before implementation starts
8. Next recommended action after each Phase 1 task

Allowed folders:
- Docs/Management/
- Docs/Agents/

Do not implement Flutter, .NET, SQL, or AI service code.
```

**Definition of Done:** Phase 1 has a clear status board, blockers, owners, and the next three executable prompts.

---

## Immediate Assignment Order

1. Assign Engineering Manager Agent to create `Docs/Management/PHASE_1_STATUS.md`.
2. Assign Product Manager Agent to expand `Docs/Product/MVP_SCOPE.md` and `Docs/Product/MVP_BACKLOG.md`.
3. Assign System Architect Agent to update architecture docs after the Product Manager baseline is available.
4. Assign AI Verification Agent and Security and Privacy Agent to start their documentation drafts once product scope is stable.
5. Assign QA Tester Agent after product, AI, and security drafts exist.
6. Assign Business Intelligence Agent in parallel because pilot strategy is useful but not a coding blocker.
7. Assign Documentation Manager Agent after Phase 1 docs stabilize.
8. Hold Flutter, Backend, and Database implementation agents until architecture and acceptance criteria are approved.

## Phase 1 Exit Criteria

Phase 1 is complete when:

* Product backlog is implementation-ready.
* Architecture docs define API, DB, AI, and security boundaries.
* Critical issue verification rules are documented.
* Security/privacy review identifies sensitive workflow blockers.
* QA test matrix is ready for implementation phases.
* Engineering Manager status doc identifies next Phase 2 and Phase 3 tasks.
* Documentation Manager has updated links to Phase 1 outputs.

## Next Exact Prompt to Run

```text
You are the Engineering Manager Agent for SurakshaNet AI.

Use Docs/Management/PROJECT_MANAGEMENT_PLAN.md and Docs/Management/AGENT_TASK_ASSIGNMENTS.md as the source of truth.

Create Docs/Management/PHASE_1_STATUS.md that includes an active Phase 1 task board, owner agent for each task, blocked/unblocked status, parallel task opportunities, Phase 1 exit criteria, first three issue prompts to execute, security/privacy blockers before implementation starts, and next recommended action after each Phase 1 task.

Allowed folders:
- Docs/Management/
- Docs/Agents/

Do not implement Flutter, .NET, SQL, or AI service code.
Keep the work documentation-only, practical, and reviewable.
```
