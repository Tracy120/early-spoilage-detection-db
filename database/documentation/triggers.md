# PHASE VII: Advanced Programming & Auditing Documentation

## Objective
Implement PL/SQL procedures, functions, and triggers to enforce business rules, audit actions, and restrict operations on certain days (weekdays and public holidays).

---

## 1. HOLIDAYS Table
**Purpose:**  
Stores the dates of public holidays for the current month.

**Columns:**
- `holiday_date` (DATE) – Primary key
- `description` (VARCHAR2) – Name of the holiday

**Sample Data:**
| holiday_date | description    |
|--------------|----------------|
| 2025-12-25   | Christmas Day |

---

## 2. AUDIT_LOG Table
**Purpose:**  
Records all attempted operations on restricted tables, whether allowed or denied.

**Columns:**
- `audit_id` – Auto-generated primary key
- `user_name` – User performing the action
- `action_date` – Timestamp of action
- `table_name` – Table affected
- `action_status` – ALLOWED or DENIED
- `details` – Reason or outcome of the action

---

## 3. Procedures and Functions

### LOG_AUDIT Procedure
**Purpose:**  
Logs every attempt to perform an operation on restricted tables.

**Parameters:**
- `p_user_name` – User performing the action
- `p_event` – Operation type (INSERT, UPDATE, DELETE)
- `p_table_name` – Table affected
- `p_status` – ALLOWED or DENIED
- `p_details` – Additional info

---

### CHECK_RESTRICTION Function
**Purpose:**  
Checks if the current operation is allowed based on day restrictions.

**Logic:**
- Denies operations on weekdays (Mon–Fri)
- Denies operations on holidays present in the `HOLIDAYS` table
- Returns `'ALLOWED'` if the operation can proceed

---

## 4. Trigger: TRG_SENSOR_BI
**Purpose:**  
- Enforces the business rule on the `SENSOR` table
- Calls `CHECK_RESTRICTION` function
- Logs the operation using `LOG_AUDIT`
- Raises an exception if operation is denied

**Type:**  
`BEFORE INSERT OR UPDATE OR DELETE ON SENSOR FOR EACH ROW`

**Behavior:**
- If restriction violated → operation denied + audit log updated
- If allowed → operation completed + audit log updated

---

## 5. Testing
- **Attempted insert on weekday/public holiday:**  
  Operation fails, error message displayed, entry logged in `AUDIT_LOG`.

- **Attempted insert on allowed day:**  
  Operation succeeds, entry logged in `AUDIT_LOG`.

**Sample audit log output:**

| USER_NAME   | ACTION_DATE         | TABLE_NAME | ACTION_STATUS | DETAILS                  |
|------------|-------------------|------------|---------------|--------------------------|
| TRACY_ADMIN | 2025-12-04 10:20  | SENSOR     | DENIED        | Weekday                  |
| TRACY_ADMIN | 2025-12-07 14:35  | SENSOR     | ALLOWED       | Action executed successfully |

---

## 6. Notes
- The `SENSOR` table may appear empty if all insert attempts are denied.
- All actions are audited for accountability and compliance.
- Triggers and functions are modular and reusable for other tables if needed.

---

## 7. How to Run
1. Connect to Oracle SQL Developer as `tracy_admin`.
2. Run the script `phase_vii_triggers.sql`.
3. Verify:
   - Table `SENSOR` for inserted rows
   - Table `AUDIT_LOG` for recorded attempts
4. Test inserts on weekdays/weekends and holidays to confirm enforcement.

