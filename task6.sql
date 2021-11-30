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