# SurakshaNet AI Project Management Plan

Repository: `amanvishwakarma96/surakshanet-ai`  
Project: SurakshaNet AI  
Coordinator role: Project Manager Agent and AI Team Coordinator

## Core Product Principle

**Report → Verify → Protect → Solve → Account**

SurakshaNet AI must remain verification-first, privacy-first, user-protection-first, audit-first, MVP-focused, and scalable in phases. It must not behave like social media.

---

## A. MVP Summary

The MVP will prove the core civic safety loop: citizens can report hazards from a mobile app, the system can classify and route incidents through mock AI-assisted verification, reviewers can update status with audit logs, nearby citizens can receive geo-fenced safety alerts, verified issues can appear on a privacy-safe Public Accountability Board, and users can request verified helper support with approximate location first.

### Included in the First Version

* Citizen mobile app screens for reporting, tracking reports, viewing alerts, requesting help, viewing solution suggestions, and profile basics.
* .NET 8 Web API modules for authentication, user profile, incidents, verification status, geo-fences, alerts, public issues, solutions, helper requests, and audit logs.
* SQL Server schema and safe seed data for MVP entities.
* Mock AI/scoring logic for severity, critical issue detection, department routing, geo-fence radius, native-language alert draft, solution suggestions, and sensitive report flagging.
* Privacy and safety controls for protected identity, approximate location, exact-location consent, evidence restrictions, public board moderation, and audit logs.
* QA test plan covering functional, negative, security, privacy, and edge cases.

### Not Included in the First Version

* Full government system integrations or official dispatch integrations.
* Production AI model inference, computer vision, or automated legal conclusions.
* Social feeds, likes, comments, virality mechanics, or unmoderated public posts.
* Automated petition/legal-aid publication without verification and human review.
* Payment workflows, volunteer marketplace complexity, or advanced case management.
* Real-time emergency service replacement behavior.

---

## B. Feature Breakdown

| # | Feature name | Description | User story | Acceptance criteria | Priority | Assigned agent | Dependencies | Expected files/folders | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | MVP Product Backlog | Define MVP scope, stories, acceptance criteria, priorities, and release slices. | As the team, we need a clear backlog so every AI agent can work on small reviewable tasks. | Backlog lists all MVP modules; every item has priority, dependencies, acceptance criteria, and privacy notes; out-of-scope items are documented. | Must Have | Product Manager Agent | Existing setup docs | `Docs/Product/`, `Docs/Management/` | First executable planning task. |
| 2 | Architecture Overview | Define system boundaries, modules, API flow, DB flow, and security boundaries. | As developers, we need a shared architecture so backend, DB, AI, and mobile work align. | Architecture includes module diagram narrative, API boundaries, DB modules, auth boundaries, audit points, and integration order. | Must Have | System Architect Agent | Feature 1 | `Docs/Architecture/` | No implementation in Phase 1. |
| 3 | SQL Server MVP Schema | Create relational schema for identity, incidents, alerts, public board, helpers, petitions, and audit logs. | As backend developers, we need stable tables so API persistence can be implemented safely. | Tables exist for required entities; keys/FKs/indexes are included; sensitive data fields are separated; seed data is non-production; no secrets are committed. | Must Have | Database Engineer Agent | Features 1, 2 | `DB/`, `Backup/` | Petition tables included for future readiness but not full feature build. |
| 4 | Backend API Foundation | Create .NET 8 API foundation with auth placeholders, module structure, Swagger, validation, and audit service pattern. | As API developers, we need a working backend skeleton so feature endpoints can be added consistently. | API runs locally; Swagger opens; modules are organized; placeholder config uses no secrets; health endpoint exists; audit service interface exists. | Must Have | Backend Developer Agent | Features 2, 3 | `Server/` | Keep auth practical; do not overbuild identity. |
| 5 | Flutter App Foundation | Create Flutter app structure, navigation, theme, mock mode, and placeholder screens. | As mobile developers, we need the app shell before connecting real reporting flows. | App runs locally; required screens exist as placeholders; navigation works; mock API layer is isolated; no hardcoded secrets. | Must Have | Flutter Developer Agent | Features 1, 2 | `Mobile/` | Real API integration comes later. |
| 6 | AI Verification Rules | Define and later implement deterministic scoring rules for MVP verification assistance. | As a reviewer, I need AI support to identify critical issues quickly without letting AI make final decisions. | Critical issue list maps to high severity; scoring returns severity, confidence, department, radius, alert draft, sensitive flag, and recommended action; human review rules are explicit. | Must Have | AI Verification Agent | Features 1, 2 | `Docs/AI/`, later `Server/` | Must cover all 14 critical issue types. |
| 7 | Incident Reporting Flow | Implement mobile-to-backend incident creation, my reports, incident details, verification status, and audit logging. | As a citizen, I want to report a hazard and track status without exposing my identity publicly. | User can submit incident; backend validates/stores it; my reports shows submitted report; details show status; status changes create audit logs; public responses hide identity/exact location. | Must Have | Backend Developer Agent + Flutter Developer Agent + Database Engineer Agent | Features 3, 4, 5, 6 | `Server/`, `Mobile/`, `DB/` | Security Agent reviews public/private DTO separation. |
| 8 | Geo-Fence Alert Flow | Generate and list safety alerts from verified critical incidents. | As a nearby citizen, I want to receive relevant safety alerts without seeing the reporter's exact location. | Critical verified incident can create geo-fence; alert list filters active alerts; alert detail shows approximate area, warning, department, and safety instructions; audit log is created. | Must Have | Backend Developer Agent + Flutter Developer Agent + AI Verification Agent | Features 6, 7 | `Server/`, `Mobile/`, `Docs/AI/` | Native-language warning can be template-based in MVP. |
| 9 | Public Accountability Board | Publish verified privacy-safe public issues with status tracking. | As a citizen, I want to see verified civic issues and their progress without public shaming or identity leakage. | Only verified issues can be published; public issue hides reporter identity, exact coordinates, sensitive media, and unverified accused names; status changes are audited; no silent deletion. | Should Have | Backend Developer Agent + Security and Privacy Agent | Features 3, 4, 7 | `Server/`, `Docs/Security/` | No social comments/likes. |
| 10 | Solution Suggestion Hub | Provide safe, feasible civic solution suggestions and department routing. | As a citizen, I want suggested next steps for civic issues so I can act constructively. | Suggestions are tied to incident type/department; unsafe/legal claims are flagged for review; suggestions are not legal advice; mobile screen displays suggestions. | Should Have | AI Verification Agent + Flutter Developer Agent + Backend Developer Agent | Features 6, 7 | `Docs/AI/`, `Server/`, `Mobile/` | Templates first; model generation later. |
| 11 | Verified Helper MVP | Let users request help while protecting location and identity. | As a person stuck or unsafe, I want nearby verified helpers to know approximate area first and exact location only after I consent. | Helper request stores approximate area; exact location sharing requires consent event; helper interactions are auditable; request status changes are tracked. | Should Have | Backend Developer Agent + Flutter Developer Agent + Security and Privacy Agent | Features 3, 4, 5, 9 | `Server/`, `Mobile/`, `Docs/Security/` | Must not expose exact location by default. |
| 12 | QA and Security Release Gate | Verify MVP behavior, privacy, security, and edge cases before release. | As the team, we need confidence that MVP workflows do not endanger users. | P0 tests pass or have documented risk acceptance; security checklist completed; privacy-sensitive flows reviewed; release notes updated. | Must Have | QA Tester Agent + Security and Privacy Agent + Engineering Manager Agent | Features 1-11 | `Docs/QA/`, `Tests/`, `Docs/Security/`, `Docs/Management/` | Happens continuously and at Phase 9 gate. |
| 13 | Business Pilot Strategy | Define target pilots, buyers, value proposition, and revenue assumptions. | As founders, we need a practical pilot plan that does not block MVP engineering. | Pilot strategy identifies target customer, problem, value, outreach, success metrics, risks, and non-blocking government assumptions. | Could Have | Business Intelligence Agent | Feature 1 | `Docs/Product/`, `Docs/Business/` | Not required before coding foundation. |
| 14 | Documentation and Developer Guide | Keep setup, architecture, API, contribution, and changelog docs current. | As future agents, we need current docs so each task can be executed safely. | README links to key docs; setup instructions are updated as modules become runnable; PR and issue usage is documented. | Must Have | Documentation Manager Agent | All phases | `Docs/`, `README.md`, `.github/` | Update after each module milestone. |

---

## C. Agent Task Breakdown

### 1. Product Manager Agent

* **Objective:** Convert the product vision into a small, sequenced MVP backlog with stories, priorities, and acceptance criteria.
* **Tasks:**
  * Update `Docs/Product/MVP_SCOPE.md` with explicit included/excluded MVP scope.
  * Expand `Docs/Product/MVP_BACKLOG.md` into issue-sized backlog items.
  * Maintain release slices for Phase 1 through Phase 9 in `Docs/Management/`.
  * Add privacy notes and dependencies to each user story.
* **Deliverables:** MVP scope, prioritized backlog, release plan, acceptance criteria.
* **Output folder:** `Docs/Product/`, `Docs/Management/`
* **Dependencies:** Repository setup; input from Security Agent for sensitive flows.
* **Definition of Done:** Every MVP feature has story, acceptance criteria, priority, owner agent, dependency, expected folder, and privacy note.

### 2. Business Intelligence Agent

* **Objective:** Validate pilot positioning without blocking engineering delivery.
* **Tasks:**
  * Create market problem and target customer analysis.
  * Define government/NGO/resident-welfare pilot strategy.
  * Draft value proposition and revenue model assumptions.
  * Identify non-technical adoption risks.
* **Deliverables:** Pilot strategy, customer segments, revenue assumptions, risk/opportunity analysis.
* **Output folder:** `Docs/Product/`, `Docs/Business/`
* **Dependencies:** MVP scope from Product Manager Agent.
* **Definition of Done:** Pilot doc is practical, avoids requiring government integration for MVP coding, and lists measurable pilot success criteria.

### 3. System Architect Agent

* **Objective:** Define architecture and interfaces that let each engineering agent work independently.
* **Tasks:**
  * Expand architecture overview with service boundaries and flow.
  * Define API modules and DTO/public-private response boundaries.
  * Define database module relationships and audit points.
  * Identify security boundaries for identity, location, evidence, public publishing, and helper requests.
* **Deliverables:** Architecture overview, API module plan, database module plan, integration sequence.
* **Output folder:** `Docs/Architecture/`
* **Dependencies:** Product backlog and security rules.
* **Definition of Done:** Backend, DB, Flutter, AI, QA, and Security agents can start implementation tasks without guessing module boundaries.

### 4. Flutter Developer Agent

* **Objective:** Build the mobile MVP incrementally with mock mode first, then API integration.
* **Tasks:**
  * Create Flutter app foundation and navigation.
  * Add required MVP screens.
  * Create API service layer and mock fallback.
  * Implement incident reporting, my reports, alerts, helper request, solutions, and profile flows as separate PRs.
* **Deliverables:** Runnable Flutter app, screens, components, API/mock services, mobile README.
* **Output folder:** `Mobile/`
* **Dependencies:** Product stories, architecture, API contracts.
* **Definition of Done:** App runs locally, screen flow works, no secrets are hardcoded, privacy-sensitive views hide identity/exact location, and README includes run steps.

### 5. Backend Developer Agent

* **Objective:** Implement .NET 8 Web API modules with validation, RBAC, and audit patterns.
* **Tasks:**
  * Create API foundation, Swagger, health endpoint, config placeholders.
  * Implement auth/profile MVP.
  * Implement incident CRUD/list/details with public/private DTOs.
  * Implement verification status, geo-fences, alerts, public board, solutions, helper requests, and audit logs as separate tasks.
* **Deliverables:** Controllers, DTOs, services, repositories, validation, sample requests/responses, backend README.
* **Output folder:** `Server/`
* **Dependencies:** Architecture and DB schema; AI rules for verification outputs.
* **Definition of Done:** API runs locally, endpoints are documented in Swagger or markdown, validations exist, sensitive endpoints use roles, and sensitive actions create audit records.

### 6. Database Engineer Agent

* **Objective:** Provide safe SQL Server persistence structure for MVP workflows.
* **Tasks:**
  * Create schema scripts for required tables.
  * Add foreign keys, constraints, indexes, and status enums/checks where practical.
  * Add safe seed data for roles and departments.
  * Add backup/restore documentation and scripts without committing backup data.
* **Deliverables:** SQL schema scripts, seed data scripts, index notes, backup notes.
* **Output folder:** `DB/`, `Backup/`
* **Dependencies:** Architecture module plan.
* **Definition of Done:** Scripts are ordered, repeatable in a clean dev database, include required tables, preserve auditability, and do not include production data or secrets.

### 7. AI Verification Agent

* **Objective:** Create deterministic MVP verification support and a future AI upgrade path.
* **Tasks:**
  * Expand scoring rules for all 14 critical issues.
  * Define input/output JSON contract.
  * Define severity, critical flag, department, radius, native-language warning, solution suggestions, and sensitive flag logic.
  * Later implement server-side mock scoring service after backend foundation exists.
* **Deliverables:** Verification rule doc, example JSON, test scenarios, future AI service path, optional backend service logic.
* **Output folder:** `Docs/AI/`, `Server/` only for scoped service logic.
* **Dependencies:** Product stories and architecture; backend foundation before code implementation.
* **Definition of Done:** Every critical issue maps to high severity, urgent verification, suggested radius, department routing, alert text, audit expectation, and closure proof requirement.

### 8. QA Tester Agent

* **Objective:** Ensure every module has functional, negative, privacy, security, and edge coverage.
* **Tasks:**
  * Expand MVP test plan into module-level test cases.
  * Add incident, alert, public board, helper, AI, and audit test cases.
  * Create release gate checklist for Phase 9.
  * Document manual and automated test commands as they become available.
* **Deliverables:** Test plan, test cases, test matrix, release gate checklist.
* **Output folder:** `Tests/`, `Docs/QA/`
* **Dependencies:** Product backlog, architecture, module implementations.
* **Definition of Done:** P0 workflows have clear tests, negative/privacy/security cases exist, and failed or blocked tests are documented with owner and risk.

### 9. Security and Privacy Agent

* **Objective:** Prevent identity leakage, location leakage, evidence misuse, unsafe helper interactions, and false public accusations.
* **Tasks:**
  * Review core user protection rules against each module.
  * Define protected identity display rules.
  * Define approximate/exact location rules and consent events.
  * Define evidence access logging and public media redaction expectations.
  * Review public board, helper, corruption, petition, and solution workflows.
* **Deliverables:** Privacy/security requirements, threat notes, review checklist, mitigation recommendations.
* **Output folder:** `Docs/Security/`
* **Dependencies:** Product scope and architecture; review before sensitive implementation PRs merge.
* **Definition of Done:** Each sensitive module has risks, severity, recommended protection, MVP implementation note, and audit requirements.

### 10. Documentation Manager Agent

* **Objective:** Keep repository instructions, setup docs, API docs, and contribution docs usable by future agents.
* **Tasks:**
  * Update root README as modules become runnable.
  * Add developer setup guide when app/API/database exist.
  * Maintain changelog and contribution guidance.
  * Keep issue and PR templates aligned with workflow.
* **Deliverables:** README updates, setup docs, API docs, changelog, contribution guide.
* **Output folder:** `Docs/`, `README.md`, `.github/`
* **Dependencies:** Outputs from all agents.
* **Definition of Done:** A new agent can understand the repo, run implemented modules, find task rules, and open a compliant PR.

### 11. Engineering Manager Agent

* **Objective:** Coordinate sequencing, blockers, phase gates, and small PR boundaries.
* **Tasks:**
  * Maintain execution status and next-task queue.
  * Review agent outputs for scope, dependencies, and missing security/QA notes.
  * Keep Phase 1 through Phase 9 roadmap current.
  * Identify blockers and reassign tasks to correct agents.
* **Deliverables:** Execution status, blocker log, next actions, priority order, release readiness notes.
* **Output folder:** `Docs/Management/`, `Docs/Agents/`
* **Dependencies:** All agent outputs.
* **Definition of Done:** Active phase has clear tasks, owners, exit criteria, blockers, and next recommended issue prompts.

---

## D. GitHub Issue Plan

### Issue 1: Product MVP backlog

* **Labels:** `agent-product`, `mvp`, `priority-high`, `feature`, `docs`
* **Objective:** Expand MVP scope and backlog into issue-sized user stories.
* **Scope:** Update product and management planning docs only.
* **Acceptance criteria:**
  * `Docs/Product/MVP_SCOPE.md` clearly states included and excluded MVP scope.
  * `Docs/Product/MVP_BACKLOG.md` includes feature name, user story, acceptance criteria, priority, dependencies, developer notes, and privacy notes.
  * Backlog covers mobile, backend, DB, AI, security, QA, documentation, and management work.
  * Heavy government integration and production AI are explicitly out of scope for first coding phases.
* **Assigned agent:** Product Manager Agent
* **Files/folders allowed:** `Docs/Product/`, `Docs/Management/`
* **Dependencies:** Phase 0 repository setup.
* **Testing notes:** Documentation review; verify all MVP modules have backlog coverage.
* **Security/privacy notes:** Every sensitive workflow must mention identity, location, evidence, audit, and human-review expectations.

### Issue 2: Architecture overview

* **Labels:** `agent-architect`, `mvp`, `priority-high`, `docs`
* **Objective:** Define the MVP technical architecture, boundaries, and integration sequence.
* **Scope:** Architecture docs for app/backend/database/AI/security boundaries.
* **Acceptance criteria:**
  * Architecture overview defines Report → Verify → Protect → Solve → Account flow.
  * API modules list endpoint groups and public/private DTO expectations.
  * Database modules list entities, relationships, and audit/logging touchpoints.
  * Security boundaries are explicit for identity, exact location, evidence, helper, and public board flows.
* **Assigned agent:** System Architect Agent
* **Files/folders allowed:** `Docs/Architecture/`
* **Dependencies:** Product MVP backlog.
* **Testing notes:** Documentation review by Backend, Flutter, DB, AI, Security, and QA agents.
* **Security/privacy notes:** Must identify where RBAC, consent, public redaction, and audit logging are enforced.

### Issue 3: Database schema

* **Labels:** `agent-db`, `mvp`, `priority-high`, `feature`
* **Objective:** Create SQL Server MVP schema and safe seed data.
* **Scope:** SQL scripts and backup strategy only; no backend code.
* **Acceptance criteria:**
  * Required tables are created: Users, Roles, UserRoles, Incidents, IncidentMedia, IncidentVerificationLogs, Departments, GeoFences, Alerts, PublicIssues, Solutions, Petitions, PetitionSupporters, HelperRequests, AuditLogs.
  * Scripts include primary keys, foreign keys, basic constraints, and practical indexes.
  * Seed data includes roles and departments only; no real personal data.
  * Backup notes explain local dev backup/restore without committing backup files.
* **Assigned agent:** Database Engineer Agent
* **Files/folders allowed:** `DB/`, `Backup/`
* **Dependencies:** Architecture overview and database module plan.
* **Testing notes:** Script should be executable against a clean local SQL Server dev database; document command used.
* **Security/privacy notes:** Separate private and public-safe fields; include audit tables and consent-related helper fields.

### Issue 4: Backend API foundation

* **Labels:** `agent-backend`, `mvp`, `priority-high`, `feature`
* **Objective:** Create .NET 8 Web API foundation for future modules.
* **Scope:** Backend skeleton only; no full incident workflow yet.
* **Acceptance criteria:**
  * API project runs locally.
  * Swagger/OpenAPI is available in development.
  * Health endpoint exists.
  * Folder/module structure supports Auth, Users, Incidents, Verification, GeoFences, Alerts, PublicBoard, Solutions, HelperRequests, and AuditLogs.
  * Placeholder configuration uses no secrets or real connection strings.
  * Basic audit service interface or pattern is documented.
* **Assigned agent:** Backend Developer Agent
* **Files/folders allowed:** `Server/`
* **Dependencies:** Architecture overview; database schema can be pending if persistence is mocked.
* **Testing notes:** Run build/test command available for .NET project and document results.
* **Security/privacy notes:** Do not hardcode secrets; add placeholders for RBAC and sensitive data access boundaries.

### Issue 5: Flutter app foundation

* **Labels:** `agent-flutter`, `mvp`, `priority-high`, `feature`
* **Objective:** Create Flutter app shell with required MVP screens and mock mode.
* **Scope:** Mobile app foundation only; no full real API integration.
* **Acceptance criteria:**
  * Flutter project runs locally.
  * Required MVP screens exist: Splash, Login/Register, Home, Report Incident, My Reports, Incident Details, Risk Map placeholder, Alert Details, I Need Help, Solution Suggestion, Profile.
  * Navigation between screens works.
  * API service layer and mock fallback are separated from UI.
  * `Mobile/README.md` documents run commands.
* **Assigned agent:** Flutter Developer Agent
* **Files/folders allowed:** `Mobile/`
* **Dependencies:** Product MVP backlog and architecture overview.
* **Testing notes:** Run Flutter analyze/test or document environment limitation.
* **Security/privacy notes:** UI must display protected identity and approximate location patterns in placeholders where relevant.

### Issue 6: AI verification rules

* **Labels:** `agent-ai`, `mvp`, `priority-high`, `feature`, `docs`
* **Objective:** Expand deterministic MVP verification rules for critical incident prioritization.
* **Scope:** AI documentation only in this issue; no backend implementation.
* **Acceptance criteria:**
  * All 14 critical issue types map to high severity and urgent verification.
  * Output contract includes severity, confidence, critical flag, department suggestion, radius suggestion, native-language warning draft, solution suggestions, sensitive flag, audit requirement, and closure proof requirement.
  * Rules state AI cannot make legal/guilt/final public-publishing decisions.
  * Example JSON is included for at least flood/electric, unsafe area, road accident, and gas/chemical hazard cases.
* **Assigned agent:** AI Verification Agent
* **Files/folders allowed:** `Docs/AI/`
* **Dependencies:** Product MVP backlog and architecture overview.
* **Testing notes:** QA Agent can derive rule-based test cases from examples.
* **Security/privacy notes:** Sensitive categories must require human review and restricted public display.

### Issue 7: Incident reporting flow

* **Labels:** `agent-backend`, `agent-flutter`, `agent-db`, `mvp`, `priority-high`, `feature`, `security`
* **Objective:** Implement the first end-to-end incident reporting workflow.
* **Scope:** Incident create/list/details/status flow across DB, backend, and mobile; split into sub-PRs if needed.
* **Acceptance criteria:**
  * Citizen can create incident with type, description, approximate location, protected/anonymous mode flag, and optional media metadata.
  * Backend validates input and stores incident.
  * My Reports and Incident Details show the submitted incident and status.
  * Verification status changes create audit log records.
  * Public-safe response models do not expose reporter identity or exact location.
* **Assigned agent:** Backend Developer Agent, Flutter Developer Agent, Database Engineer Agent
* **Files/folders allowed:** `Server/`, `Mobile/`, `DB/`
* **Dependencies:** Database schema, backend API foundation, Flutter app foundation, AI verification rules.
* **Testing notes:** Add API request/response tests and mobile smoke checks; QA to add functional/negative/privacy cases.
* **Security/privacy notes:** Anonymous/protected mode must show `Identity Protected`; exact location must not be public; sensitive media must not be public by default.

### Issue 8: Geo-fence alert flow

* **Labels:** `agent-backend`, `agent-flutter`, `agent-ai`, `mvp`, `priority-high`, `feature`, `security`
* **Objective:** Implement verified critical incident to geo-fenced alert workflow.
* **Scope:** Alert generation/list/details from verified critical incidents.
* **Acceptance criteria:**
  * Critical verified incident can create suggested geo-fence alert.
  * Alert includes severity, approximate area, native-language warning draft, suggested department, and safety instruction.
  * Active alerts can be listed and viewed in mobile app.
  * Alert creation and status changes create audit logs.
  * Closure requires proof note or evidence reference.
* **Assigned agent:** Backend Developer Agent, Flutter Developer Agent, AI Verification Agent
* **Files/folders allowed:** `Server/`, `Mobile/`, `Docs/AI/`
* **Dependencies:** Incident reporting flow and AI verification rules.
* **Testing notes:** Test critical issue scenarios and radius suggestions; QA to add edge cases for expired/closed alerts.
* **Security/privacy notes:** Alerts must not reveal reporter identity or exact coordinates for sensitive reports.

### Issue 9: Security/privacy review

* **Labels:** `agent-security`, `mvp`, `priority-high`, `security`, `docs`
* **Objective:** Review MVP workflows against core user protection rules.
* **Scope:** Security/privacy documentation and module review checklist.
* **Acceptance criteria:**
  * Review covers anonymous reporting, protected identity, exact location consent, helper safety, evidence restrictions, public board privacy, corruption complaint privacy, RBAC, and audit logging.
  * Findings include risk, affected module, severity, recommended protection, and MVP implementation note.
  * Public board and helper workflows have pre-implementation safety gates.
  * Any blocker is documented with owner agent and required fix.
* **Assigned agent:** Security and Privacy Agent
* **Files/folders allowed:** `Docs/Security/`
* **Dependencies:** Product backlog, architecture overview, incident flow design.
* **Testing notes:** QA Agent converts review checklist into privacy/security test cases.
* **Security/privacy notes:** This issue is the security/privacy checkpoint for sensitive MVP modules.

### Issue 10: QA MVP test plan

* **Labels:** `agent-qa`, `mvp`, `priority-high`, `testing`, `docs`
* **Objective:** Expand MVP QA plan into actionable module-level test cases.
* **Scope:** QA docs and test planning only; no app/API implementation.
* **Acceptance criteria:**
  * Test cases cover incident reporting, verification, critical issue scoring, geo-fence alerts, public board, helper request, audit logs, auth/RBAC, and documentation checks.
  * Each test has ID, module, scenario, steps, expected result, priority, and test type.
  * Negative, edge, privacy, and security tests are included.
  * Phase 9 release gate checklist is defined.
* **Assigned agent:** QA Tester Agent
* **Files/folders allowed:** `Tests/`, `Docs/QA/`
* **Dependencies:** Product backlog, architecture overview, AI rules, security review.
* **Testing notes:** This issue creates testing assets; future implementation PRs must reference applicable test IDs.
* **Security/privacy notes:** Include explicit tests for identity protection, approximate location, consent, audit logs, and sensitive media restrictions.

---

## E. Phase-Wise Roadmap

| Phase | Goal | Agents involved | Tasks | Output | Exit criteria |
| --- | --- | --- | --- | --- | --- |
| Phase 0: Repository and agent setup | Prepare repo for role-based work. | Engineering Manager, Documentation Manager | Create folders, `AGENTS.md`, templates, starter docs. | Agent-ready repository. | Structure exists, docs/templates committed, PR opened. |
| Phase 1: Product backlog and architecture | Convert vision into buildable plan and architecture. | Product Manager, System Architect, Security, Engineering Manager | Expand backlog, architecture, API/DB boundaries, sensitive flow gates. | MVP backlog, architecture docs, issue queue. | First 10 issues ready; architecture approved for DB/API/mobile work. |
| Phase 2: Database schema and seed data | Create persistence foundation. | Database Engineer, Security, QA | SQL schema, seed roles/departments, indexes, backup notes. | DB scripts and seed data. | Clean dev DB can be created; sensitive fields/audit tables included. |
| Phase 3: Backend MVP API | Create API foundation and core modules. | Backend Developer, Database Engineer, Security, QA | API skeleton, auth/profile, incidents, verification state, audit pattern. | Runnable API with Swagger and core endpoints. | Build passes; core endpoints documented; audit pattern works. |
| Phase 4: Flutter MVP screens | Create mobile foundation and screen flow. | Flutter Developer, Product Manager, QA | Flutter shell, required screens, navigation, mock API. | Runnable mobile app shell. | App runs; screens navigable; mock mode works. |
| Phase 5: Mock AI verification logic | Add deterministic verification support. | AI Verification, Backend Developer, QA, Security | Scoring service/rules, JSON contract, critical issue mapping. | AI rules and optional backend mock service. | All critical issues produce expected recommendation outputs. |
| Phase 6: Geo-fence and alert flow | Connect verified critical incidents to alerts. | Backend Developer, Flutter Developer, AI Verification, QA, Security | Geo-fence APIs, active alert APIs, mobile alert screens. | Alert workflow. | Alerts hide identity/exact location and create audit logs. |
| Phase 7: Public board and solution hub | Publish verified issues and safe suggestions. | Backend Developer, Flutter Developer, AI Verification, Security, QA | Public issue APIs, solution APIs, UI screens. | Public board and solution flow. | Only verified/privacy-safe content is public; no silent delete. |
| Phase 8: Verified helper MVP | Add privacy-safe helper request flow. | Backend Developer, Flutter Developer, Security, QA | Helper request APIs, consent flow, mobile helper screen. | Verified helper MVP. | Approximate location first; exact location by consent; audit works. |
| Phase 9: QA, security review, and documentation cleanup | Prepare MVP release readiness. | QA, Security, Documentation, Engineering Manager, all implementers | Run tests, review findings, update docs, close blockers. | Release readiness report. | P0 tests pass or are risk-accepted; docs current; blockers triaged. |

---

## F. Dependency Map

* Phase 0 repository setup before all role-based tasks.
* Product MVP backlog before architecture, database schema, backend implementation, Flutter implementation, QA matrix, and security checklist.
* Architecture overview before database schema, backend API foundation, Flutter API service layer, and AI service implementation.
* Security/privacy review input before public board, helper request, corruption complaint, petition, and evidence workflows.
* Database schema before backend persistence endpoints.
* Backend API foundation before incident reporting API, geo-fence API, alert API, public board API, solution API, helper request API, and audit endpoints.
* Flutter app foundation before real mobile incident, alert, public board, solution, and helper screens.
* AI verification rules before critical incident workflow, native-language warning drafts, department routing, radius suggestions, and closure proof requirements.
* Incident reporting flow before geo-fence alert flow, public board publishing, solution suggestions, and helper context linking.
* Geo-fence alert flow before active alert mobile integration and alert closure proof workflow.
* Public board privacy review before publishing verified public issues.
* Helper safety review before exact-location consent workflow.
* QA test cases after each module design and before each module release.
* Documentation updates after every runnable module or major behavior change.
* Engineering Manager review after each phase to confirm exit criteria and next task order.

---

## G. Definition of Done

### Documentation Task

* Required file(s) are created or updated in the allowed folder.
* Content is specific, MVP-focused, and free of placeholder-only sections unless explicitly intended.
* Dependencies, assumptions, limitations, and next tasks are documented.
* Privacy/security considerations are included where applicable.
* Links or references to related docs are updated when necessary.

### Database Task

* SQL scripts are ordered and can run against a clean dev SQL Server database.
* Required tables, keys, foreign keys, constraints, and indexes are included.
* Seed data is safe and contains no real user data.
* Sensitive/public data separation is represented where needed.
* Audit log and consent-related persistence requirements are covered.
* Backup/restore notes are updated without committing backup files.

### Backend Task

* .NET project builds and runs locally.
* Endpoints, DTOs, services, repositories, and validation are scoped to the issue.
* Swagger or markdown API documentation is updated.
* Sensitive endpoints use appropriate RBAC or documented placeholders.
* Status changes and sensitive access create audit logs or clearly documented audit hooks.
* No secrets, production connection strings, or sensitive test data are committed.

### Flutter Task

* Flutter app runs locally or environment limitation is documented.
* UI work is limited to issue scope and required screens/components.
* Navigation and state behavior are testable.
* API service layer is separated from UI and supports mock fallback where required.
* Sensitive public displays hide reporter identity and exact location.
* README/run instructions are updated when setup changes.

### AI Verification Task

* Inputs, outputs, scoring rules, and examples are documented.
* Critical issue logic covers all required high-priority hazards.
* Rules return severity, critical flag, department, radius, alert draft, solution suggestion, sensitive flag, audit requirement, and closure proof requirement where applicable.
* AI is explicitly decision support only.
* Sensitive/legal/corruption workflows require human review.
* QA scenarios can be derived directly from the rule examples.

### Security Task

* Risks are documented with affected module, severity, mitigation, and MVP implementation note.
* Anonymous/protected identity, approximate/exact location, helper safety, evidence restrictions, public board privacy, corruption complaint privacy, RBAC, and audit logging are covered.
* Any blocker has an owner and recommended fix.
* Security recommendations remain practical for MVP and do not require production-only complexity.

### QA Task

* Test cases include ID, module, scenario, steps, expected result, priority, and test type.
* Functional, negative, edge, privacy, security, and regression cases are included for P0 flows.
* Tests map back to features or GitHub issues.
* Release gate checklist identifies P0 pass/fail requirements and risk acceptance rules.
* Actual commands/results are documented once runnable modules exist.

---

## H. Risk Register

| Risk | Impact | Probability | Mitigation | Owner agent |
| --- | --- | --- | --- | --- |
| Scope creep | MVP becomes too large, slow, and unreviewable. | High | Maintain phase gates; every issue must be small, scoped, and tied to MVP acceptance criteria. | Engineering Manager Agent |
| Government dependency | Delivery stalls waiting for official integrations or approvals. | Medium | Build self-contained MVP with pilot-ready exports/docs; defer heavy integrations. | Business Intelligence Agent |
| Privacy breach | User identity, exact location, or evidence leaks publicly. | High | Use protected identity, approximate location defaults, RBAC, redaction, and audit logs. | Security and Privacy Agent |
| Fake reports | Platform trust decreases and resources are misdirected. | High | Use duplicate detection, confidence scoring, reviewer status, and audit trail. | AI Verification Agent |
| False public accusation | Legal and safety harm from unverified allegations. | Medium | Human review before publication; hide accused names in corruption/legal workflows until verified. | Security and Privacy Agent |
| Unsafe helper interaction | Requester or helper may be endangered. | Medium | Verified helpers only, approximate location first, exact location consent, auditable interactions. | Security and Privacy Agent |
| Over-reliance on AI | AI makes incorrect severity, legal, or publication decisions. | Medium | AI remains decision support; legal/corruption/sensitive/public publishing requires human verification. | AI Verification Agent |
| Poor verification workflow | Critical incidents are delayed or non-critical issues are escalated incorrectly. | Medium | Define statuses, reviewer queues, critical issue rules, and closure proof requirements. | Product Manager Agent |
| Weak audit logging | Sensitive actions cannot be traced, weakening accountability. | High | Audit status changes, public board changes, evidence access, helper consent, and admin actions. | Backend Developer Agent |
| Incomplete documentation | Future agents misunderstand setup or duplicate work. | Medium | Documentation Manager updates README/setup/API/changelog after each module milestone. | Documentation Manager Agent |

---

## I. First 10 GitHub Issues

The following issues should be created in this exact order.

### 1. Product MVP backlog

```markdown
## Objective
Expand the SurakshaNet AI MVP scope and backlog into actionable, issue-sized user stories for all agents.

## Labels
agent-product, mvp, priority-high, feature, docs

## Assigned agent
Product Manager Agent

## Scope
Update only product and management planning documents.

## Files/folders allowed
- Docs/Product/
- Docs/Management/

## Acceptance criteria
- [ ] Docs/Product/MVP_SCOPE.md clearly defines included MVP scope and out-of-scope items.
- [ ] Docs/Product/MVP_BACKLOG.md includes all MVP features with user story, acceptance criteria, priority, dependencies, developer notes, and privacy notes.
- [ ] Backlog covers mobile, backend, database, AI verification, security/privacy, QA, documentation, and management.
- [ ] Critical issue prioritization requirements are included.
- [ ] Heavy government integrations, production AI, social-media behavior, automated legal decisions, and payment workflows are excluded from first coding phases.

## Dependencies
- Phase 0 repository and agent setup complete.

## Testing notes
- Documentation review only.
- Verify every MVP module has at least one backlog item and clear acceptance criteria.

## Security/privacy notes
- Every sensitive user story must mention identity protection, approximate location, exact-location consent, evidence handling, audit logging, or human review as applicable.
```

### 2. Architecture overview

```markdown
## Objective
Define the MVP architecture for the mobile app, backend API, SQL Server database, AI verification logic, and privacy/security boundaries.

## Labels
agent-architect, mvp, priority-high, docs

## Assigned agent
System Architect Agent

## Scope
Update architecture documents only.

## Files/folders allowed
- Docs/Architecture/

## Acceptance criteria
- [ ] Docs/Architecture/ARCHITECTURE_OVERVIEW.md describes Report → Verify → Protect → Solve → Account flow.
- [ ] Docs/Architecture/API_MODULES.md defines endpoint groups, DTO boundaries, and audit-sensitive endpoints.
- [ ] Docs/Architecture/DATABASE_MODULES.md defines entity groups, relationships, and sensitive/public field boundaries.
- [ ] Architecture identifies where RBAC, consent, redaction, and audit logging are enforced.
- [ ] Architecture supports incremental implementation without building the full app in one task.

## Dependencies
- Issue 1: Product MVP backlog.

## Testing notes
- Documentation review by Backend, Flutter, DB, AI, Security, QA, and Engineering Manager agents.

## Security/privacy notes
- Must explicitly protect reporter identity, exact location, helper requests, public board publishing, corruption complaints, and evidence access.
```

### 3. Database schema

```markdown
## Objective
Create the SQL Server MVP schema, seed data, indexes, and backup notes needed for the backend API.

## Labels
agent-db, mvp, priority-high, feature

## Assigned agent
Database Engineer Agent

## Scope
Create database scripts and backup documentation only.

## Files/folders allowed
- DB/
- Backup/

## Acceptance criteria
- [ ] Schema includes Users, Roles, UserRoles, Incidents, IncidentMedia, IncidentVerificationLogs, Departments, GeoFences, Alerts, PublicIssues, Solutions, Petitions, PetitionSupporters, HelperRequests, and AuditLogs.
- [ ] Primary keys, foreign keys, practical constraints, and indexes are included.
- [ ] Seed data includes safe roles and departments only.
- [ ] Scripts are ordered and documented for a clean local SQL Server dev database.
- [ ] Backup/restore notes are updated without committing backup files.

## Dependencies
- Issue 2: Architecture overview.

## Testing notes
- Run scripts against a clean local SQL Server dev database if available.
- Document exact command used or environment limitation.

## Security/privacy notes
- Separate public-safe data from sensitive identity, exact location, media, consent, and audit data.
- No real user data, secrets, production backups, or connection strings may be committed.
```

### 4. Backend API foundation

```markdown
## Objective
Create the .NET 8 Web API foundation with module structure, Swagger, health check, configuration placeholders, and audit service pattern.

## Labels
agent-backend, mvp, priority-high, feature

## Assigned agent
Backend Developer Agent

## Scope
Backend foundation only; do not implement full incident workflow in this issue.

## Files/folders allowed
- Server/

## Acceptance criteria
- [ ] .NET 8 Web API project exists and builds.
- [ ] Swagger/OpenAPI is available in development.
- [ ] Health endpoint exists.
- [ ] Folder structure supports Auth, Users, Incidents, Verification, GeoFences, Alerts, PublicBoard, Solutions, HelperRequests, and AuditLogs.
- [ ] Placeholder configuration is present and contains no real secrets or production connection strings.
- [ ] Audit service interface or pattern is created/documented.
- [ ] Server/README.md includes run/build commands.

## Dependencies
- Issue 2: Architecture overview.
- Issue 3: Database schema can be pending if persistence is mocked or config-only.

## Testing notes
- Run dotnet build/test command and document output.

## Security/privacy notes
- Do not hardcode secrets.
- Include placeholders for RBAC, audit logging, and public/private response separation.
```

### 5. Flutter app foundation

```markdown
## Objective
Create the Flutter mobile app foundation with navigation, theme, required MVP placeholder screens, and mock API service layer.

## Labels
agent-flutter, mvp, priority-high, feature

## Assigned agent
Flutter Developer Agent

## Scope
Mobile app shell only; do not implement full real API integration in this issue.

## Files/folders allowed
- Mobile/

## Acceptance criteria
- [ ] Flutter project exists and runs locally.
- [ ] Required MVP screens exist: Splash, Login/Register, Home, Report Incident, My Reports, Incident Details, Risk Map placeholder, Alert Details, I Need Help, Solution Suggestion, Profile.
- [ ] Navigation between screens works.
- [ ] API service layer is separated from UI.
- [ ] Mock mode fallback exists for early development.
- [ ] Mobile/README.md includes run/analyze/test commands.

## Dependencies
- Issue 1: Product MVP backlog.
- Issue 2: Architecture overview.

## Testing notes
- Run flutter analyze and flutter test if environment supports Flutter.
- Document any environment limitation.

## Security/privacy notes
- Placeholder UI for reports, alerts, helpers, and public details must demonstrate protected identity and approximate location display patterns.
```

### 6. AI verification rules

```markdown
## Objective
Expand MVP mock AI verification rules for severity scoring, critical issue detection, routing, radius suggestion, native-language warning, solution suggestions, sensitive flagging, and closure proof.

## Labels
agent-ai, mvp, priority-high, feature, docs

## Assigned agent
AI Verification Agent

## Scope
AI documentation only; backend implementation comes later.

## Files/folders allowed
- Docs/AI/

## Acceptance criteria
- [ ] All 14 critical issue types are listed and map to high severity.
- [ ] Each critical issue triggers urgent verification, suggested geo-fence, native-language warning draft, department routing, audit requirement, and closure proof requirement.
- [ ] Input fields and output JSON contract are documented.
- [ ] Example JSON is included for flood/electric, road accident, unsafe area, and gas/chemical hazards.
- [ ] Rules state AI cannot make final legal, guilt, corruption, petition, or sensitive public-publishing decisions.

## Dependencies
- Issue 1: Product MVP backlog.
- Issue 2: Architecture overview.

## Testing notes
- QA Agent should convert examples into test cases.

## Security/privacy notes
- Sensitive reports must require human review, restricted public display, and protected identity defaults.
```

### 7. Incident reporting flow

```markdown
## Objective
Implement the first end-to-end incident reporting flow across database, backend, and mobile in small sub-PRs if needed.

## Labels
agent-backend, agent-flutter, agent-db, mvp, priority-high, feature, security

## Assigned agent
Backend Developer Agent, Flutter Developer Agent, Database Engineer Agent

## Scope
Incident creation, my reports, incident details, verification status, and audit logging.

## Files/folders allowed
- DB/
- Server/
- Mobile/

## Acceptance criteria
- [ ] Citizen can create an incident with type, description, approximate location, protected/anonymous mode flag, and optional media metadata.
- [ ] Backend validates and stores incident records.
- [ ] My Reports lists the user's incidents.
- [ ] Incident Details shows status and privacy-safe details.
- [ ] Verification status updates create audit log records.
- [ ] Public-safe responses hide reporter identity and exact location.
- [ ] Module README/API notes include sample request/response.

## Dependencies
- Issue 3: Database schema.
- Issue 4: Backend API foundation.
- Issue 5: Flutter app foundation.
- Issue 6: AI verification rules.

## Testing notes
- Add API tests or documented request checks for create/list/details/status.
- Add mobile smoke test for submit and view flow.
- QA Agent should add negative tests for missing fields and privacy leaks.

## Security/privacy notes
- If anonymous/protected mode is enabled, public display must show “Identity Protected”.
- Exact location must not be exposed publicly.
- Sensitive media must not be public by default.
- Every status change must create an audit log.
```

### 8. Geo-fence alert flow

```markdown
## Objective
Implement geo-fenced safety alert generation and mobile alert viewing for verified critical incidents.

## Labels
agent-backend, agent-flutter, agent-ai, mvp, priority-high, feature, security

## Assigned agent
Backend Developer Agent, Flutter Developer Agent, AI Verification Agent

## Scope
Geo-fence creation/list, active alert list, alert details, AI radius/warning support, and audit logging.

## Files/folders allowed
- Server/
- Mobile/
- Docs/AI/

## Acceptance criteria
- [ ] Critical verified incident can generate a suggested geo-fence alert.
- [ ] Alert includes severity, approximate area, suggested radius, department routing, and warning text.
- [ ] Active alerts can be listed and viewed in the mobile app.
- [ ] Alert status changes create audit logs.
- [ ] Alert closure requires closure proof note or evidence reference.
- [ ] Alerts do not expose reporter identity or exact coordinates.

## Dependencies
- Issue 6: AI verification rules.
- Issue 7: Incident reporting flow.

## Testing notes
- Test all critical issue categories that should trigger high severity.
- Test alert expiration/closure behavior.
- Test approximate location display.

## Security/privacy notes
- Native-language warning must be safety-focused and must not include private reporter details.
- Public alert payload must use approximate area only for sensitive cases.
```

### 9. Security/privacy review

```markdown
## Objective
Review all MVP workflows against SurakshaNet AI user protection rules and produce implementation-ready security/privacy requirements.

## Labels
agent-security, mvp, priority-high, security, docs

## Assigned agent
Security and Privacy Agent

## Scope
Security/privacy docs and review checklist only.

## Files/folders allowed
- Docs/Security/

## Acceptance criteria
- [ ] Review covers anonymous reporting, protected identity, exact-location consent, helper safety, role-based access, evidence access logging, public board privacy, corruption complaint protection, misuse prevention, and audit logging.
- [ ] Each finding includes risk, affected module, severity, recommended protection, and MVP implementation note.
- [ ] Public board publishing requirements prevent unverified accusations and silent deletion.
- [ ] Helper request requirements enforce approximate location first and consent for exact location.
- [ ] Blockers are documented with owner agent and recommended fix.

## Dependencies
- Issue 1: Product MVP backlog.
- Issue 2: Architecture overview.
- Issue 7: Incident reporting flow design or implementation notes.

## Testing notes
- QA Agent should convert review items into security/privacy test cases.

## Security/privacy notes
- This issue is the formal checkpoint for sensitive workflows before public board and helper MVP implementation.
```

### 10. QA MVP test plan

```markdown
## Objective
Expand the MVP QA plan into actionable test cases and release gate criteria.

## Labels
agent-qa, mvp, priority-high, testing, docs

## Assigned agent
QA Tester Agent

## Scope
QA docs and test planning only.

## Files/folders allowed
- Docs/QA/
- Tests/

## Acceptance criteria
- [ ] Test cases cover incident reporting, verification status, AI critical issue rules, geo-fence alerts, public board, solution suggestions, helper requests, audit logs, auth/RBAC, and documentation checks.
- [ ] Each test includes Test Case ID, module, scenario, steps, expected result, priority, and test type.
- [ ] Functional, negative, security, privacy, edge, and regression tests are included.
- [ ] Phase 9 release gate checklist defines P0 pass/fail requirements and risk acceptance rules.
- [ ] Tests reference related MVP features or GitHub issues.

## Dependencies
- Issue 1: Product MVP backlog.
- Issue 2: Architecture overview.
- Issue 6: AI verification rules.
- Issue 9: Security/privacy review.

## Testing notes
- This is a planning issue; future implementation PRs must run or reference applicable test IDs.

## Security/privacy notes
- Include explicit tests for protected identity, approximate location, exact-location consent, sensitive media access, public board moderation, helper safety, RBAC, and audit logs.
```

---

## Next Recommended Prompt for Engineering Manager Agent

```text
You are the Engineering Manager Agent for SurakshaNet AI.

Start Phase 1: Product backlog and architecture.

Use Docs/Management/PROJECT_MANAGEMENT_PLAN.md as the source of truth. Create a Phase 1 execution status document under Docs/Management/PHASE_1_STATUS.md that:

1. Lists the first 10 GitHub issues in order.
2. Identifies which issues can run in parallel and which are blocked.
3. Confirms the owner agent for each issue.
4. Defines Phase 1 exit criteria.
5. Recommends the first 3 issue prompts to execute next.
6. Flags any privacy/security risks that must be reviewed before coding starts.

Allowed folders:
- Docs/Management/
- Docs/Agents/

Do not implement Flutter, .NET, or SQL code in this task.
Keep the output practical, small, and reviewable.
```
