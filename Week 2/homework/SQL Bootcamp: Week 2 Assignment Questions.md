# SQL Bootcamp -- Week 2 Homework Questions

## 1. Objective

On your first day as a data scientist at Turkstudentco, you were given
the `Invoice` table from the Chinook database. After examining this
table, you had a few questions, and you were asked to write SQL queries
to answer them. The purpose of this assignment is to improve your
database querying skills and apply various SQL operations.

## 2. Invoice Table (Sample Data)

The table below shows sample records from the `Invoice` table (not a
complete set). The columns are, in order:

-   `invoice_id`
-   `customer_id`
-   `invoice_date`
-   `billing_address`
-   `billing_city`
-   `billing_state`
-   `billing_country`
-   `billingpostal_code`
-   `total`

| invoice_id | customer_id | invoice_date        | billing_address | billing_city | billing_state | billing_country | billingpostal_code | total |
|------------|-------------|---------------------|-----------------|--------------|---------------|-----------------|--------------------|-------|
| 1          | 18          | 2017-01-03 00:00:00 | 627 Broadway    | New York     | NY            | USA             | 10012-2612         | 15.84 |
| 2          | 30          | 2017-01-03 00:00:00 | 230 Elgin Street| Ottawa       | ON            | Canada          | K2P 1L7            | 9.90  |
| 3          | 40          | 2017-01-05 00:00:00 | 8, Rue Hanovre  | Paris        | None          | France          | 75002              | 1.98  |
| 4          | 18          | 2017-01-06 00:00:00 | 627 Broadway    | New York     | NY            | USA             | 10012-2612         | 7.92  |                                                   

**Note:** This table shows a sample portion of the invoice structure;
you can access the full dataset via the link below:

[Open the full dataset on Google
Drive](https://drive.google.com/drive/folders/1kwnUOyf311vlW7Vm5XGCvXYE9CTMvOks?usp=sharing)

## 3. Questions

1.  In the `Invoice` table, find the number of records where all values
    are `NULL`. You must perform this operation with a single query.
    After writing the query, specify the **Row Count** shown in the
    lower-left corner of PostgreSQL in a comment line in your SQL query.

2.  The coordination team has pointed out an error in the `Total`
    values. Write a query to display these values multiplied by two and
    compare them with their previous versions. Additionally, to make the
    data easier to track, sort the table's new version by the specified
    column in descending order.

3.  Combine the data in the `Address` column by taking the first 3
    characters from the left and the last 4 characters from the right,
    and label the result **"Full Address"**. You must also filter this
    new full address by the year 2013 and the 8th month.

## 4. Submission Rules and Conditions

Things to keep in mind when submitting your assignment:

1.  Prepare a file (in `.txt` or `.pdf` format) containing your SQL
    queries and brief explanations.
2.  Explain your queries in your own words and describe how they work.
3.  No sample answers or hints are provided in the assignment; you are
    expected to create your own queries based on what you have learned.

**Due Date:** March 18, 2025 -- 11:59 PM

**Submission Address:** [Submit the assignment using this
form](https://forms.gle/oDhKSYaHjHYEJ9X17)
