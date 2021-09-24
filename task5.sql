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
SELECT surname_nm, name_nm, patronymic_nm, author_nm, 100.0 * COUNT(book.book_id) / SUM(COUNT(book.book_id)) OVER (PARTITION BY surname_nm, name_nm, patronymic_nm)
FROM LIBRARY.READER
LEFT JOIN LIBRARY.SERVICE ON reader.reader_id = service.reader_id
INNER JOIN LIBRARY.SERVICE_X_BOOK ON service.service_id = service_x_book.service_id AND service.operation_dk = (SELECT operation_dk FROM LIBRARY.type_of_operation WHERE type_of_operation.operation_nm LIKE 'Выдача книг')
INNER JOIN LIBRARY.BOOK ON book.book_id = service_x_book.book_id
INNER JOIN LIBRARY.TYPE_OF_BOOK ON book.type_id = type_of_book.type_id
GROUP BY surname_nm, name_nm, patronymic_nm, author_nm;


-- рейтинг популярности книг
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


-- рейтинг лучших библиотекарей
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