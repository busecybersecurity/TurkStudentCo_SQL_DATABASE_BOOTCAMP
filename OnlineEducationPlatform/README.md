# 🎓 SQL Education Platform Database Project | PostgreSQL

Hello! This project is a **realistic and functional online education platform database model** that I developed for my university SQL course. My goal was not just to complete an assignment, but to deepen my SQL knowledge, understand relational databases, and build a structure suited to real-world scenarios.

---

## 🚀 Project Purpose and Scope

This database represents an educational platform where users (members) can register, enroll in and complete courses, receive certificates, and share knowledge through blog posts. The project was designed to meet the following requirements:

- **Data integrity** and consistency
- **Comprehensive table relationships** (members, courses, categories, certificates, and blogs)
- **Security and constraints** to prevent invalid data entry
- **Logical design suitable for real-world use**

---

## 🗃️ Tables and Their Functions

### 1. `members`

Stores basic user information, such as usernames, email addresses, and registration dates.

- `username` and `email` fields are unique.
- `join_date` automatically records the registration date.

### 2. `categories`

Organizes platform courses into categories such as programming and design.

- Each category has a unique name.

### 3. `courses`

Stores course information, including its category, start date, and end date.

- Dates are logically validated using a `CHECK` constraint.
- Courses are linked to categories through a foreign key.

### 4. `enrollments`

Tracks which members are enrolled in which courses.

- The same member cannot enroll in the same course more than once (`UNIQUE` constraint).

### 5. `certificates`

Stores certificate definitions associated with courses.

- Certificate codes are unique.

### 6. `certificate_assignments`

Records certificates awarded to members.

- Linked to members and certificates through foreign keys.

### 7. `blog_posts`

Stores posts shared by members.

- Each post belongs to a member, but posts are preserved if a member is deleted, helping prevent data loss.

---

## 🔐 Data Integrity and Constraints

A key goal of this project is to keep data accurate and consistent. The following constraints help achieve this:

- **PRIMARY KEY** uniquely identifies records in each table.
- **FOREIGN KEY** establishes relationships between tables and prevents inconsistent references.
- **UNIQUE** prevents duplicate values in designated fields.
- **NOT NULL** ensures required fields cannot be left empty.
- **CHECK** constraints ensure dates and values meet logical conditions.
- **ON DELETE CASCADE** and **ON DELETE SET NULL** help maintain data consistency when records are deleted.

---

## 📁 Project Files

- `create_tables.sql`: SQL commands for creating the tables
- `insert_data.sql`: Script for inserting sample data
- `reset_database.sql`: Resets the database to provide a clean starting point
- `queries.sql`: Example queries and tests used in the project

---

## 💡 Learning Process and Key Takeaways

Throughout this project, I reinforced both fundamental and advanced SQL concepts:

- Choosing appropriate data types and understanding the importance of constraints
- Relational database modeling techniques
- Complex queries and performance optimization
- Secure data management for real-world scenarios

---

## 👩‍💻 About the Developer

This project was more than just a university assignment; it was an opportunity to develop a deeper understanding of data structures and relational modeling. It was one of the projects that helped me truly understand SQL.

Connect with me and explore my projects:

[![GitHub](https://img.shields.io/badge/GitHub-000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/bushranovaaa)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/bushranovaaa/)

[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:kurtbusra956@gmail.com)

---

## ⚠️ Note

This project is an educational example. Before being used in a real-world platform, it would require detailed testing and further development in terms of security, scalability, and performance.

---

**Happy coding and productive learning!** 🚀
