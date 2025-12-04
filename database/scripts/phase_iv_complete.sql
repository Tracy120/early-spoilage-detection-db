-- =========================================================
-- PHASE IV: Database Creation
-- Project: EarlySpoilageDetectionSystem
-- Author: Tracy
-- PDB: A_27105_Tracy_EarlySpoilageDetectionSystem_DB
-- =========================================================

-- 1. Connect as SYSDBA
-- sqlplus / as sysdba

-- 2. Create PDB
CREATE PLUGGABLE DATABASE A_27105_Tracy_EarlySpoilageDetectionSystem_DB
ADMIN USER tracy_admin IDENTIFIED BY Tracy
ROLES = (DBA)
FILE_NAME_CONVERT = (
  'C:\app\pc\product\21c\oradata\XE\PDBSEED\',
  'C:\app\pc\product\21c\oradata\XE\A_27105_Tracy_EarlySpoilageDetectionSystem_DB\'
);

-- 3. Open PDB and save state
ALTER PLUGGABLE DATABASE A_27105_Tracy_EarlySpoilageDetectionSystem_DB OPEN;
ALTER PLUGGABLE DATABASE A_27105_Tracy_EarlySpoilageDetectionSystem_DB SAVE STATE;

-- 4. Switch session to PDB
ALTER SESSION SET CONTAINER = A_27105_Tracy_EarlySpoilageDetectionSystem_DB;

-- 5. Configure memory
ALTER SYSTEM SET SGA_TARGET = 200M SCOPE = SPFILE;
ALTER SYSTEM SET PGA_AGGREGATE_TARGET = 100M SCOPE = SPFILE;

-- 6. Create Tablespaces
CREATE TABLESPACE data_ts
DATAFILE 'C:\app\pc\product\21c\oradata\XE\A_27105_Tracy_EarlySpoilageDetectionSystem_DB\data_ts.dbf'
SIZE 50M
AUTOEXTEND ON NEXT 10M MAXSIZE 200M
EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE index_ts
DATAFILE 'C:\app\pc\product\21c\oradata\XE\A_27105_Tracy_EarlySpoilageDetectionSystem_DB\index_ts.dbf'
SIZE 50M
AUTOEXTEND ON NEXT 10M MAXSIZE 200M
EXTENT MANAGEMENT LOCAL;

CREATE TEMPORARY TABLESPACE temp_ts
TEMPFILE 'C:\app\pc\product\21c\oradata\XE\A_27105_Tracy_EarlySpoilageDetectionSystem_DB\temp_ts.dbf'
SIZE 20M
AUTOEXTEND ON NEXT 5M MAXSIZE 100M
EXTENT MANAGEMENT LOCAL;

-- 7. Admin user already exists
-- GRANT DBA privileges just in case
GRANT DBA TO tracy_admin;

-- 8. Verify tablespaces (optional)
-- SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb FROM dba_data_files;
-- SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb FROM dba_temp_files;
