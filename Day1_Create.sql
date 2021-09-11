-- TABLO OLUSTURMA --
CREATE TABLE student 
(
id CHAR(4),
name VARCHAR(20),
age NUMBER
);

-- VERI GIRISI --
INSERT INTO student VALUES('1001','FERHAN BARIN',25);
INSERT INTO student VALUES('1002','YUNUS BARIN',18);

-- TABLODAN VERI SORGULAMA --
SELECT * FROM student;

-- TABLO SILME --
DROP TABLE student;

-- PARCALI VERI GIRISI --
INSERT INTO student(id,name) VALUES('1003','DERYA');

-- VERI TABANINIZDA URUNLER ADINDA BIR TABLO OLUSTURUN. --

-- urun_id --> number
-- urun_adi --> VARCHAR(50)
-- fiyat --> number 
-- (100,Cips,5)
-- (200,Kola,6)

DROP TABLE urunler;
CREATE TABLE urunler(

urun_id NUMBER,
urun_adi VARCHAR(50),
fiyat NUMBER
);

INSERT INTO urunler VALUES('100','Cips',5);
INSERT INTO urunler VALUES('200','Kola',6);
SELECT * FROM urunler;