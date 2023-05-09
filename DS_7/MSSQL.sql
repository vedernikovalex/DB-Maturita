use maturita;

GO
BACKUP DATABASE maturita
TO DISK = 'D:\School\MATURITA\DB-Maturita\DS_7\SQLCodeBackup.bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of maturita';
GO