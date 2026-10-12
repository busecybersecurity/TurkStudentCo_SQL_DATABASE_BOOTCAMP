
-- Question 1: List the total amount of invoices from the USA created during 2009
SELECT SUM(total) AS total_invoice_amount
FROM invoice
WHERE billing_country = 'USA'
  AND EXTRACT(YEAR FROM invoice_date) = 2009;

-- Explanation:
-- Filters invoices in the "invoice" table to include only those from the USA
-- and calculates the total amount of invoices issued during 2009.
-- EXTRACT(YEAR FROM invoice_date) is used to extract the year from the invoice date.


-- Question 2: List all track information by joining tracks with their playlisttrack and playlist tables
SELECT t.*, pt.playlist_id, p.name AS playlist_name
FROM track t
JOIN playlisttrack pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

-- Explanation:
-- Joins the "track", "playlisttrack", and "playlist" tables
-- to show which playlist each track belongs to.
-- t.* retrieves all columns from the "track" table.
-- JOIN is used to combine related tables.


-- Question 3: List all tracks from the "Let There Be Rock" album with artist information, ordered by track duration
SELECT t.track_id,
       t.name AS track_name,
       a.name AS artist_name,
       t.milliseconds
FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN artist a ON al.artist_id = a.artist_id
WHERE al.title = 'Let There Be Rock'
ORDER BY t.milliseconds DESC;

-- Explanation:
-- Joins the "track", "album", and "artist" tables
-- to list the tracks from the "Let There Be Rock" album along with the artist names.
-- Sorts the results by track duration (milliseconds) in descending order,
-- from longest to shortest.
