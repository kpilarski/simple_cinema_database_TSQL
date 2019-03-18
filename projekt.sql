-- Sprawdzenie czy istnieje baza danych "BazaDanychKino" jest tak to usuniecie jej i stworzenie nowej
USE MASTER;
DROP DATABASE IF EXISTS BazaDanychKino;
CREATE DATABASE BazaDanychKino;
GO
USE BazaDanychKino;
GO

-- 1) Stworzenie tabeli
CREATE TABLE film (
film_id INT IDENTITY(1,1) PRIMARY KEY,
nazwa NCHAR(60) NOT NULL,
rok smallint NOT NULL CHECK (rok>=0),
jezyk NCHAR(50) NOT NULL,
czas_trwania smallint NOT NULL CHECK (czas_trwania>=0),
kraj NCHAR(50) NOT NULL,
napisy NCHAR(3) NOT NULL CHECK (napisy in ('TAK', 'NIE')),
ograniczenie_wiekowe NCHAR(4) NOT NULL CHECK (ograniczenie_wiekowe in ('16', '18', '12', 'Brak'))
);

CREATE TABLE aktor (
aktor_id INT IDENTITY(1,1) PRIMARY KEY,
imie NCHAR(50) NOT NULL,
nazwisko NCHAR(50) NOT NULL,
plec CHAR(1) NOT NULL CHECK (plec = 'M' OR plec = 'K'),
data_urodzenia DATE,
narodowosc NCHAR(50),
miejsce_urodzenia NCHAR(50),
);

CREATE TABLE rezyser (
rezyser_id INT IDENTITY(1,1) PRIMARY KEY,
imie NCHAR(50) NOT NULL,
nazwisko NCHAR(50) NOT NULL,
plec CHAR(1) NOT NULL CHECK(plec='M' OR plec='K'),
data_urodzenia DATE,
narodowsc NCHAR(50),
miejsce_urodzenia NCHAR(50),
);

CREATE TABLE rola (
aktor_id int NOT NULL,
film_id int NOT NULL,
rola NCHAR(50) NOT NULL,
CONSTRAINT rola_aktor FOREIGN KEY (aktor_id) REFERENCES aktor(aktor_id)
ON DELETE NO ACTION,
CONSTRAINT rola_film FOREIGN KEY (film_id) REFERENCES film(film_id)
ON DELETE NO ACTION
);

CREATE TABLE rezyseria_filmu (
rezyser_id int NOT NULL,
film_id int NOT NULL,
CONSTRAINT rezyseria_filmu_rezyser FOREIGN KEY (rezyser_id) REFERENCES rezyser(rezyser_id)
ON DELETE NO ACTION,
CONSTRAINT rezyseria_filmu__film FOREIGN KEY (film_id) REFERENCES film(film_id)
ON DELETE NO ACTION
);

CREATE TABLE gatunki (
gatunek_id INT IDENTITY(1,1) PRIMARY KEY,
nazwa NCHAR(40) NOT NULL UNIQUE,
);

CREATE TABLE gatunek_film (
film_id int NOT NULL,
gatunek_id int NOT NULL,
CONSTRAINT gatunek_film_film FOREIGN KEY (film_id) REFERENCES film(film_id)
ON DELETE NO ACTION,
CONSTRAINT gatunek_film_gatunki FOREIGN KEY (gatunek_id) REFERENCES gatunki(gatunek_id)
ON DELETE NO ACTION
);

CREATE TABLE sale (
sala_id INT IDENTITY(1,1) PRIMARY KEY,
nazwa_sali NCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE seanse (
seans_id INT IDENTITY(1,1) PRIMARY KEY,
film_id int NOT NULL,
sala_id int not null,
data_senasu SMALLDATETIME not null,
CONSTRAINT seanse_film FOREIGN KEY (film_id) REFERENCES film(film_id)
ON DELETE NO ACTION,
CONSTRAINT seanse_sala FOREIGN KEY (sala_id) REFERENCES sale(sala_id)
ON DELETE NO ACTION,
);

CREATE TABLE rzedy (
rzad_id INT IDENTITY(1,1) PRIMARY KEY,
rzad CHAR NOT NULL CHECK (rzad in ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N')) UNIQUE,
);

CREATE TABLE fotele (
fotel_id INT IDENTITY(1,1) PRIMARY KEY,
fotel int NOT NULL CHECK (fotel BETWEEN 1 and 20) UNIQUE,
);

CREATE TABLE miejsce (
miejsce_id INT IDENTITY(1,1) PRIMARY KEY,
sala_id int not null,
rzad_id int not null,
fotel_id int not null,
CONSTRAINT miejsce_sala FOREIGN KEY (sala_id) REFERENCES sale(sala_id)
ON DELETE NO ACTION,
CONSTRAINT miejsce_rzad_id FOREIGN KEY (rzad_id) REFERENCES rzedy(rzad_id)
ON DELETE NO ACTION,
CONSTRAINT miejsce_nr_fotela FOREIGN KEY (fotel_id) REFERENCES fotele(fotel_id)
ON DELETE NO ACTION,
);

CREATE TABLE dane_osobowe (
dane_osobowe_id INT IDENTITY(1,1) PRIMARY KEY,
imie NCHAR(50) NOT NULL,
nazwisko NCHAR(50) NOT NULL,
data_urodzenia DATE not null,
email NCHAR(50) check (email LIKE '%@%.%')
);

CREATE TABLE klienci (
klient_id INT IDENTITY(1,1) PRIMARY KEY,
dane_osobowe_id int NOT NULL,
CONSTRAINT klienci_dane_osobowe FOREIGN KEY (dane_osobowe_id)
REFERENCES dane_osobowe(dane_osobowe_id)
ON DELETE NO ACTION,
);

CREATE TABLE bilety (
bilet_id INT IDENTITY(1,1) PRIMARY KEY,
seans_id int not null,
klient_id int not null,
miejsce_id int not null,
data_zakupu SMALLDATETIME not null,
CONSTRAINT bilety_seans FOREIGN KEY (seans_id) REFERENCES seanse(seans_id)
ON DELETE NO ACTION,
CONSTRAINT bilety_klienci FOREIGN KEY (klient_id) REFERENCES klienci(klient_id)
ON DELETE NO ACTION,
CONSTRAINT bilety_miejsce FOREIGN KEY (miejsce_id) REFERENCES miejsce(miejsce_id)
ON DELETE NO ACTION, );

-- 2) Uzupełnienie tabel informacjami
INSERT INTO film (nazwa, rok, jezyk, czas_trwania, kraj, napisy, ograniczenie_wiekowe)
VALUES ('Dom, który zbudował Jack', 2018, 'angielski', 155, 'Dania', 'TAK', '18'),
('Titanic', 1997, 'angielski', 194, 'USA', 'TAK', '16'),
('Avatar', 2009,'angielski',162,'USA', 'TAK', '12'),
('Wilk z Wall Street', 2013,'USA',180,'Dania', 'TAK', '18'),
('Gladiator', 2000, 'angielski',120,'USA', 'TAK', '16'),
('Aviator', 2004, 'angielski',116,'USA', 'TAK', '12'),
('Ostatni Samuraj', 2003,'angielski',143,'USA', 'TAK', '16'),
('Suspria',2018, 'angielski', 108,'USA', 'TAK', '18'),
('Interstellar',2014, 'angielski', 155,'USA', 'TAK', '12'),
('Skazani na Shawshank', 1994, 'angielski',142,'USA', 'TAK', 'BRAK');

INSERT INTO aktor (imie, nazwisko, plec, data_urodzenia, narodowosc, miejsce_urodzenia)
VALUES ('Christian', 'Bale', 'M', '1974-01-30', 'USA', 'Haverfordwest'),
('Matthew', 'McConaughey', 'M', '1969-11-04', 'USA', 'Uvalde'),
('Leonardo', 'DiCaprio', 'M', '1974 -11-11', 'USA', 'Los Angeles'),
('Brad', 'Pitt', 'M', '1963-12-18', 'USA', 'Shawnee'),
('Naomi', 'Watts', 'K', '1968-09-28', 'Wielka Brytania', 'Shoreham'),
('Kate', 'Winslet', 'K', '1975-10-05', 'Wielka Brytania', 'Reading'),
('Russell', 'Crowe', 'M', '1964-04-07', 'Australia', 'Wellington'),
('Morgan', 'Freeman', 'M', '1937-06-01', 'USA', 'Memphis');

INSERT INTO rezyser (imie, nazwisko, plec, data_urodzenia, narodowsc, miejsce_urodzenia)
VALUES ('Steven', 'Spielberg', 'M', '1946-12-18', 'USA', 'Cincinnati'),
('David', 'Lynch', 'M', '1946-01-20', 'USA', 'Missoula'),
('Christopher', 'Nolan', 'M', '1970-07-30', 'Wielka Brytania', 'Westminster'),
('James', 'Cameron', 'M', '1954-08-16', 'Kanada', 'Kapuskasing'),
('Ridley', 'Scott', 'M', '1937-11-30', 'Wielka Brytania', 'South Shields');

INSERT INTO rola (aktor_id, film_id, rola)
VALUES (2, 9, 'Cooper'),
(2, 4, 'Mark Hanna'),
(3, 2, 'Jack Dawson'),
(3, 4, 'Jordan Belfort'),
(3, 6, 'Howard Hughes'),
(6, 2, 'Rose Bukater'),
(8, 10, 'Red');

INSERT INTO rezyseria_filmu (rezyser_id, film_id)
VALUES (3, 9),
(4, 2),
(4, 3),
(5, 5);

INSERT INTO dane_osobowe (imie, nazwisko, data_urodzenia, email)
VALUES ('Marian', 'Nowak', '1990-10-10', 'marian_nowak@gmail.com'),
('Tomasz', 'Kwiatkowski', '1980-12-14', 't_kwiatkowski@gmail.com'),
('Jan', 'Lewnadowski', '1995-12-22', 'jan_lewndowski223@gmail.com'),
('Marcin', 'Nowak', '1992-10-10', 'marcin_nowak92@gmail.com'),
('Marian', 'Kwiatkowski', '1991-10-15', 'marian_kwiatkwoski@o2.com'),
('Michał', 'Piątek', '1994-10-10', 'mpiatek@gmail.com'),
('Marcin', 'Gryza', '1992-09-10', 'maricing92@o2.com');

INSERT INTO klienci (dane_osobowe_id)
VALUES (1),
(2),
(3),
(4),
(5),
(6),
(7);

INSERT INTO gatunki (nazwa)
VALUES ('Dramat'),
('Horror'),
('Science Fiction'),
('Thriller'),
('Komedia'),
('Melodramat'),
('Dokumentalny'),
('Psychologiczny'),
('Sensacyjny'),
('Fantasy');

INSERT INTO gatunek_film (film_id, gatunek_id)
VALUES (1, 8),
(2, 6),
(3, 10),
(4, 5),
(5, 1),
(6, 1),
(7, 1),
(8, 2),
(9, 1),
(10, 3);

INSERT INTO rzedy (rzad)
VALUES ('A'),
('B'),
('C'),
('D'),
('E'),
('F'),
('G'),
('H'),
('I'),
('J'),
('K'),
('L'),
('M'),
('N');

INSERT INTO fotele (fotel)
VALUES (20),
(11),
(14),
(15),
(1),
(5),
(3),
(12),
(16),
(6),
(4),
(2),
(7),
(9),
(19),
(18);

INSERT INTO sale (nazwa_sali)
VALUES ('Toronto'),
('London'),
('Warszawa'),
('Rzym'),
('Nowy Jork'),
('Pekin'),
('Bruksela'),
('Amsterdam');

INSERT INTO miejsce (sala_id, rzad_id, fotel_id)
VALUES (1,1,1),
(2,2,2),
(3,3,3),
(4,4,5),
(5,5,4),
(6,6,7),
(7,7,6),
(1,8,8),
(2,9,9),
(3,10,10),
(4,11,11),
(5,12,12),
(6,13,13),
(7,14,14);

INSERT INTO seanse (film_id, sala_id, data_senasu)
VALUES (1,2, '2018-02-01 12:00:00'),
(2,1, '2018-02-01 12:30:00'),
(2,3, '2018-02-03 12:00:00'),
(3,2, '2018-02-04 14:30:00'),
(5,1, '2018-02-03 16:00:00'),
(4,3, '2018-02-03 17:30:00'),
(7,2, '2018-02-09 20:00:00'),
(9,4, '2018-02-04 23:30:00'),
(5,4, '2018-02-05 12:00:00'),
(2,1, '2018-02-04 20:00:00'),
(4,2, '2018-02-05 23:15:00');

INSERT INTO bilety (seans_id, klient_id, miejsce_id, data_zakupu)
VALUES (1, 4, 1, '2018-01-22 20:00:00'),
(2, 5, 2, '2018-01-24 12:00:00'),
(3, 6, 3, '2018-01-23 12:00:00'),
(4, 7, 4, '2018-01-22 23:00:00'),
(5, 1, 5, '2018-01-26 22:00:00'),
(6, 2, 6, '2018-01-23 16:00:00'),
(7, 3, 7, '2018-01-28 18:00:00'),
(8, 4, 8, '2018-01-30 20:00:00'),
(9, 5, 9, '2018-01-22 17:00:00'),
(10, 3, 10, '2018-01-25 20:00:00'),
(8, 2, 11, '2018-01-23 16:00:00'),
(8, 6, 12, '2018-01-28 18:00:00'),
(2, 1, 13, '2018-01-30 20:00:00'),
(1, 2, 14, '2018-01-22 17:00:00'),
(8, 3, 1, '2018-01-25 20:00:00'),
(11, 4, 2, '2018-01-27 20:00:00');


-- 3) Przykładowe zapytania
SELECT dane_osobowe.imie AS Imie, dane_osobowe.nazwisko AS Nazwisko, dane_osobowe.email AS 'E-mail'
FROM dane_osobowe
WHERE dane_osobowe.email like '%o2%'
ORDER BY dane_osobowe.imie ASC;
SELECT dane_osobowe.imie AS Imie, dane_osobowe.nazwisko AS Nazwisko, film.nazwa AS Film, seanse.data_senasu AS 'Data seansu'
FROM dane_osobowe
JOIN klienci ON dane_osobowe.dane_osobowe_id = klienci.dane_osobowe_id
JOIN bilety ON klienci.klient_id = bilety.klient_id
JOIN seanse ON bilety.seans_id = seanse.seans_id
JOIN film ON seanse.film_id = film.film_id
WHERE film.nazwa = 'Interstellar'
ORDER BY dane_osobowe.imie ASC;

SELECT film.nazwa AS Film, gatunki.nazwa AS Gatunek, seanse.data_senasu AS 'Data seansu'
FROM seanse
JOIN film ON seanse.film_id = film.film_id
JOIN gatunek_film ON film.film_id = gatunek_film.film_id
JOIN gatunki ON gatunek_film.gatunek_id = gatunki.gatunek_id
WHERE gatunki.nazwa = 'Dramat' or gatunki.nazwa = 'Komedia'
ORDER BY seanse.data_senasu ASC;

SELECT film.nazwa AS Film, sale.nazwa_sali AS 'Nazwa sali', gatunki.nazwa AS Gatunek, DATENAME(weekday , seanse.data_senasu) AS 'Dzien weekendu'
FROM seanse
JOIN film ON seanse.film_id = film.film_id
JOIN gatunek_film ON film.film_id = gatunek_film.film_id
JOIN gatunki ON gatunek_film.gatunek_id = gatunki.gatunek_id
JOIN sale ON seanse.sala_id = sale.sala_id
WHERE seanse.data_senasu between '2018-02-03' and '2018-02-05'
ORDER BY seanse.data_senasu ASC;

SELECT dane_osobowe.imie AS Imie, dane_osobowe.nazwisko AS Nazwisko, dane_osobowe.data_urodzenia AS 'Data urodzenia', dane_osobowe.email AS 'E-mail', count(film.nazwa) as 'Liczba seansow'
FROM dane_osobowe
JOIN klienci ON dane_osobowe.dane_osobowe_id = klienci.dane_osobowe_id
JOIN bilety ON klienci.klient_id = bilety.klient_id
JOIN seanse ON bilety.seans_id = seanse.seans_id
JOIN film ON seanse.film_id = film.film_id
GROUP BY dane_osobowe.imie, dane_osobowe.nazwisko, dane_osobowe.data_urodzenia, dane_osobowe. email
ORDER BY dane_osobowe.imie ASC;

SELECT dane_osobowe.imie AS Imie, dane_osobowe.nazwisko AS Nazwisko, film.nazwa As Film, FORMAT(seanse.data_senasu, 'MM - dd') AS 'Miesiac - Dzien', FORMAT(seanse.data_senasu, 'HH:mm') AS 'Godzina', fotele.fotel AS 'Numer fotela', rzedy.rzad AS 'Rzad'
FROM dane_osobowe
JOIN klienci ON dane_osobowe.dane_osobowe_id = klienci.dane_osobowe_id
JOIN bilety ON klienci.klient_id = bilety.klient_id
JOIN seanse ON bilety.seans_id = seanse.seans_id
JOIN film on seanse.film_id = film.film_id
JOIN miejsce ON bilety.miejsce_id = miejsce.miejsce_id
JOIN fotele ON miejsce.fotel_id = fotele.fotel_id
JOIN rzedy ON miejsce.rzad_id = rzedy.rzad_id
ORDER BY dane_osobowe.imie ASC;