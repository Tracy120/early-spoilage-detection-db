# Design Decisions

- Audit log uses autonomous transactions to avoid ORA-04092.
- Restriction logic placed in a dedicated function (CHECK_RESTRICTION).
- Triggers call CHECK_RESTRICTION and LOG_AUDIT for clean separation.
- Holiday table allows dynamic extension of policy rules.
- Using BEFORE INSERT triggers ensures no invalid data enters the system.
