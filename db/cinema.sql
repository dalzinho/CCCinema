DROP TABLE customers CASCADE;
DROP TABLE films CASCADE;
DROP TABLE tickets;

CREATE TABLE customers (
  customer_id SERIAL4 primary key,
  name VARCHAR(255),
  funds INT4 CHECK(funds >= 0)

);

CREATE TABLE films (
  film_id SERIAL4 primary key,
  title VARCHAR(255),
  price INT2,
  remaining INT2

);

CREATE TABLE tickets (
  ticket_id SERIAL4 primary key,
  customer_id INT4 references customers(customer_id) ON DELETE CASCADE,
  film_id INT4 references films(film_id) ON DELETE CASCADE,
  showtime time not null


);