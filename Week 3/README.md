# SQL Bootcamp – Week 3 Assignment Questions

## Objective

The purpose of this assignment is to improve your SQL query-writing skills and practice different SQL operations. In this assignment, you are required to solve the given questions by querying different tables in the Chinook database.

## Tables to Be Used

- **invoice**: Contains information about invoices.
- **track**: Contains track information.
- **playlisttrack**: Shows which playlists each track belongs to.
- **playlist**: Contains playlist information.
- **album**: Contains album information.
- **artist**: Contains artist information.

## Questions

### Question 1: Invoice Table

**Question:**  
Write a query that lists the total amount of all invoices created in the USA during 2009.

The following SQL query calculates the total amount of all invoices created in the USA during 2009.

```sql
SELECT SUM(total) AS total_invoice
FROM invoice
WHERE billing_country = 'USA'
  AND EXTRACT(YEAR FROM invoice_date) = 2009;
```

**Explanation:**

- **SUM(total)** calculates the total amount of the invoices.
- **EXTRACT(YEAR FROM invoice_date)** extracts the year from the invoice date and selects only invoices from 2009.

### Question 2: JOIN on the Track, PlaylistTrack, and Playlist Tables

Write a query that lists all track information by joining the `track` table with the related `playlisttrack` and `playlist` tables.

The following SQL query joins all tracks with the playlists they belong to.

```sql
SELECT t.track_id, t.name AS track_name, p.name AS playlist_name
FROM track t
JOIN playlisttrack pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;
```

**Explanation:**

- We connect the `track` table with the `playlisttrack` and `playlist` tables.
- The `JOIN` operation displays the name of the playlist associated with each track.

### Question 3: JOIN on the Track, Album, and Artist Tables

Write a query that lists all tracks from the album **"Let There Be Rock"**, including the artist information. Also, sort the results by track duration (`milliseconds`) in descending order.

The following SQL query lists all tracks from the album **"Let There Be Rock"** along with the artist information.

```sql
SELECT t.name AS track_name, a.name AS artist_name, t.milliseconds
FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN artist a ON al.artist_id = a.artist_id
WHERE al.title = 'Let There Be Rock'
ORDER BY t.milliseconds DESC;
```

**Explanation:**

- We join the `track` table with the `album` and `artist` tables.
- The **WHERE** clause filters the results to include only the album titled "Let There Be Rock".
- **ORDER BY t.milliseconds DESC** sorts the tracks by duration from longest to shortest.

## Notes

- Each query in this assignment allows you to query different tables in the database.
- Writing SQL queries correctly and establishing the correct relationships between tables are important when working with data.