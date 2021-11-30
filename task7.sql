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