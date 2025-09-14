
---Part 1: Basic SQL Operations and JOIN Queries

---1/ Basic Selection: Retrieve the titles and publication years of all books published after 2000, ordered by publication year (newest first).
/*
SELECT title, publication_year
from books
where publication_year > 2000
order by publication_year DESC;
*/

---2/ Find all books with more than 5 copies owned in the fiction genre (genre_id = 1).
/*
SELECT 
     books.book_id,
	 books.title,
	 books.copies_owned
FROM books
inner JOIN genres
			on books.genre_id = genres.genre_id
where genres.genre_id = 1 and books.copies_owned > 5
order by copies_owned DESC;
*/

---3/ List all books whose titles contain the word "History".
/*
SELECT *
from books
where title like '%History%'
order by title ASC;
*/
---4/ Display loan information (loan_id, checkout_date, due_date) along with patron details (first_name, last_name, email) for all loans made in January 2023.
/*
SELECT
			loans.loan_id,
			loans.checkout_date,
			loans.due_date,
			patrons.first_name,
			patrons.last_name,
			patrons.email
FROM loans
INNER JOIN patrons
				on loans.patron_id = patrons.patron_id
where loans.checkout_date BETWEEN '2023-01-01' and '2023-01-=31'
order by checkout_date ASC;
*/

---5/  Show book details (title, author's full name, genre_name) for each loan, along with the checkout_date and due_date.
/*
SELECT
				books.title,
				authors.first_name || " " || authors.last_name AS  author_full_name,
				genres.genre_name,
				patrons.first_name || " " || patrons.last_name AS patron_full_name,
				patrons.email,
				loans.checkout_date,
				loans.due_date
FROM loans
INNER JOIN patrons
		ON patrons.patron_id = loans.patron_id
INNER JOIN books
		ON books.book_id = loans.book_id
INNER JOIN authors
		ON	authors.author_id = books.author_id
INNER JOIN genres
		ON genres.genre_id = books.genre_id
ORDER BY due_date ASC;
*/

---6/  Find pairs of patrons who live in the same city. Show both patrons' names and their city.

/*
SELECT 
    p1.first_name || ' ' || p1.last_name || ' & ' ||
    p2.first_name || ' ' || p2.last_name AS patron_pair,
    p1.city
FROM patrons p1
JOIN patrons p2
  ON p1.city = p2.city
 AND p1.patron_id < p2.patron_id
ORDER BY p1.city, patron_pair;
*/

--- 7/ Find all fiction books (genre_id = 1) that have been borrowed, along with the patron name and the branch where they were borrowed from.
/*
SELECT
				books.title,
				patrons.first_name || ' ' || patrons.last_name  AS patron_name,
				branches.branch_name
FROM loans
INNER JOIN books
                  ON books.book_id = loans.book_id
INNER JOIN patrons
				ON patrons.patron_id = loans.patron_id
INNER JOIN branches
				ON branches.branch_id = loans.branch_id
INNER JOIN genres
		ON genres.genre_id = books.genre_id
WHERE genres.genre_id = 1
ORDER BY	title ASC;
*/

--- 8/ Count the number of books in each genre category.
/*
SELECT
				genres.genre_name,
				count(*) AS number_of_books
from books
join genres
		on genres.genre_id = books.genre_id
group by genre_name
order by number_of_books desc;
*/

--- 9 Calculate the average, minimum, and maximum loan duration (days between checkout and return) for each library branch. Include only returned books.
/*
SELECT
                branches.branch_name,
				avg(julianday(return_date) - julianday(checkout_date)) AS avg_loan_duration,
				max(julianday(return_date) - julianday(checkout_date)) AS max_loan_duration,
				min(julianday(return_date) - julianday(checkout_date)) AS min_loan_duration
from loans
join branches
       on branches.branch_id = loans.branch_id
group by branch_name
ORDER by avg_loan_duration DESC;
*/

--- 10 Find patrons with overdue books (due_date < CURRENT_DATE and return_date = ''), along with the count of overdue books they have.
/*
SELECT 
				patrons.patron_id,
				patrons.first_name || " " || patrons.last_name AS patron_name,
				count(*) AS num_of_overdue_books
from loans
join patrons
		on patrons.patron_id = loans.patron_id
WHERE due_date < CURRENT_DATE and return_date is NULL
group by patrons.patron_id
ORDER by num_of_overdue_books DESC;
*/

--- 11 Analyze monthly borrowing trends. Show the year, month, number of loans, and number of unique patrons for each month.
/*
SELECT 
				strftime('%m', checkout_date) AS month,
				strftime('%Y', checkout_date) AS year,
				count(loan_id) as num_of_loans,
				count(DISTINCT patron_id) as num_of_unique_patrons
from loans
group by month
order by num_of_loans desc;
*/

---dq 4 
/*
SELECT
				publication_year,
				title
from books
WHERE title like '%History%' and publication_year >= 2015
ORDER by publication_year desc;
*/


				
