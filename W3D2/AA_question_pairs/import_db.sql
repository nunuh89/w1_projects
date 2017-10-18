DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO
  users (id, fname, lname)
VALUES
  (1,'Billy', 'Smith'),
  (2,'Arthur', 'Miller'),
  (3,'Eugene', 'O''Neill');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Are we software developers yet?', 'I''ve been here for three weeks. Am I a SW Dev?', 1),
  ('A dumb question', ' What time is lunch?', 2),
  ('Sample title 3', 'Sample question3', 3),
  ('Sample title 4', ' Sample question 4', 2);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (2, NULL, 1, '12 PM.'),
  (2, 1, 2, 'Where are you going for lunch?');

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (2, 1),
  (3, 2),
  (3, 1),
  (3, 3),
  (4, 3),
  (2, 2);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (2, 1),
  (4, 3),
  (2, 2),
  (3, 1);
