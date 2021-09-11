----- UPDATE - SET -----

/* Asagidaki gibi tedarikciler adinda bir tablo olusturunuz ve vergi_no sutununu primary key yapiniz. Ayrica asagidaki verileri tabloya giriniz.
   
vergi_no NUMBER(3),
firma_ismi VARCHAR2(50),
irtibat_ismi VARCHAR2(50)
,
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Cin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

Sonrasinda asagidaki gibi urunler adinda bir baska tablo olusturunuz ve bu tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu iliskilendiriniz. Verileri giriniz.
    
ted_vergino NUMBER(3),
urun_id NUMBER(11),
urun_isim VARCHAR2(50),
musteri_isim VARCHAR2(50),

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayse Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Oz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yilmaz'); */

CREATE TABLE Tedarikciler1 (

vergi_no NUMBER(3) PRIMARY KEY,
firma_ismi VARCHAR2(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO Tedarikciler1 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO Tedarikciler1 VALUES (102, 'Huawei', 'Cin Li');
INSERT INTO Tedarikciler1 VALUES (103, 'Erikson', 'Maki Tammamen');
INSERT INTO Tedarikciler1 VALUES (104, 'Apple', 'Adam Eve');


CREATE TABLE Urunler1 (

ted_vergino NUMBER(3),
�r�n_id NUMBER(11),
�r�n_isim VARCHAR2(50),
m�steri_isim VARCHAR2(50),
CONSTRAINT Urunler_fk FOREIGN KEY (ted_vergino) REFERENCES Tedarikciler1 (vergi_no)
);

INSERT INTO Urunler1 VALUES(101, 1001,'Laptop', 'Ayse Can');
INSERT INTO Urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO Urunler1 VALUES(102, 1003,'TV', 'Ramazan Oz');
INSERT INTO Urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO Urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO Urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO Urunler1 VALUES(104, 1007,'Phone', 'Aslan Yilmaz');

SELECT * FROM Urunler1;
SELECT * FROM Tedarikciler1;

-- SYNTAX

-- UPDATE tablo_adi
-- SET Sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
-- WHERE kosul;


-- ORNEK I : vergi_no'su 101 olan tedarikcinin ismini 'LG' olarak g�ncelleyin.

UPDATE Tedarikciler1 
SET firma_ismi = 'LG'
WHERE vergi_no = 101;

SELECT * FROM Tedarikciler1;


-- ORNEK II : Tedarikciler1 tablosundaki t�m firma isimlerini 'Samsung' olarak g�ncelle.

UPDATE Tedarikciler1
SET firma_ismi = 'Samsung';


-- ORNEK III : vergi_no'su 102 olan tedarikcinin ismini 'Lenovo' ve irtibat_ismi'ni 'Ali Veli' olarak g�ncelleyeniz.

UPDATE Tedarikciler1
SET firma_ismi = 'Lenovo', irtibat_ismi = 'Ali Veli'
WHERE vergi_no = 102;


-- ORNEK IV : firma_ismi 'Samsung' olan tedarikcinin irtibat_ismi'ni 'Ayse Yilmaz' olarak g�ncelleyiniz.

UPDATE Tedarikciler1
SET irtibat_ismi = 'Ayse Yilmaz'
WHERE firma_ismi = 'Samsung';


-- ORNEK V : Urunler1 tablosundaki �r�n_id degeri 1004'ten b�y�k olanlarin �r�n_id degerlerini bir arttiriniz.


UPDATE Urunler1
SET �r�n_id = �r�n_id+1
WHERE �r�n_id>1004;

SELECT * FROM Urunler1;


-- ORNEK VI : Urunler1 tablosundaki t�m �r�nlerin �r�n_id degerini ted_vergino s�tun degeri ile toplayarak g�ncelleyiniz.

UPDATE Urunler1 
SET �r�n_id = �r�n_id + ted_vergino;


-- ORNEK VII : Urunler1 tablosundan Ali Bak'in aldigi urunun ismini, Tedarikciler1 tablosunda irtibat_ismi 'Adam Eve' olan firmanin ismini (FIRMA_ISMI) ile degistiriniz.

UPDATE Urunler1
SET �r�n_isim = (SELECT firma_ismi FROM Tedarikciler1 WHERE irtibat_ismi = 'Adam Eve') -- veya direkt 'Apple' yazilabilir.
WHERE m�steri_isim = 'Ali Bak';


-- ORNEK VIII : Laptop satin alan musterilerin ismini, Apple'in irtibat_isim'i ile degistirin.

UPDATE Urunler1
SET m�steri_isim = (SELECT irtibat_ismi FROM Tedarikciler1 WHERE firma_ismi = 'Apple')
WHERE �r�n_isim = 'Laptop';   