DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id integer NOT NULL,
  name text NOT NULL,
  sum_planned real NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO categories (id,name,sum_planned) VALUES (1,'Коммуналка',0);
INSERT INTO categories (id,name,sum_planned) VALUES (2,'Гигиена и парфюмерия',0);
INSERT INTO categories (id,name,sum_planned) VALUES (3,'Развлечения',0);
INSERT INTO categories (id,name,sum_planned) VALUES (4,'Уход за домом',0);
INSERT INTO categories (id,name,sum_planned) VALUES (5,'Долг',1);
INSERT INTO categories (id,name,sum_planned) VALUES (6,'Зарплата',0);
INSERT INTO categories (id,name,sum_planned) VALUES (7,'Транспорт',0);
INSERT INTO categories (id,name,sum_planned) VALUES (8,'Прочее',0);
INSERT INTO categories (id,name,sum_planned) VALUES (9,'Отложенные (родители)',1);
INSERT INTO categories (id,name,sum_planned) VALUES (10,'Техника',1);
DROP TABLE IF EXISTS fps;
CREATE TABLE fps (
  id integer NOT NULL,
  date_in timestamp NOT NULL,
  date_out timestamp,
  sum_total real NOT NULL,
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS incomes;
CREATE TABLE incomes (
  id integer NOT NULL,
  date timestamp NOT NULL,
  sum real NOT NULL,
  comment varchar(128),
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
  id integer NOT NULL,
  date timestamp NOT NULL,
  sum real,
  comment varchar(128),
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS pockets;
CREATE TABLE pockets (
  id integer NOT NULL,
  name varchar(64) NOT NULL, -- was text(64)
  sum real NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO pockets (id,name,sum) VALUES (1,'Долг',5);
