## **What is PostgreSQL?**

To me it is a widely used open source RDBMS. I guess it has some history of the naming, and some other database management system before postgres like COBOL, but thats not the point of why it is widely used, I find the points below to be a valid reasons behind postgres is still a widely goto RDBMS for any software engineer;

- Open Source and it is free to use.
- Cross platform compatibility
- support SQL and procedural languages like PL/pgSQL.
- supports triggers, subquries, function procedures, views.
- Suports more advanced features


Code example
```
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  department TEXT,
  hire_date DATE
);
```

Postgres is the ideal RDBMS choice for having many feature, stable and ideal for both small and large scale systems.


---

## **What is the purpose of a database schema in PostgreSQL?**

A database schema is used to resolve possible conflicts, organize data, security and much more. For example, connection between two tables whose relationship can be complex, ie many to many, one to many, or many to one - can be resolved using a intermediatay table - such problems can be seen and easily resolved by schemas in postgres. Moreover, schemas can provide a clear picture of access control, i.e I can assign perssion to users based on schema level, kind of like compartmentalization in security agencies. Another purpose of schema could be to manage nameing conflicts.


---

## **Explain the Primary Key and Foreign Key concepts in PostgreSQL.**

Primary Key, is unique, increments by 1, not null, for each row of data in a table.

```
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username TEXT NOT NULL,
  email TEXT NOT NULL
);
```

Here, user_id is the primary keym it uniquely identifies each user.


Foreign Key is the primary key of another table, that is being included in a table for relationships between tables, a reference, it can options to cascade updates and deletions.

```
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(user_id),
  order_date DATE
);
```

Here, user_id is a foreign key referencing the users table.


---


## **What is the difference between the VARCHAR and CHAR data types?**


I use VARCHAR when the length of the value vaires within a certain given limit, and CHAR is used when the length of the value is fixed, however, I have listed some differences below;

- VARCHAR uses as much space as needed, CHAR uses n characters padded with spaces if needed
- VARCHAR uses no padding, CHAR pads with spaces to match the defined length
- VARCHAR is slightly more efficient for variable length text, CHAR is slightly faster for fixed  length text
- VARCHAR is best for data with varying length, CHAR is suitable when all entires are of fixed length

VARCHAR

```

CREATE TABLE employees (
  name VARCHAR(50)
);

```

CHAR

```
CREATE TABLE codes (
  country_code CHAR(2)
);
```

---

## **Explain the purpose of the WHERE clause in a SELECT statement.**


WHERE clause is basically a condition statement for the SELECT query, it filter rows from a table based on that condition. It helps narrow down query results. It can be combined with logical operators like, `AND`, `OR`, `NOT` and also comparison operators like `=`, `>`, `<`, `LIKE`, `ILIKE`, `BETWEEN`, `IN`, `IS NULL` and even subqueries.

```
CREATE TABLE employees (
  id SERIAL,
  name TEXT,
  department TEXT,
  salary NUMERIC
);


SELECT name, salary
FROM employees
WHERE department = 'Sales' AND salary > 50000;

```