# SQL Bootcamp - Week 2 Assignment

**Objective:**

The purpose of this assignment is to improve SQL querying skills using the `Invoice` table in the *Chinook* database, apply different SQL operations, and interpret the data.

---

## 1. Find the number of records in which all values are NULL.

**SQL Query:**
```sql
SELECT COUNT(*)
FROM Invoice
WHERE invoice_id IS NULL
  AND customer_id IS NULL
  AND invoice_date IS NULL
  AND billing_address IS NULL
  AND billing_city IS NULL
  AND billing_state IS NULL
  AND billing_country IS NULL
  AND billingpostal_code IS NULL
  AND total IS NULL;
```

**Explanation:**
- This query determines the number of records in the `Invoice` table where **all columns are NULL**.
- The `COUNT(*)` function counts the rows that meet the specified conditions.

**Row Count:**
> **0 or 1** (May vary depending on the data in the database.)

---

## 2. Display double the total values and compare them with the original values.

**SQL Query:**
```sql
SELECT invoice_id, customer_id, total, total * 2 AS total_double
FROM Invoice
ORDER BY total_double DESC;
```

**Explanation:**
- Doubles the value in the `total` column and creates a new column named `total_double`.
- Sorts the results in descending order using `ORDER BY total_double DESC`.

**Row Count:**
> **1–412** (May vary depending on the total number of invoices in the database.)

---

## 3. Combine the first 3 and last 4 characters of the address column and display the result as "Full Address".

- Filter invoices dated **August 2013**.

**SQL Query:**
```sql
SELECT
    CONCAT(SUBSTRING(billing_address FROM 1 FOR 3), SUBSTRING(billing_address FROM LENGTH(billing_address) - 3 FOR 4)) AS "Full Address"
FROM Invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2013
  AND EXTRACT(MONTH FROM invoice_date) = 8;
```

**Explanation:**
- Extracts the **first 3** and **last 4** characters from the `billing_address` column.
- Combines these two parts using the `CONCAT` function to create the `"Full Address"` column.
- Filters for the year **2013** using `EXTRACT(YEAR FROM invoice_date) = 2013` and for **August** using `EXTRACT(MONTH FROM invoice_date) = 8`.

**Row Count:**
> **1–7** (May vary depending on the number of invoices issued in August 2013.)

---

In this assignment, data analysis was performed using different SQL queries on the `Invoice` table. 🚀
