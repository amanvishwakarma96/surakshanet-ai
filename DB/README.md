# DB

SQL Server database planning area for schema scripts, seed data, indexes, and migration support.

## MVP schema scripts

| Path | Purpose |
| --- | --- |
| `Scripts/001_CreateMvpSchema.sql` | Creates the MVP SQL Server schema for identity, incidents, verification logs, departments, geo-fences, alerts, public issues, solutions, petitions, helper requests, and audit logs. |
| `SeedData/001_SeedMvpData.sql` | Loads safe non-production roles, departments, placeholder users, sample incidents, verification logs, alerts, public-board data, helper requests, solutions, and audit events. |

## Run order

1. Create or select a non-production SQL Server database named `SurakshaNet` or another local test database.
2. Run `DB/Scripts/001_CreateMvpSchema.sql`.
3. Run `DB/SeedData/001_SeedMvpData.sql`.

Example with `sqlcmd`:

```bash
sqlcmd -S YOUR_SQL_SERVER -d SurakshaNet -i DB/Scripts/001_CreateMvpSchema.sql
sqlcmd -S YOUR_SQL_SERVER -d SurakshaNet -i DB/SeedData/001_SeedMvpData.sql
```

## Privacy and safety notes

* Seed data is placeholder-only and does not contain real residents, real evidence, credentials, secrets, or exact sensitive locations.
* Exact incident and helper coordinates are nullable and constrained to require explicit consent metadata before they can be stored.
* Public-board records store public-safe summaries and approximate location labels, not reporter identity or exact reporter coordinates.
* Sensitive workflows such as human verification, public publishing, exact-location sharing, petition review, and moderation decisions should be represented in `AuditLogs`.
* Public accountability records should be archived or status-changed rather than silently deleted.

## Known limitations

* These scripts are a practical MVP baseline and are not Entity Framework migrations yet.
* Geographic matching uses latitude/longitude columns plus indexes; advanced geospatial types can be introduced later if needed.
* Authentication credentials are intentionally not seeded. Password hashes and token secrets must be created by secure application workflows.
