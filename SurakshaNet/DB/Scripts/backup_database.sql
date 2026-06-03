-- Replace paths according to your SQL Server host. Encrypt backup media in production.
BACKUP DATABASE SurakshaNetDb
TO DISK = '/var/opt/mssql/backups/SurakshaNetDb_full.bak'
WITH FORMAT, INIT, COMPRESSION, NAME = 'SurakshaNetDb Full Backup';
