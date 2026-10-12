# SQL Bootcamp -- Week 3 Assignment Questions

## 1. Objective

On your first day as a data scientist at Turkstudentco, you are given the `Invoice` table from the Chinook database. After examining this table, several questions come to mind, and you are asked to write SQL queries to answer them. The purpose of this assignment is to improve your database-querying skills and help you practice different SQL operations.

**Table download link:**  
[https://drive.google.com/drive/folders/1bVmqvb79lHNalzohIAR4JE7ghPLWSRTu?usp=sharing](https://drive.google.com/drive/folders/1bVmqvb79lHNalzohIAR4JE7ghPLWSRTu?usp=sharing)

## 2. Invoice Table (Sample Data)

The table below shows sample records from the `Invoice` table (not the complete dataset). The columns, in order, are:

- `invoice_id`
- `customer_id`
- `invoice_date`
- `billing_address`
- `billing_city`
- `billing_state`
- `billing_country`
- `billingpostal_code`
- `total`

| invoice_id | customer_id | invoice_date         | billing_address  | billing_city | billing_state | billing_country | billingpostal_code | total |
|-----------:|------------:|----------------------|------------------|--------------|---------------|-----------------|--------------------|------:|
| 1 | 18 | 2017-01-03 00:00:00 | 627 Broadway | New York | NY | USA | 10012-2612 | 15.84 |
| 2 | 30 | 2017-01-03 00:00:00 | 230 Elgin Street | Ottawa | ON | Canada | K2P 1L7 | 9.90 |
| 3 | 40 | 2017-01-05 00:00:00 | 8, Rue Hanovre | Paris | None | France | 75002 | 1.98 |
| 4 | 18 | 2017-01-06 00:00:00 | 627 Broadway | New York | NY | USA | 10012-2612 | 7.92 |

## Album Table (Sample Data)

The table below shows sample records from the `Album` table (not the complete dataset). The columns, in order, are: `album_id`, `title`, `artist_id`.

| album_id | title | artist_id |
|----------:|---------------------------------------|-----------:|
| 1 | For Those About To Rock We Salute You | 1 |
| 2 | Balls to the Wall | 2 |
| 3 | Restless and Wild | 2 |
| 4 | Let There Be Rock | 1 |
| 5 | Big Ones | 3 |
| 6 | Jagged Little Pill | 4 |

## Artist Table (Sample Data)

The table below shows sample records from the `Artist` table (not the complete dataset). The columns, in order, are: `artist_id`, `name`.

| artist_id | name |
|----------:|-------------------|
| 1 | AC/DC |
| 2 | Accept |
| 3 | Aerosmith |
| 4 | Alanis Morissette |
| 5 | Alice In Chains |

**Note:** This table shows only a sample of the `Artist` table; the complete dataset contains more records.

## Playlist Table (Sample Data)

The table below shows sample records from the `Playlist` table (not the complete dataset). The columns, in order, are: `playlist_id`, `name`.

| playlist_id | name |
|-------------:|------------|
| 1 | Music |
| 2 | Movies |
| 3 | TV Shows |
| 4 | Audiobooks |
| 5 | 90's Music |

**Note:** This table shows only a sample of the `Playlist` table; the complete dataset contains more records.

## PlaylistTrack Table (Sample Data)

The table below shows sample records from the `PlaylistTrack` table (not the complete dataset). The columns, in order, are: `playlist_id`, `track_id`.

| playlist_id | track_id |
|-------------:|----------:|
| 1 | 1 |
| 1 | 2 |
| 1 | 3 |
| 1 | 4 |
| 1 | 5 |

**Note:** This table shows only a sample of the `PlaylistTrack` table; the complete dataset contains more records.

## 3. Questions

### Question 1: Invoice Table

**Question:** Write a query that lists the total amount of all invoices associated with the country "USA" that were created during 2009.

**Table to use:** `invoice`

### Question 2: JOIN on the Track, PlaylistTrack, and Playlist Tables

**Question:** Write a query that lists all track information by joining the tracks with the `playlisttrack` and `playlist` tables to which they belong.

**Tables to use:** `track`, `playlisttrack`, `playlist`

### Question 3: JOIN on the Track, Album, and Artist Tables

**Question:** Write a query that lists all tracks from the album titled **"Let There Be Rock"**, including the artist information. Also, sort the results by track duration (`milliseconds`) in descending order.

**Tables to use:** `track`, `album`, `artist`

## 4. Submission Rules and Requirements

Please pay attention to the following requirements when submitting your assignment:

1. Prepare a file containing your SQL queries and brief explanations in `.txt`, `.pdf`, or `.sql` format.
2. Explain in your own words how each query works.
3. The assignment does not provide sample answers or hints; you are expected to create your own queries based on what you have learned.
4. **Deadline:** 25 March 2025, 23:59.
5. **Submission link:** [https://forms.gle/1WJZCFQtSLdFaw5H7](https://forms.gle/1WJZCFQtSLdFaw5H7)
