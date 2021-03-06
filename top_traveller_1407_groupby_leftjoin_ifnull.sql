/*
Write an SQL query to report the distance travelled by each user.

Return the result table ordered by travelled_distance in descending order
if two or more users travelled the same distance, order them by their name in ascending order.

The query result format is in the following example.

 

Users table:
+------+-----------+
| id   | name      |
+------+-----------+
| 1    | Alice     |
| 2    | Bob       |
| 3    | Alex      |
| 4    | Donald    |
| 7    | Lee       |
| 13   | Jonathan  |
| 19   | Elvis     |
+------+-----------+

Rides table:
+------+----------+----------+
| id   | user_id  | distance |
+------+----------+----------+
| 1    | 1        | 120      |
| 2    | 2        | 317      |
| 3    | 3        | 222      |
| 4    | 7        | 100      |
| 5    | 13       | 312      |
| 6    | 19       | 50       |
| 7    | 7        | 120      |
| 8    | 19       | 400      |
| 9    | 7        | 230      |
+------+----------+----------+

Result table:
+----------+--------------------+
| name     | travelled_distance |
+----------+--------------------+
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |
+----------+--------------------+
*/

/* logic
group by each user_id, sum(distance)
look for their name
order by distance desc, name asc
*/

WITH Aggregated_Rides AS (SELECT user_id, SUM(distance) AS travelled_distance
                          FROM Rides
                          GROUP BY user_id)
                          
SELECT u.name, IFNULL(a.travelled_distance, 0) AS travelled_distance
FROM Users AS u LEFT JOIN Aggregated_Rides AS a
ON u.id = a.user_id
ORDER BY a.travelled_distance DESC, u.name ASC
;
