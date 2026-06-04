# Backup and Restore Strategy

## MVP database baseline

The current database baseline is defined by:

1. `DB/Scripts/001_CreateMvpSchema.sql`
2. `DB/SeedData/001_SeedMvpData.sql`

These scripts are intended for local and non-production MVP environments. The schema script drops known MVP tables before recreating them, so it must not be run against production data.

## Non-production backup checklist

Before replacing or resetting an MVP database:

1. Take a full SQL Server backup of the target database.
2. Confirm the backup file is stored outside the repository.
3. Record the source database name, backup timestamp, and operator in an operational audit note or ticket.
4. Run restore validation in a separate environment before destructive schema refreshes.

Example placeholder command:

```sql
BACKUP DATABASE [SurakshaNet]
TO DISK = N'/secure-backups/SurakshaNet_YYYYMMDDHHMMSS.bak'
WITH COPY_ONLY, COMPRESSION, CHECKSUM;
```

## Privacy notes

* Backups can contain sensitive reporter, evidence, location, helper, petition, and audit data.
* Backup files must not be committed to this repository.
* Access to backup and restore operations should be restricted and audited.
* Exact-location and sensitive evidence recovery should follow the same consent and access-logging rules as the live system.
