# SurakshaNet AI

SurakshaNet AI is a verification-first civic safety and public accountability platform for reporting hazards, alerting nearby citizens, tracking public issues, and coordinating verified community help without exposing sensitive user identity or exact location unnecessarily.

## MVP Modules

1. One-tap incident reporting for flood, electric, pothole, road, unsafe-area, and other civic hazards.
2. AI-assisted verification support using MVP scoring rules and human review for sensitive workflows.
3. Geo-fenced safety alerts with approximate location sharing by default.
4. Public accountability board for verified public issues and department visibility.
5. Citizen solution hub for practical community suggestions.
6. Verified helper request flow with consent-based exact location sharing.
7. Audit logs for sensitive actions and moderation decisions.
8. Privacy and user protection safeguards across reporting, alerts, and public publishing.

## Folder Structure

```text
Mobile/                    Flutter mobile app placeholder
Web/                       Optional admin/web app placeholder
Server/                    .NET 8 Web API placeholder
DB/                        SQL Server scripts and seed data
Backup/                    Backup and restore strategy
Docs/Product/              MVP scope, backlog, and product planning
Docs/Business/             Market and pilot strategy docs
Docs/Architecture/         System, API, and database architecture docs
Docs/AI/                   AI verification rules and upgrade path
Docs/Security/             Privacy, safety, and misuse-prevention docs
Docs/QA/                   Test strategy and QA planning
Docs/Agents/               Role-specific AI agent instructions
Docs/Management/           Execution roadmap and workflow docs
Tests/                     Manual and automated test documents
.github/ISSUE_TEMPLATE/    Issue templates by agent/task type
```

## Tech Stack

### Mobile

* Flutter
* Dart
* Clean architecture
* API service layer
* Mock mode fallback for early MVP development

### Backend

* .NET 8 Web API
* Entity Framework Core
* SQL Server
* JWT authentication
* Role-based authorization
* Swagger/OpenAPI documentation

### AI Verification

* MVP mock/scoring service inside backend planning
* Future Python FastAPI service for advanced model-backed verification

### Database

* SQL Server
* Schema scripts
* Seed data
* Audit logs
* Backup and restore scripts

## How Agents Work

SurakshaNet AI is organized for role-based AI-agent work. Each future task should be scoped to one issue, one module, and the relevant allowed folders. Agent instructions live in `Docs/Agents/`, and repository-wide rules live in `AGENTS.md`.

Recommended workflow:

1. Product Manager creates user stories and acceptance criteria.
2. System Architect defines technical design and module boundaries.
3. Database Engineer creates schema and seed planning.
4. Backend Developer implements API endpoints.
5. Flutter Developer implements mobile screens.
6. AI Verification Agent adds scoring and recommendation logic.
7. QA Tester validates functional, edge, privacy, and security cases.
8. Security and Privacy Agent reviews sensitive workflows.
9. Documentation Manager updates setup and reference docs.
10. Engineering Manager reviews status, blockers, and next tasks.

## How to Run the Future App

No runnable Flutter, web, backend, or database implementation is included in this setup task. Future tasks should add module-specific setup commands in the relevant README files:

* `Mobile/README.md` for Flutter commands.
* `Server/README.md` for .NET API commands.
* `DB/README.md` for SQL Server scripts and seed data.
* `Tests/README.md` for test execution.

## Roadmap

1. Phase 0: Repository and agent setup.
2. Phase 1: Product backlog and architecture.
3. Phase 2: Database schema and seed data.
4. Phase 3: Backend MVP API.
5. Phase 4: Flutter MVP screens.
6. Phase 5: Mock AI verification logic.
7. Phase 6: Geo-fence and alert flow.
8. Phase 7: Public board and solution hub.
9. Phase 8: Verified helper MVP.
10. Phase 9: QA, security review, and documentation cleanup.

## Privacy-First Principles

* Use approximate location by default for alerts and helper matching.
* Require explicit consent before sharing exact location.
* Do not publicly expose sensitive user identity.
* Keep audit trails for moderation, verification, publishing, helper, and administrative actions.
* Treat AI verification as decision support, not final authority.
* Require human review before legal, corruption, petition, or sensitive public publishing workflows.
* Avoid silent deletion of public accountability records; use status changes and audit history.
