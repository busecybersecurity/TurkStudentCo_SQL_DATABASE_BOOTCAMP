# 📌 Week 1 – SQL Assignments

🎯 **Objective**

These assignments are designed to reinforce the use of SQL queries for data selection, filtering, sorting, and joining operations in a database.

---

## 📂 Database Tables

### 🔹 Employees Table

| EmployeeID | FirstName | LastName | Age | Department | Salary | JoinDate |
|---|---|---|---|---|---|---|
| 1 | Ahmet | Yılmaz | 30 | IT | 8000 | 2020-03-15 |
| 2 | Ayşe | Kaya | 28 | HR | 7500 | 2021-06-22 |
| 3 | Mehmet | Demir | 35 | IT | 9000 | 2018-09-10 |
| 4 | Elif | Şahin | 26 | Finance | 7200 | 2022-02-05 |

### 🔹 Departments Table

| DepartmentID | DepartmentName |
|---|---|
| 1 | IT |
| 2 | HR |
| 3 | Finance |

---

## 📝 Tasks and SQL Queries

### 1️⃣ Selecting Specific Columns

Query to display only the **FirstName, LastName, and Salary** information of employees:

```sql
SELECT FirstName, LastName, Salary
FROM Employees;
```

### 2️⃣ Removing Duplicates with the DISTINCT Keyword

Query to display employees' departments without duplicates:

```sql
SELECT DISTINCT Department
FROM Employees;
```

### 3️⃣ Listing Employees in a Specific Department

Query to list employees who work in the **IT department**:

```sql
SELECT *
FROM Employees
WHERE Department = 'IT';
```

### 4️⃣ Sorting by Salary

Query to sort employees by salary in **descending order**, from highest to lowest:

```sql
SELECT *
FROM Employees
ORDER BY Salary DESC;
```

### 5️⃣ Concatenating Columns

Query to combine the **FirstName and LastName** columns into a new column containing employees' full names:

```sql
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Salary
FROM Employees;
```

---

## 📌 How to Use

1. Open your SQL database environment (you can use PostgreSQL).
2. Create the `Employees` and `Departments` tables.
3. Run the SQL queries above and observe the results.

---

## 📬 Contact & Contributions

If you would like to contribute to this project, feel free to submit a **pull request**. 💡