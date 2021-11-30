-- создание базы данных
DROP SCHEMA IF EXISTS LIBRARY CASCADE;

CREATE SCHEMA LIBRARY;

CREATE TABLE LIBRARY.TYPE_OF_OPERATION (
    OPERATION_DK            INTEGER             PRIMARY KEY,
    OPERATION_NM            VARCHAR(15)         NOT NULL
);

CREATE TABLE LIBRARY.WORKER (
    WORKER_ID       INTEGER         PRIMARY KEY,
    SURNAME_NM      VARCHAR(50)     NOT NULL,
    NAME_NM         VARCHAR(50)     NOT NULL,
    PATRONYMIC_NM   VARCHAR(50)     NOT NULL,
    PASSPORT_NO     INTEGER         NOT NULL,
    POSITION_TXT    VARCHAR(100)    NOT NULL,
    CARD_NO         VARCHAR(16)     NOT NULL,
    PHONE_NO        VARCHAR(15)     NOT NULL,
    ADDRESS_TXT     TEXT            NOT NULL,
    NOTE_TXT        TEXT,
    START_DT        DATE            NOT NULL,
    FINISH_DT       DATE            NOT NULL DEFAULT '9999-12-31'
);

CREATE TABLE LIBRARY.READER (
    READER_ID           INTEGER         PRIMARY KEY,
    SURNAME_NM          VARCHAR(50)     NOT NULL,
    NAME_NM             VARCHAR(50)     NOT NULL,
    PATRONYMIC_NM       VARCHAR(50)     NOT NULL,
    PHONE_NO            VARCHAR(15)     NOT NULL,
    BIRTHDAY_DT         DATE            NOT NULL,
    ADDRESS_TXT         TEXT            NOT NULL,
    NOTE_TXT            TEXT,
    REGISTRATION_DT     DATE            NOT NULL,
    PASSPORT_NO         VARCHAR(10)     NOT NULL
);

CREATE TABLE LIBRARY.SERVICE (
    SERVICE_ID              INTEGER         PRIMARY KEY,
    READER_ID               INTEGER         REFERENCES LIBRARY.READER(READER_ID),
    WORKER_ID               INTEGER         REFERENCES LIBRARY.WORKER(WORKER_ID),
    OPERATION_DK            INTEGER         REFERENCES LIBRARY.TYPE_OF_OPERATION(OPERATION_DK),
    BUILDING_NO             INTEGER         NOT NULL,
    ROOM_NO                 INTEGER         NOT NULL,
    SERVICE_DT              DATE            NOT NULL
);

CREATE TABLE LIBRARY.TYPE_OF_BOOK (
    TYPE_ID             INTEGER         PRIMARY KEY,
    TITLE_NM            VARCHAR(100)    NOT NULL,
    AUTHOR_NM           VARCHAR(100)    NOT NULL,
    PUBLISHING_NM       VARCHAR(100)    NOT NULL,
    PUBLISHING_YEAR_DT  INTEGER         NOT NULL,
    GENRE_TXT           VARCHAR(50)     NOT NULL,
    PAGE_CNT            INTEGER         NOT NULL,
    AGE_LIMIT_NO        INTEGER         NOT NULL,
    DESCRIPTION_TXT     TEXT
);

CREATE TABLE LIBRARY.BOOK (
    BOOK_ID                 INTEGER         PRIMARY KEY,
    TYPE_ID                 INTEGER         REFERENCES LIBRARY.TYPE_OF_BOOK(TYPE_ID),
    BUILDING_NO             INTEGER         NOT NULL,
    ROOM_NO                 INTEGER         NOT NULL,
    SECTION_NO              INTEGER         NOT NULL,
    BOOKCASE_NO             INTEGER         NOT NULL,
    BOOK_CONDITION_TXT      TEXT            NOT NULL,
    INCOME_DT               DATE            NOT NULL,
    COVER_TXT               TEXT            NOT NULL
);

CREATE TABLE LIBRARY.SERVICE_X_BOOK (
    BOOK_ID         INTEGER         REFERENCES LIBRARY.BOOK(BOOK_ID),
    SERVICE_ID      INTEGER         REFERENCES LIBRARY.SERVICE(SERVICE_ID)
);

CREATE TABLE LIBRARY.WISH_LIST (
    READER_ID       INTEGER         REFERENCES LIBRARY.READER(READER_ID),
    TYPE_ID         INTEGER         REFERENCES LIBRARY.TYPE_OF_BOOK(TYPE_ID),
    SERVICE_ID      INTEGER         REFERENCES LIBRARY.SERVICE(SERVICE_ID)
);

-- заполнение базы данных данными
INSERT INTO LIBRARY.TYPE_OF_OPERATION VALUES (1, 'Выдача книг');
INSERT INTO LIBRARY.TYPE_OF_OPERATION VALUES (2, 'Прием книг');
INSERT INTO LIBRARY.TYPE_OF_OPERATION VALUES (3, 'Запись в вишлист');

INSERT INTO LIBRARY.READER VALUES (1, 'Никитина', 'Полина', 'Владимировна', '+79227479110', '2001-01-21', 'Первомайская 28а', NULL, '2021-09-22', '9999617973');
INSERT INTO LIBRARY.READER VALUES (2, 'Позднякова', 'Алиса', 'Алексеевна', '+79853069975', '2002-08-20', 'Первомайская 28а', NULL, '2021-09-22', '9999780245');
INSERT INTO LIBRARY.READER VALUES (3, 'Софронова', 'Ольга', 'Игоревна', '+79776120522', '2001-02-02', 'Первомайская 28а', NULL, '2021-09-23', '9999472815');
INSERT INTO LIBRARY.READER VALUES (4, 'Мягков', 'Данила', 'Александрович', '+79292740955', '2001-10-09', 'Ленинские горы 1в', NULL, '2021-09-24', '9999732980');
INSERT INTO LIBRARY.READER VALUES (5, 'Михайлова', 'Ирина', 'Валерьевна', '+79320180708', '1976-02-16', 'Строительная 16', NULL, '2021-10-03', '9999826498');
INSERT INTO LIBRARY.READER VALUES (6, 'Манаков', 'Данила', 'Дмитриевич', '+79152366710', '2001-07-16', 'Первомайская 32', NULL, '2021-10-03', '9999293618');
INSERT INTO LIBRARY.READER VALUES (7, 'Санникова', 'Злата', 'Антоновна', '+79225634864', '2001-05-03', 'Монтажников 32', NULL, '2016-09-01', '9999735407');
INSERT INTO LIBRARY.READER VALUES (8, 'Полутина', 'Марина', 'Сергеевна', '+79227337465', '2001-07-29', 'Дзержинского 17', NULL, '2016-09-02', '9999127354');
INSERT INTO LIBRARY.READER VALUES (9, 'Перетокин', 'Дмитрий', 'Николаевич', '+79328465101', '2001-02-12', 'Гайдара 16', NULL, '2016-09-10', '9999386145');
INSERT INTO LIBRARY.READER VALUES (10, 'Суслова', 'Елизавета', 'Алексеевна', '+79236147641', '2001-06-04', 'Иртяшская 33', NULL, '2016-09-01', '9999163984');

INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (1, 'Ритуалы плавания', 'Уильям Голдинг', 'АСТ', '2019', 'Роман', 320, 12, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (2, 'Смерть в душе', 'Жан Поль Сартр', 'АСТ', '2018', 'Роман', 448, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (3, 'Глаза голубой собаки', 'Габриэль Гарсиа Маркес', 'АСТ', '2020', 'Роман', 160, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (4, 'Любовь во время чумы', 'Габриэль Гарсиа Маркес', 'АСТ', '2021', 'Роман', 544, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (5, 'Колыбель для кошки', 'Курт Воннегут', 'АСТ', '2018', 'Роман', 282, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (6, 'Страх и отвращение в Лас-Вегасе', 'Хантер С. Томпсон', 'АСТ', '2020', 'Роман', 318, 18, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (7, 'Сказки старого Вильнюса', 'Макс Фрай', 'АСТ', '2019', 'Городское фэнтези', 320, 18, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (8, 'Ключ из желтого металла', 'Макс Фрай', 'АСТ', '2019', 'Роман', 416, 18, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (9, 'Мой Рагнарёк. Рождественская сказка', 'Макс Фрай', 'АСТ', '2018', 'Юмористическое фэнтези', 448, 18, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (10, 'Оно', 'Стивен Кинг', 'АСТ', '2017', 'Роман', 1245, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (11, 'Имя розы', 'Умберто Эко', 'АСТ', '2021', 'Роман', 672, 12, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (12, 'Математические основы машинного обучения и прогнозирования', 'Владимир Вячеславович Вьюгин', 'МЦНМО', '2018', 'Научная литература', 384, 0, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (13, 'Япония. История и культура', 'Нэнси Сталкер', 'Альпина нон-фикшн', '2021', 'Научная литература', 584, 12, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (14, 'Заводной апельсин', 'Энтони Бёрджесс', 'АСТ', '2020', 'Роман', 252, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (15, '1984', 'Джордж Оруэлл', 'АСТ', '2020', 'Роман', 318, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (16, 'Бойня №5', 'Курт Воннегут', 'АСТ', '2020', 'Роман', 221, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (17, 'О дивный новый мир', 'Олдос Хаксли', 'АСТ', '2019', 'Роман', 350, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (18, 'Тринадцатая сказка', 'Диана Сеттерфилд', 'АЗБУКА', '2017', 'Роман', 448, 16, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (19, 'Американские боги', 'Нил Гейман', 'АСТ', '2020', 'Роман', 221, 18, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (20, 'Американские боги', 'Нил Гейман', 'АСТ', '2018', 'Роман', 221, 18, NULL);
INSERT INTO LIBRARY.TYPE_OF_BOOK VALUES (21, 'Тайна семи циферблатов', 'Агата Кристи', 'Эксмо', '2020', 'Детектив', 352, 16, NULL);

INSERT INTO LIBRARY.WORKER VALUES (1, 'Фомин', 'Сергей', 'Александрович', '6723451278', 'Главный библиотекарь', '2200240142455457', '+79232201147', 'Ленина 57', NULL, '2015-09-01');
INSERT INTO LIBRARY.WORKER VALUES (2, 'Тихонова', 'Анна', 'Анатольевна', '3423580978', 'Библиотекарь', '5678142534580983', '+79542586288', 'Победы 27', NULL, '2015-09-01');
INSERT INTO LIBRARY.WORKER VALUES (3, 'Лебедев', 'Константин', 'Николаевич', '3267459866', 'Библиотекарь', '3498123487630581', '+79228739526', 'Монтажников 5', NULL, '2016-08-20');
INSERT INTO LIBRARY.WORKER VALUES (4, 'Зайцева', 'Екатерина', 'Владимировна', '3487127756', 'Библиотекарь', '4792641730284532', '+79667285140', 'Гайдара 22', NULL, '2018-02-02');
INSERT INTO LIBRARY.WORKER VALUES (5, 'Мишина', 'Елена', 'Владимировна', '4556348756', 'Библиотекарь', '4728411360996356', '+79446567243', 'Дзержинского 35', NULL, '2015-09-01', '2021-09-01');
INSERT INTO LIBRARY.WORKER VALUES (6, 'Ломас', 'Олег', 'Константинович', '4576123494', 'Редактор', '6398102554286491', '+79548623165', 'Свердлова 34', NULL, '2015-09-01');
INSERT INTO LIBRARY.WORKER VALUES (7, 'Домбровская', 'Марина', 'Николаевна', '5602571647', 'Архивист', '5927344900784575', '+79431265765', 'Уральская 10', NULL, '2015-09-01');
INSERT INTO LIBRARY.WORKER VALUES (8, 'Дятлова', 'Ирина', 'Даниловна', '4793581448', 'Научный сотрудник', '1753892597687345', '+79327641549', 'Пушкина 6', NULL, '2018-09-01');
INSERT INTO LIBRARY.WORKER VALUES (9, 'Гурин', 'Дмитрий', 'Петрович', '4095872567', 'Охранник', '5925479815765354', '+79028456221', 'Луначарского 7', NULL, '2015-09-01');
INSERT INTO LIBRARY.WORKER VALUES (10, 'Петрова', 'Нина', 'Дмитриевна', '4824655286', 'Уборщик', '4981387405826445', '+79826921523', 'Гайдара 16', NULL, '2015-09-01');

INSERT INTO LIBRARY.BOOK VALUES (1, 1, 1, 1, 1, 1, 'Хорошее', '2019-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (2, 2, 1, 1, 1, 1, 'Хорошее', '2018-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (3, 3, 1, 1, 1, 1, 'Хорошее', '2020-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (4, 4, 1, 1, 1, 1, 'Хорошее', '2021-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (5, 5, 1, 1, 1, 1, 'Хорошее', '2018-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (6, 6, 1, 1, 1, 1, 'Хорошее', '2020-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (7, 7, 1, 1, 1, 1, 'Хорошее', '2019-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (8, 8, 1, 1, 1, 1, 'Хорошее', '2019-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (9, 9, 1, 1, 1, 1, 'Хорошее', '2018-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (10, 10, 1, 1, 1, 1, 'Среднее', '2017-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (11, 11, 1, 1, 1, 1, 'Хорошее', '2021-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (12, 12, 1, 2, 1, 2, 'Хорошее', '2018-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (13, 13, 1, 2, 2, 3, 'Хорошее', '2021-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (14, 14, 1, 1, 1, 2, 'Хорошее', '2020-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (15, 15, 1, 1, 1, 2, 'Хорошее', '2020-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (16, 16, 1, 1, 1, 2, 'Хорошее', '2020-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (17, 17, 1, 1, 1, 2, 'Отличное', '2019-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (18, 18, 1, 1, 1, 2, 'Среднее', '2017-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (19, 19, 1, 1, 1, 2, 'Хорошее', '2020-09-01', 'Твердая');
INSERT INTO LIBRARY.BOOK VALUES (20, 20, 1, 1, 1, 2, 'Плохое', '2018-09-01', 'Мягкая');
INSERT INTO LIBRARY.BOOK VALUES (21, 21, 1, 1, 1, 2, 'Среднее', '2020-09-01', 'Мягкая');

INSERT INTO LIBRARY.SERVICE VALUES (3, 2, 1, 1, 1, 1, '2021-09-21');
INSERT INTO LIBRARY.SERVICE VALUES (1, 1, 1, 1, 1, 1, '2021-09-23');
INSERT INTO LIBRARY.SERVICE VALUES (2, 1, 1, 3, 1, 1, '2021-09-23');
INSERT INTO LIBRARY.SERVICE VALUES (4, 9, 3, 1, 1, 1, '2021-08-20');
INSERT INTO LIBRARY.SERVICE VALUES (5, 9, 2, 2, 1, 1, '2021-09-01');
INSERT INTO LIBRARY.SERVICE VALUES (6, 4, 1, 1, 1, 1, '2021-08-28');
INSERT INTO LIBRARY.SERVICE VALUES (7, 4, 3, 1, 1, 1, '2021-08-28');
INSERT INTO LIBRARY.SERVICE VALUES (8, 4, 2, 2, 1, 1, '2021-09-23');
INSERT INTO LIBRARY.SERVICE VALUES (9, 4, 2, 1, 1, 1, '2021-09-23');
INSERT INTO LIBRARY.SERVICE VALUES (10, 7, 1, 3, 1, 1, '2016-09-23');
INSERT INTO LIBRARY.SERVICE VALUES (11, 4, 1, 1, 1, 1, '2021-08-28');

INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (19, 3);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (1, 1);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (12, 1);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (13, 1);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (2, 4);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (3, 4);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (4, 4);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (2, 5);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (3, 5);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (4, 5);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (5, 6);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (10, 6);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (5, 8);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (10, 8);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (2, 9);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (4, 9);
INSERT INTO LIBRARY.SERVICE_X_BOOK VALUES (4,11);

INSERT INTO LIBRARY.WISH_LIST VALUES (1, 19, 2);
INSERT INTO LIBRARY.WISH_LIST VALUES (4, 2, 7);
INSERT INTO LIBRARY.WISH_LIST VALUES (4, 4, 7);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 1, 10);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 2, 10);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 3, 10);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 4, 10);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 5, 10);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 6, 10);
INSERT INTO LIBRARY.WISH_LIST VALUES (7, 7, 10);

-- запросы
-- люди, у которых на руках находятся книги
SELECT surname_nm, name_nm, patronymic_nm, COUNT(book_id)
FROM LIBRARY.READER
INNER JOIN (SELECT reader_id, book_id
            FROM LIBRARY.SERVICE
            INNER JOIN LIBRARY.SERVICE_X_BOOK
            ON service.service_id = service_x_book.service_id AND service.operation_dk = (SELECT operation_dk FROM LIBRARY.type_of_operation WHERE type_of_operation.operation_nm LIKE 'Выдача книг')
            EXCEPT
            SELECT reader_id, book_id
            FROM LIBRARY.SERVICE
            INNER JOIN LIBRARY.SERVICE_X_BOOK
            ON service.service_id = service_x_book.service_id AND service.operation_dk = (SELECT operation_dk FROM LIBRARY.type_of_operation WHERE type_of_operation.operation_nm LIKE 'Прием книг')) AS BOOKS_ON_HANDS
ON reader.reader_id = BOOKS_ON_HANDS.reader_id
GROUP BY surname_nm, name_nm, patronymic_nm
ORDER BY COUNT(book_id) DESC ;


-- любимый автор читателя
SELECT surname_nm, name_nm, patronymic_nm, author_nm, 100.0 * COUNT(book.book_id) / SUM(COUNT(book.book_id)) OVER (PARTITION BY surname_nm, name_nm, patronymic_nm) AS author_percent
FROM LIBRARY.READER
LEFT JOIN LIBRARY.SERVICE ON reader.reader_id = service.reader_id
INNER JOIN LIBRARY.SERVICE_X_BOOK ON service.service_id = service_x_book.service_id AND service.operation_dk = (SELECT operation_dk FROM LIBRARY.type_of_operation WHERE type_of_operation.operation_nm LIKE 'Выдача книг')
INNER JOIN LIBRARY.BOOK ON book.book_id = service_x_book.book_id
INNER JOIN LIBRARY.TYPE_OF_BOOK ON book.type_id = type_of_book.type_id
GROUP BY surname_nm, name_nm, patronymic_nm, author_nm;


-- самая желаемая книга(то есть книга, которая является наиболее востребованной и желаемой)
SELECT title_nm, author_nm
FROM (SELECT type_id, COUNT(service_id) AS count
      FROM LIBRARY.WISH_LIST
      GROUP BY type_id
      UNION
      SELECT type_id, COUNT(service_id) / 2.0
      FROM LIBRARY.BOOK
      INNER JOIN LIBRARY.SERVICE_X_BOOK
      ON book.book_id = service_x_book.book_id
      GROUP BY type_id) AS TYPE_FAMOUS
RIGHT JOIN LIBRARY.TYPE_OF_BOOK
ON TYPE_FAMOUS.type_id = type_of_book.type_id
GROUP BY title_nm, author_nm
ORDER BY SUM(count) DESC NULLS LAST;


-- лучший сотрудник библиотеки(в чьи смены берут больше всего книг)
SELECT surname_nm, name_nm, patronymic_nm
FROM LIBRARY.WORKER
INNER JOIN LIBRARY.SERVICE ON service.worker_id = worker.worker_id
INNER JOIN LIBRARY.SERVICE_X_BOOK ON service.service_id = service_x_book.service_id AND service.operation_dk = (SELECT operation_dk FROM LIBRARY.type_of_operation WHERE type_of_operation.operation_nm LIKE 'Выдача книг')
GROUP BY worker.worker_id
ORDER BY COUNT(book_id) DESC;


-- доля книг автора среди книг библиотеки
SELECT author_nm, 100.0 * COUNT(BOOK_ID) / (SELECT COUNT(book_id) FROM LIBRARY.BOOK) AS AUTHOR_PERCENT
FROM LIBRARY.TYPE_OF_BOOK
INNER JOIN LIBRARY.BOOK
ON type_of_book.type_id = book.type_id
GROUP BY author_nm
ORDER BY AUTHOR_PERCENT DESC;


-- Пример INSERT: добавление нового читателя библиотеки.
INSERT
INTO LIBRARY.READER (reader_id, surname_nm, name_nm, patronymic_nm, phone_no, birthday_dt, address_txt, registration_dt, passport_no)
VALUES (11, 'Иванов', 'Иван', 'Иванович', '+7325434105', '1996-07-23', 'Лермонтова 5', '2021-09-25', '4265132632');


-- Пример SELECT: сколько книг в листе желаний у читателя номер 7
SELECT COUNT(type_id)
FROM LIBRARY.WISH_LIST
WHERE reader_id = 7;


-- Пример UPDATE: Иванов Иван Иванович сменил номер телефона
UPDATE LIBRARY.READER
SET PHONE_NO = '+79325434105'
WHERE surname_nm = 'Иванов' AND name_nm = 'Иван' AND patronymic_nm = 'Иванович';


-- Пример DELETE: Иванов Иван Иванович больше не будет читателем библиотеки
DELETE FROM LIBRARY.READER
WHERE surname_nm = 'Иванов' AND name_nm = 'Иван' AND patronymic_nm = 'Иванович';


-- создание представлений с маскировкой данных
CREATE OR REPLACE VIEW WORKER_INFO_VIEW AS
    SELECT surname_nm,
           name_nm,
           patronymic_nm,
           regexp_replace(passport_no::text, '\d', '*', 'g') AS passport_no,
           position_txt,
           regexp_replace(card_no::text, '............', '************') AS card_no,
           regexp_replace(phone_no::text, '.........', '+7*******') AS phone_no,
           address_txt,
           note_txt
    FROM LIBRARY.WORKER;

SELECT * FROM WORKER_INFO_VIEW;


CREATE OR REPLACE VIEW READER_INFO_VIEW AS
    SELECT surname_nm,
           name_nm,
           patronymic_nm,
           regexp_replace(phone_no::text, '.........', '+7*******') AS phone_no,
           birthday_dt,
           regexp_replace(address_txt::text, '.', '*', 'g') AS adress,
           note_txt,
           registration_dt,
           regexp_replace(passport_no::text, '.......', '*******') AS passport
    FROM LIBRARY.READER;

SELECT * FROM READER_INFO_VIEW;


CREATE OR REPLACE VIEW TYPE_OF_BOOKS_VIEW AS
    SELECT DISTINCT title_nm, author_nm, genre_txt, age_limit_no
    FROM LIBRARY.TYPE_OF_BOOK
    ORDER BY author_nm, title_nm;

SELECT * FROM TYPE_OF_BOOKS_VIEW;


CREATE OR REPLACE VIEW TYPE_INFO_VIEW AS
    SELECT operation_nm, building_no, room_no, service_dt
    FROM LIBRARY.SERVICE
    INNER JOIN LIBRARY.TYPE_OF_OPERATION
    ON service.operation_dk = type_of_operation.operation_dk
    ORDER BY service_dt DESC;

SELECT * FROM TYPE_INFO_VIEW;


CREATE OR REPLACE VIEW SERVICES_INFO_VIEW AS
    SELECT service_dt,
           operation_nm,
           worker.surname_nm AS worker_surname,
           worker.name_nm AS worker_name,
           worker.patronymic_nm AS worker_patronymic,
           reader.surname_nm AS reader_surname,
           reader.name_nm AS reader_name,
           reader.patronymic_nm AS reader_patronymic
    FROM LIBRARY.SERVICE
    INNER JOIN LIBRARY.READER ON reader.reader_id = service.reader_id
    INNER JOIN LIBRARY.WORKER ON service.worker_id = worker.worker_id
    INNER JOIN LIBRARY.TYPE_OF_OPERATION ON service.operation_dk = type_of_operation.operation_dk
    ORDER BY service_dt DESC;

SELECT * FROM SERVICES_INFO_VIEW;


CREATE OR REPLACE VIEW WISH_LIST_VIEW AS
    SELECT title_nm, author_nm, publishing_nm, publishing_year_dt, surname_nm, name_nm, patronymic_nm
    FROM LIBRARY.WISH_LIST
    INNER JOIN LIBRARY.TYPE_OF_BOOK ON wish_list.type_id = type_of_book.type_id
    INNER JOIN LIBRARY.READER ON wish_list.reader_id = reader.reader_id
    INNER JOIN LIBRARY.SERVICE ON wish_list.service_id = service.service_id
    ORDER BY service_dt ASC;

SELECT * FROM WISH_LIST_VIEW;


CREATE OR REPLACE VIEW COUNT_OF_BOOKS_IN_SERVICE_VIEW AS
    SELECT service_dt, COUNT(book_id) AS count_of_books
    FROM LIBRARY.SERVICE_X_BOOK
    INNER JOIN LIBRARY.SERVICE ON service_x_book.service_id = service.service_id
    GROUP BY service.service_id
    ORDER BY count_of_books DESC;

SELECT * FROM COUNT_OF_BOOKS_IN_SERVICE_VIEW;


CREATE OR REPLACE VIEW BOOK_INFO_VIEW AS
    SELECT DISTINCT title_nm, author_nm, building_no, room_no, bookcase_no, section_no, book_condition_txt
    FROM LIBRARY.BOOK
    INNER JOIN LIBRARY.TYPE_OF_BOOK ON book.type_id = type_of_book.type_id
    ORDER BY author_nm, title_nm DESC;

SELECT * FROM BOOK_INFO_VIEW;


-- Любимый автор читателя
CREATE OR REPLACE VIEW AUTHOR_RATING AS
    SELECT surname_nm, name_nm, patronymic_nm, author_nm, 100.0 * COUNT(book.book_id) / SUM(COUNT(book.book_id)) OVER (PARTITION BY surname_nm, name_nm, patronymic_nm) AS author_percent
    FROM LIBRARY.READER
    INNER JOIN LIBRARY.SERVICE ON reader.reader_id = service.reader_id
    INNER JOIN LIBRARY.SERVICE_X_BOOK ON service.service_id = service_x_book.service_id AND service.operation_dk = (SELECT operation_dk FROM LIBRARY.type_of_operation WHERE type_of_operation.operation_nm LIKE 'Выдача книг')
    INNER JOIN LIBRARY.BOOK ON book.book_id = service_x_book.book_id
    INNER JOIN LIBRARY.TYPE_OF_BOOK ON book.type_id = type_of_book.type_id
    GROUP BY surname_nm, name_nm, patronymic_nm, author_nm;

CREATE OR REPLACE VIEW FAVORITE_AUTHORS AS
    SELECT surname_nm, name_nm, patronymic_nm, author_nm AS favorite_author
    FROM AUTHOR_RATING
    WHERE author_percent IN (SELECT MAX(author_percent) OVER (PARTITION BY surname_nm, name_nm, patronymic_nm) FROM AUTHOR_RATING);

SELECT * FROM FAVORITE_AUTHORS;

-- Порекомендуем читателю книги, которые он не читал, написанные его любимым автором
CREATE OR REPLACE VIEW NOT_READ_BOOKS AS
    SELECT book_id, reader_id, type_id
    FROM LIBRARY.READER
    CROSS JOIN LIBRARY.BOOK
    EXCEPT
    SELECT book.book_id, reader.reader_id, type_id
    FROM LIBRARY.BOOK
    LEFT JOIN LIBRARY.SERVICE_X_BOOK ON book.book_id = service_x_book.book_id
    LEFT JOIN LIBRARY.SERVICE ON service_x_book.service_id = service.service_id
    LEFT JOIN LIBRARY.READER ON service.reader_id = reader.reader_id;

CREATE OR REPLACE VIEW RECOMMENDED_BOOKS AS
    SELECT FAVORITE_AUTHORS.surname_nm, FAVORITE_AUTHORS.name_nm, FAVORITE_AUTHORS.patronymic_nm, title_nm, author_nm
    FROM NOT_READ_BOOKS
    INNER JOIN LIBRARY.READER ON READER.reader_id = NOT_READ_BOOKS.reader_id
    INNER JOIN LIBRARY.TYPE_OF_BOOK ON type_of_book.type_id = NOT_READ_BOOKS.type_id
    INNER JOIN FAVORITE_AUTHORS ON FAVORITE_AUTHORS.surname_nm = reader.surname_nm AND FAVORITE_AUTHORS.name_nm = reader.name_nm AND FAVORITE_AUTHORS.patronymic_nm = reader.patronymic_nm
    WHERE favorite_author = author_nm
    ORDER BY surname_nm, name_nm, patronymic_nm, title_nm;

SELECT * FROM RECOMMENDED_BOOKS;


