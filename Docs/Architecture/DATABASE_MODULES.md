# Database Modules

## MVP Database Planning

No schema is created in this setup task. Future database work should define SQL Server scripts under `DB/Scripts/` and safe seed data under `DB/SeedData/`.

## Planned Modules

| Module | Planned Tables | Notes |
| --- | --- | --- |
| Identity | Users, Roles, UserRoles | Store only required personal data; hash secrets outside SQL scripts. |
| Incidents | Incidents, IncidentMedia, IncidentVerificationLogs | Separate public-safe fields from sensitive evidence metadata. |
| Departments | Departments | Seed civic departments for routing suggestions. |
| Alerts | GeoFences, Alerts | Use radius/area definitions rather than exposing exact reporter location. |
| Public Board | PublicIssues | Preserve records with status history rather than silent deletes. |
| Solutions | Solutions | Store practical suggestion text and department guidance. |
| Petitions | Petitions, PetitionSupporters | Future module; requires human and legal review. |
| Helpers | HelperRequests | Track consent and approximate/exact location state separately. |
| Audit | AuditLogs | Capture sensitive actions, actor, timestamp, module, and reason. |

## Index Planning

Future scripts should consider indexes for incident status, category, approximate area, created date, verification status, alert radius lookup, and audit timestamps.
