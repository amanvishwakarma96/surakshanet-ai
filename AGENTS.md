# AGENTS.md

## Project Overview

SurakshaNet AI is a verification-first civic safety and public accountability platform.

The MVP focuses on:

1. One-tap incident reporting
2. AI-assisted incident verification
3. Geo-fenced safety alerts
4. Flood/electric hazard reporting
5. Pothole/road hazard reporting
6. Unsafe area reporting
7. Public accountability board
8. Solution suggestions
9. Verified helper requests
10. Audit logs
11. Privacy and user protection

## Repository Structure

* Mobile/ = Flutter mobile app
* Web/ = Admin/web app placeholder
* Server/ = .NET 8 Web API backend
* DB/ = SQL Server schema, seed data, scripts
* Backup/ = Backup and restore strategy
* Docs/ = Product, architecture, AI, QA, security, and agent docs
* Tests/ = Manual and automated test documents

## General Rules

1. Keep changes small and reviewable.
2. Do not build the whole project in one task.
3. Work only on the scope described in the issue.
4. Update documentation when adding or changing major behavior.
5. Do not hardcode secrets, tokens, passwords, or connection strings.
6. Use placeholder configuration files where needed.
7. Do not expose sensitive user identity publicly.
8. Do not expose exact user location for sensitive cases.
9. Every sensitive action must have an audit trail.
10. AI verification is decision support only. Human verification is required for legal, corruption, petition, and sensitive public publishing workflows.
11. Public accountability records must not be silently deleted.
12. Verified helper requests must use approximate location first.
13. Exact location sharing must require user consent.
14. Keep MVP practical and avoid overengineering.

## Technology Stack

Mobile:

* Flutter
* Dart
* Clean architecture
* API service layer
* Mock mode fallback

Backend:

* .NET 8 Web API
* Entity Framework Core
* SQL Server
* JWT authentication
* Role-based authorization
* Swagger

AI Verification:

* MVP mock/scoring service
* Future Python FastAPI service

Database:

* SQL Server
* Schema scripts
* Seed data
* Audit logs

## Branch Naming

Use branch names like:

agent/product-mvp-backlog
agent/architecture-overview
agent/db-schema
agent/backend-mvp-api
agent/flutter-mvp-screens
agent/ai-verification-rules
agent/qa-test-cases
agent/security-privacy-review
agent/docs-readme

## Pull Request Rules

Every PR must include:

1. Summary of changes
2. Files changed
3. How to test
4. Screenshots if UI changed
5. Security/privacy notes if applicable
6. Known limitations
7. Next recommended task
