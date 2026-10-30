# Database Design Project for an Online Learning Platform Using PostgreSQL

In this project, you will set up a database for an “Online Education Platform” using the PostgreSQL database management system. On this platform, members will be able to register, participate in courses, earn certificates from these courses, and advance to higher levels on their profile pages by posting on the blog. The project aims to help you gain hands-on experience with database design principles and the use of PostgreSQL through a practical scenario.

## 1. Database Schema Design

Design tables that will support the following basic functions:

1. **Members:** Will store member information (username (VARCHAR(50) UK), email (VARCHAR (100) UK), password (VARCHAR(255)), registration date (TIMESTAMP), first name (VARCHAR(50)), last name (VARCHAR(50)), etc.). Define a Primary Key (PK) (INTEGER or BIGINT) in this table.

2. **Courses:** Create a table to store information about the courses on the platform (name (VARCHAR(200)), description (TEXT), start date (DATE), end date (DATE), instructor information (VARCHAR(100)), etc.). Define a Primary Key (PK) (INTEGER or BIGINT) in this table.

3. **Categories:** Create a table to manage education categories (artificial intelligence (VARCHAR(100)), blockchain (VARCHAR(100)), cybersecurity (VARCHAR(100)), etc.). Define a Primary Key (PK) (INTEGER or SMALLINT) in this table. Establish a relationship between courses and categories (using a Foreign Key (FK) (INTEGER or SMALLINT)).

4. **Enrollments:** Create a intermediate table to track which courses users have enrolled in. This table should manage the many-to-many relationship between the users (INTEGER or BIGINT FK) and courses (INTEGER or BIGINT FK) tables and should contain the foreign keys (FK) for both tables. A Primary Key (PK) (INTEGER or BIGINT) can also be defined in this table (for example, an auto-incrementing ID). Optionally, information such as the enrollment date (TIMESTAMP) can also be included.

5. **Sertifikalar (Certificates):** Tamamlanan eğitimler için sertifika bilgilerini (sertifika kodu (VARCHAR(100) UK), veriliş tarihi (DATE) vb.) saklayacak bir tablo oluşturun. Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya BIGINT) tanımlayın.

6. **Certificate Assignments (CertificateAssignments):** Create a table that maps which user (INTEGER or BIGINT FK) has been assigned which certificate (INTEGER or BIGINT FK) (It must be linked to the members and certificates tables using foreign keys (FK)). Define a Primary Key (PK) (INTEGER or BIGINT) in this table, and you may optionally add information such as the issuance date (DATE).

7. **Blog Posts (BlogPosts):** Create a table to store users' blog posts (title (VARCHAR(255)), content (TEXT), publication date (TIMESTAMP), author information (INTEGER or BIGINT FK), etc.). This table must be related to the members table (using a Foreign Key (FK)) and must contain a Primary Key (PK) (INTEGER or BIGINT).

## 2. Primary and Foreign Keys:

1. Define a **Primary Key (PK)** in each table. Select the appropriate data type **(INTEGER, BIGINT, SMALLINT, etc.).**

2. Use **Foreign Keys (FK)** to correctly establish relationships between tables. Make sure the data types of the foreign key columns match the data types of the primary key columns they are related to.

3. Define **Unique Keys (UK)** in the necessary fields to ensure data uniqueness (for example, username **(VARCHAR)**, email **(VARCHAR)**, certificate code **(VARCHAR)**). Specify the appropriate lengths.

## 3. Creating an SQL File
1. Create a . sql file that defines all the tables you have created, along with their column names, appropriate **data types (INTEGER, BIGINT, VARCHAR, TEXT, DATE, TIMESTAMP, FLOAT, BOOLEAN, etc.), Primary Key (PK), Foreign Key (FK)**, and **Unique Key (UK)** constraints. Add constraints such as NOT NULL where necessary.

2. This .sql file must ensure that the database can be created from scratch and that relationships can be established.

## 4. General Schema Screenshot

Take a screenshot of a database schema diagram that visually displays the tables you have created and the **Primary Key (PK)** and **Foreign Key (FK)** relationships between them (as indicated by arrows). This will help in understanding the database design. Try to include the column names and data types in the schema as well.

## 5. Creating a GitHub Repository

1. After completing your project, create a GitHub repository containing the .sql file you created and a screenshot of the overall schema.

2. Make your repository **public** so that we can evaluate your project.

3. After completing your project, submit the link to your GitHub repository—which includes your .sql file and a screenshot of the overall schema—by 11:59 PM on **[April 25, 2025]** by filling out the required information in the form below.

## 6.Evaluation Criteria:
1. Accuracy and consistency of the database design.

2. Modeling of tables and relationships appropriate to the requirements.

3. Correct and effective use of **Primary Key (PK), Foreign Key (FK), and Unique Key (UK)** constraints.

4. Selection of appropriate **data types** for columns.

5. The generated .sql file must run without errors.

6. Clear and accurate visualization of the database schema.

7. Correct use of GitHub (creating a repo)

Project Submission Form: `https://forms.gle/PSSWr4LD3ya7Z1W88`

Good luck!