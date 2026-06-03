# Execution Roadmap

## Phase 0: Repository and agent setup

Create repository structure, agent instructions, issue templates, PR template, and starter documentation.

## Phase 1: Product backlog and architecture

Finalize MVP scope, user stories, acceptance criteria, API module boundaries, database module plan, and privacy-sensitive flows.

## Phase 2: Database schema and seed data

Create SQL Server schema, seed civic departments, define indexes, and document backup/restore scripts.

## Phase 3: Backend MVP API

Implement .NET 8 API modules for auth, users, incidents, verification state, alerts, public board, solutions, helper requests, and audit logs.

## Phase 4: Flutter MVP screens

Implement core mobile screens with API service layer, validation, and mock mode fallback.

## Phase 5: Mock AI verification logic

Add deterministic scoring for severity, critical issue detection, department routing, radius suggestion, sensitive flagging, and alert text support.

## Phase 6: Geo-fence and alert flow

Connect verified incident flow to radius-based nearby alerts and privacy-safe alert details.

## Phase 7: Public board and solution hub

Publish verified public issues with status tracking and practical solution suggestions.

## Phase 8: Verified helper MVP

Implement approximate-location helper requests, consent-based exact location sharing, and helper safety review.

## Phase 9: QA, security review, and documentation cleanup

Run MVP test plan, security/privacy review, documentation updates, and release-readiness checks.
