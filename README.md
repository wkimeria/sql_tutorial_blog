# A gentle Introduction to SQL
This is a gentle introduction to SQL (Structured Query Language), a language used to query data stored in a relational database management system (RDBMS).

Chances are, if you are programming using one of the popular frameworks, you will not be writing raw SQL, instead your framework will have an ORM (Object Relation Mapping) layer to manage data access for you (i.e Rails has ActiveRecord, Java has Hibernate etc). In fact, most times you should not write raw SQL. However, I feel that knowing at least the basics of writing SQL is a useful life skill.

 This tutorial is aimed at people who have little to no knowledge/experience with SQL. For my example, 
I’m going to use MySQL, a popular free/open source (for the Community Edition) database, but it will mostly work for any popular database (Postgress, Microsoft SQL Server etc) or any other ANSI SQL 92 compliant database. I spent part of my misspent youth (well, 20s) working with Microsoft SQL Server, both as a developer and Administrator (I have Microsoft SQL 6.5 Developer and Administrator Certifications gathering dust somewhere in our house), so lets jump right in.

## Prerequisites
There are little to no prerequisites, though access to a server running MySQL would be helpful. The script to create the database tables/data ar in this repo

The examples I’m using is that of a small College that maintains a small amount of data in a MySQL database. 

The tables are;
- `accounts` (information about each students balance)
- `enrollments` (courses that students are enrolled in)
- `courseInstructors` (which courses are taught by which instructors)
- `instructors` (a list of all the instructors)
- `courses` (a listing of all the courses)
- `students` (a listing of all the students)
- `coursePricings` (a listing of course pricings by course types)
- 
## Simple SELECT
At its root, SQL is about answering questions given some data. For our small college, I would like to answer some basic questions. Lets start with queries that can be answered by the data in a single table. For each query, 
I'll list the question and then the SQL query to get that information (if you create the tables in this script, you can follow along by running the queries at the sql command line or in SQL Workbench (a graphical UI for MySQL)

_I’d like to know if my college has any students called Kamaru_

```
SELECT * FROM students WHERE lastName = ‘Kamaru’;
```

The * operator is a shorthand way to ask for all the columns in the table (or tables) being queried.

_Tell me what courses we offer that have “Calculus” in their name_

```
SELECT * FROM courses WHERE name LIKE "%Calculus%";
```

The “%” character specifies to match any characters. So the above would match “Introduction to Calculus” and “Calculus II”. If we changed the clause to “Calculus%” that would only match the latter (words beginning with Calculus)

_Is Samira Khan one of the course instructors?_

```
SELECT * FROM instructors where firstName = ‘Samira’ AND lastName = ‘Khan’;
```

_Is Jacques Anquetil up to date on his course payment?_

```SELECT a.* FROM accounts a
JOIN students s
ON s.studentId = a.studentId
WHERE s.firstName = 'Jacques'
AND s.lastName = 'Anquetil';
```

## JOIN
The slightly more complex version of a SELECT statement is one where you ask a question that cannot be answered by only looking at a single table.

_What courses is Miriam Schuyler enrolled in?_

```
SELECT s.* FROM students s
JOIN enrollments e
ON e.studentId = s.studentId
WHERE s.firstName = ‘Miriam’
AND s.lastName = ‘Schuyler’;
```

The s and e above are simply aliases, they allow us to give shorter designations to the enrollments and students table to make referring to them easier in the rest of the query. The query above is functionally similar to

```

_Is Jacques Anquetil up to date on his course payment?_

```SELECT a.* FROM accounts a
JOIN students s
ON s.studentId = a.studentId
WHERE s.firstName = 'Jacques'
AND s.lastName = 'Anquetil';
```

## JOIN
The slightly more complex version of a SELECT statement is one where you ask a question that cannot be answered by only looking at a single table.

_What courses is Miriam Schuyler enrolled in?_

```
SELECT s.* FROM students s
JOIN enrollments e
ON e.studentId = s.studentId
WHERE s.firstName = ‘Miriam’
AND s.lastName = ‘Schuyler’;
```

The s and e above are simply aliases, they allow us to give shorter designations to the enrollments and students table to make referring to them easier in the rest of the query. The query above is functionally similar to

```
SELECT students.* FROM students
JOIN enrollments
ON enrollments.studentId = students.studentId
WHERE students.firstName = 'Miriam'
AND students.lastName = 'Schuyler';
```

_What courses does Wanjiku Njeri teach? (I only want the course name, hence the use of c.name rather than c.*)_

```
SELECT c.name FROM courses c
JOIN CourseInstructors ci
ON ci.courseId = c.courseId
JOIN instructors i 
ON i.instructorId = ci.instructorId
WHERE i.firstName = 'Wanjiku'
AND i.lastName ='Njeri';
```

_Which courses and students does Tina Ho teach? (Keep in mind that she could teach multiple courses)_

```
SELECT c.name, s.firstName, s.lastName FROM students s
JOIN enrollments e
ON e.studentId = s.studentId
JOIN CourseInstructors ci
ON ci.courseInstructorId = e.courseInstructorId
JOIN instructors i 
ON i.instructorId = ci.instructorId
JOIN courses c
ON c.courseId = ci.courseId
WHERE i.firstName = 'Tina'
AND i.lastName ='Ho';
```

### Small aside on table relationships
- A _one-to-one relationship_ means that a row in table A is related to a single Row in Table B. In the database schema above, there is a one to one relationship between a student and a row in the studentsAccounts table
- A _one-to-many relationship_ means that a row in table A is related to multiple rows in Table B. students have a one to many relationship to the enrollments table, since a single student can be enrolled in multiple courses
- _A many-to-many relationship_ normally involves an intermediary table (sometimes called a cross-walk table), and means that multiple rows in Table A correlate to multiple rows in Table C via Table B. A student has a many to many relationship with instructors (through the enrollments table), because a student can have multiple instructors, and an instructor can have multiple students).

## GROUP BY
The GROUP BY clause groups similar rows/columns, and is usually used in combination with other query modifiers/functions. 

For example;
_Show me how much each student should be paying this semester based on the classes that they have enrolled in. Order the results from students who
owe the most to students who owe the least._

Let us break this more complex question into a series of simpler questions.

First, we know that we need to get student information (stored in the students table) as well as what they are enrolled in (enrollments). 
We also know that in order to find out what courses they are enrolled in, we need to join enrollments to courseInstructor . 
To get how much each course costs, we would join to coursePricings.

Lets look at this for a single student

_Show me what courses Awori Otieno is enrolled in, as well as how much each course costs._

```
SELECT c.name, cp.price from enrollments e
JOIN students s
ON s.studentId = e.studentId
JOIN courseInstructors ci
ON ci.courseInstructorId = e.courseInstructorId
JOIN courses c
ON c.courseId = ci.courseId
JOIN coursePricings cp
ON cp.type = c.type
WHERE s.firstName = ‘Awori’
AND s.lastName =’Otieno’
Results -----------------------------------
name               price
 — — — — — — — — — — — — — 
“College Algebra”  0000002000
“Figure Drawing”   0000002000
```
Awori Otieno is enrolled in 2 courses, both of which cost $2000 each

Now, I’d like to know how much Awori Otieno owes for this semester. I could do this the hard way, fetch the rows above, and then programmatically sum the price column. If I wanted to do this for every student I would have to repeat the above procedure for each and every student.
But there is a better way using plain SQL). Enter *GROUP BY!*


_How much should Awori Otieno pay this sememster?_

```
SELECT s.firstName, s.lastName, SUM(cp.price)
FROM enrollments e
JOIN CourseInstructors ci
 ON ci.courseInstructorId = e.courseInstructorId
JOIN students s
ON s.studentId = e.studentId
JOIN courses c
ON c.courseId = ci.courseId
JOIN coursePricings cp
ON cp.type = c.type
WHERE s.firstName = ‘Awori’
AND s.lastName =’Otieno’
GROUP BY s.studentId
Results -----------------------------------
firstName  lastName SUM(cp.price)
 — — — — — — — — — — — — — — — — — — — — 
Awori      Otieno   4000
```

which makes sense (2000 + 2000 = 4000)

Here is the fully constructed query to get how much each student owes sorted from highest to lowest.

_Show me what each student should pay this semester, and order it from highest to lowest._

```
SELECT s.firstName, s.lastName, SUM(cp.price)
FROM enrollments e
JOIN CourseInstructors ci
ON ci.courseInstructorId = e.courseInstructorId
JOIN students s
    ON s.studentId = e.studentId
JOIN courses c
ON c.courseId = ci.courseId
JOIN coursePricings cp
ON cp.type = c.type
GROUP BY s.studentId
ORDER BY SUM(cp.price)  DESC
Results -----------------------------------
firstName, lastName, SUM(cp.price)
— — — — — — — — — — — — — — — — — — — —
Claire,    Donovan,  11000
Samuel,    Johnston, 10500
Maureen,   Solano,   10500
John,      Kamaru,   6500
Xie,       Chung,    6500
```

the *SUM* function, in conjunction with the GROUP BY clause, will add up all similar rows. 
So if a student has 3 rows in the enrollments, in the query above the price for each course would be summed into one. 
I can specify how I want the data ordered (ORDER BY) i.e. order by the specified column (SUM(cp.price)) and *DESC* is shorthand for *DESCENDING*, meaning the rows will be ordered from highest to lowest.

## LEFT JOIN
Most of the SQL we have seen so far has been about finding data, but the LEFT JOIN, a variant of JOIN, behaves a bit differently. When you LEFT JOIN table A to table B, you will get one row for each record in table A, rows in table B will also be returned (if they match on the join column), but if a row in Table A has no associated row in table B, then a NULL row will be returned from Table B.

Why would anyone want that?

Lets look at a practical example. 
One of our students is a notorious hacker, and he/she has realized that we determine how much a student owes by looking at the accounts. 
Therefore, if we don’t have a student record in the accounts table, we don’t know to charge the student. Genius! (How the student was able to access the database is left up to your imagination)

So our hacker has hacked the database and dropped her row from the accounts table.

```
/* I am Hacker, hear me roar/hack!!! . They will never catch me!! */
DELETE from accounts WHERE studentId = 1023;
```

So how do we foil the hackers nefarious plan to get free education (a worthy goal, just illegal). 
None of the queries so far will tell us that something is amiss.

_Show me students who are currently enrolled including those missing a row from the accounts table when they shouldn’t_

So, lets start with our regular JOIN (we need to join to the enrollments table because it is possible for a student to not have any rows in the accounts table because they are not currently enrolled in any courses). 
The *DISTINCT* is needed because we will get a single row for each student enrollment, so if they are enrolled in more than one course. DISTINCT will collapse similar results into a single row.

```
SELECT DISTINCT s.firstName, s.lastName, a.total, a.paid, a.balance, e.studentId
FROM students s
JOIN enrollments e
ON e.studentId = s.studentId
LEFT JOIN accounts a
ON s.studentId = a.studentId;

Results -----------------------------------
firstName, lastName,  total,                    paid,     balance
— — — — — — — — — — — — — — — — — — — —
…
Sarah,      Abebi,    0000004500,  0000000000,  0000000000,1022
Allison,    Hacker,   NULL,        NULL,        NULL,      1023
…
```

_Only show me the rows that are missing_

```
SELECT DISTINCT s.firstName, s.lastName, a.total, a.paid, a.balance, e.studentId
FROM students s
JOIN enrollments e
ON e.studentId = s.studentId
LEFT JOIN accounts a
ON s.studentId = a.studentId
WHERE a.total IS NULL;
Results -----------------------------------
firstName, lastName, total, paid, balance,studentId
— — — — — — — — — — — — — — — — — — — —
Allison,    Hacker,  NULL,  NULL, NULL,    1023
```

the *IS NULL* construct checks for the absence of a value (keep in mind = NULL will not work)

We have successfully thwarted Allison Hackers attempt to get free education (though considering how much we are charging who could blame her for trying)!
