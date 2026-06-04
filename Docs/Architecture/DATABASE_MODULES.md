# Database Modules

## MVP Database Baseline

The MVP SQL Server baseline is implemented under `DB/`:

| Script | Responsibility |
| --- | --- |
| `DB/Scripts/001_CreateMvpSchema.sql` | Drops and recreates the MVP schema in dependency order for local/non-production setup. |
| `DB/SeedData/001_SeedMvpData.sql` | Inserts safe placeholder seed data for roles, departments, users, sample workflows, and audit events. |

## Implemented Modules

| Module | Tables | Notes |
| --- | --- | --- |
| Identity | `Users`, `Roles`, `UserRoles` | Stores minimal identity fields, supports anonymous/protected reporters, and leaves credential provisioning outside seed SQL. |
| Departments | `Departments` | Routes incidents and solutions to civic teams such as municipal works, electricity safety, disaster response, traffic police, public safety, and anti-corruption review. |
| Incidents | `Incidents`, `IncidentMedia`, `IncidentVerificationLogs` | Separates approximate location from nullable exact coordinates; exact coordinates require consent metadata. Verification is decision support and can require human review. |
| Alerts | `GeoFences`, `Alerts` | Uses center/radius alert areas and published-state constraints rather than exposing exact reporter location. |
| Public Board | `PublicIssues` | Public records use public-safe summaries and approximate location labels. Records should move through visibility/status changes instead of silent deletion. |
| Solutions | `Solutions` | Stores practical suggested actions and department routing; MVP suggestions are advisory only. |
| Petitions | `Petitions`, `PetitionSupporters` | Included as a future-sensitive module with legal-review flags and anonymous-public supporter support. |
| Helpers | `HelperRequests` | Defaults to approximate location matching; exact coordinates require consent, timestamp, and a matched helper. |
| Audit | `AuditLogs` | Captures actor, action, module, entity, reason, timestamp, masked IP, and optional JSON metadata for sensitive actions. |

## Relationships

* `Incidents` can reference `Users` as reporters and `Departments` for routing.
* `IncidentMedia`, `IncidentVerificationLogs`, `Alerts`, `PublicIssues`, `Solutions`, and `HelperRequests` can reference incidents.
* `PublicIssues` can reference departments and can be the source for `Petitions`.
* `PetitionSupporters` stores a supporter hash per petition to avoid public exposure of raw identity.
* `AuditLogs` can reference an actor user and any affected entity by name/id.

## Constraints and Privacy Controls

* Incident category, severity, status, verification status, media type, alert status, public visibility status, solution status, petition status, helper request status, and helper need type use `CHECK` constraints.
* Approximate and exact coordinates are latitude/longitude bounded.
* Incident exact coordinates require `ExactLocationConsent = 1` and `ExactLocationConsentAt`.
* Helper exact coordinates require `ExactLocationSharedWithConsent = 1`, `ExactLocationConsentAt`, and `MatchedHelperUserId`.
* Alert and public issue publishing require a publisher and publish timestamp.
* `AuditLogs.MetadataJson` is constrained with `ISJSON` when present.

## Index Planning

The schema includes practical MVP indexes for:

* incident status and created date,
* incident category/status,
* verification status,
* approximate location columns,
* incident media and verification lookup,
* active geo-fences by hazard type,
* alert publication status,
* public issue visibility/resolution,
* helper request status/need type and approximate location,
* audit logs by module/timestamp and entity.

## Run Order

1. Run `DB/Scripts/001_CreateMvpSchema.sql` against a local/non-production SQL Server database.
2. Run `DB/SeedData/001_SeedMvpData.sql` against the same database.

Do not run these scripts against production data because the schema script intentionally drops MVP tables before recreating them.
