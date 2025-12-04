# PDB Setup – PHASE IV

1. Connect as SYSDBA: `sqlplus / as sysdba`
2. Create PDB:
   - Name: A_27105_Tracy_EarlySpoilageDetectionSystem_DB
   - Admin User: tracy_admin / Password: Tracy
   - Roles: DBA
   - File conversion: from PDBSEED to new PDB folder
3. Open the PDB and save state
4. Switch session to PDB
5. Configure memory: SGA=200M, PGA=100M
