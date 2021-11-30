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