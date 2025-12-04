CREATE TABLE holidays (
    holiday_date DATE PRIMARY KEY,
    description VARCHAR2(100)
);

-- Sample holidays
INSERT INTO holidays (holiday_date, description) VALUES (TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'New Year');
INSERT INTO holidays (holiday_date, description) VALUES (TO_DATE('2026-01-20', 'YYYY-MM-DD'), 'Public Holiday');
COMMIT;
