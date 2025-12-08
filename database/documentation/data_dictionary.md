# Data Dictionary

| Table      | Column        | Type          | Constraints | Purpose |
|------------|---------------|---------------|-------------|---------|
| SENSOR     | SENSOR_ID     | NUMBER        | PK          | Unique sensor ID |
|            | SENSOR_TYPE   | VARCHAR2(30)  | NOT NULL    | Type of sensor |
|            | LOCATION      | VARCHAR2(50)  | NOT NULL    | Physical location |
| HOLIDAYS   | HOLIDAY_DATE  | DATE          | PK          | Public holiday |
| AUDIT_LOG  | LOG_ID        | NUMBER        | PK          | Audit entry |
|            | ACTION_TYPE   | VARCHAR2(20)  |             | INSERT/UPDATE/DELETE |
|            | STATUS        | VARCHAR2(20)  |             | ALLOWED/DENIED |
