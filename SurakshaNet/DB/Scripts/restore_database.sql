-- Run only in controlled restore drills or disaster recovery.
RESTORE DATABASE SurakshaNetDb
FROM DISK = '/var/opt/mssql/backups/SurakshaNetDb_full.bak'
WITH REPLACE, RECOVERY;
