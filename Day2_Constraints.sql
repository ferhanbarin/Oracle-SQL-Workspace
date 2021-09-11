/*======================= CONSTRAINTS - KISITLAMALAR ======================================
    NOT NULL - Bir sütunun  NULL icermemesini garanti eder.
    UNIQUE - Bir sütundaki tüm degerlerin BENZERSIZ olmasini garanti eder.
    PRIMARY KEY - Bir sütunun NULL icermemesini ve sütundaki verilerin BENZERSIZ olmasini garanti eder.(NOT NULL ve UNIQUE birlesimi gibi)             
    FOREIGN KEY - Baska bir tablodaki Primary Key'i referans göstermek icin kullanilir.  Böylelikle, tablolar arasinda iliski kurulmus olur.            
    CHECK - Bir sütundaki tüm verilerin belirlenen özel bir sarti saglamasini garanti eder.
    Soldan tablo silerken tablonun kapali olmasi lazim. */
    
    
-- ORNEK I NOT NULL --
-- Ogrenciler tablosu olusturalim ve ID field'ini bos birakilamaz yapalim.

CREATE TABLE Ogrenciler (
id char(4) NOT NULL,
isim varchar(50),
not_ort number(4,2), -- 98,55
kayit_tarihi date 
);

INSERT INTO Ogrenciler VALUES('1234','Hasan',75.25,'14-01-2020');
INSERT INTO Ogrenciler VALUES('1234','Ayse',null,null);
INSERT INTO Ogrenciler (id,isim) VALUES('3456','Fatma');
INSERT INTO Ogrenciler VALUES (null,'Osman',45.25,'5-01-2020'); -- Error report - ORA-01400: cannot insert NULL into ("HR"."OGRENCILER"."ID")

SELECT * FROM Ogrenciler;

-- ORNEK II UNIQUE
-- Tedarikciler olusturalim id unique olsun.

CREATE TABLE Tedarikciler (
id char(4) UNIQUE,
isim varchar(50),
adres varchar(100),
tarih date
);

INSERT INTO Tedarikciler VALUES ('1234','Ayse','Mehmet Mah. Izmir','10-11-2020');  
INSERT INTO Tedarikciler VALUES ('1234','Fatma','Veli Mah. Istanbul','5-11-2020'); -- Error report - ORA-00001: unique constraint (HR.SYS_C007000) violated
INSERT INTO Tedarikciler VALUES (null,'Cem','Zeki Mah. Denizli','5-11-1997'); 
INSERT INTO Tedarikciler VALUES (null,'Can','Süvari Mah. Mus','5-11-1998'); 

-- UNIQUE Constraint tekrara izin vermez ancak istediginiz kadar null girebilirsiniz.   
SELECT * FROM Tedarikciler;

-- ORNEK III Primary Key
CREATE TABLE Personel (
id char(5) PRIMARY KEY,
isim varchar(50) UNIQUE,
maas NUMBER(5) NOT NULL,
ise_baslama date
);

INSERT INTO Personel VALUES('10001','Ahmet Aslan',7000,'13-04-2018');
INSERT INTO Personel VALUES('10001','Mehmet Yilmaz',12000,'14-04-18'); -- Error report - ORA-00001: unique constraint (HR.SYS_C007005) violated
INSERT INTO Personel VALUES('10003','',5000,'14-04-18');
INSERT INTO Personel VALUES('10004','Veli Han',5000,'14-04-18');
INSERT INTO Personel VALUES('10005','Ahmet Aslan',5000,'14-04-18'); -- Error report - ORA-00001: unique constraint (HR.SYS_C007006) violated
INSERT INTO Personel VALUES('NULL','Canan Yas',NULL,'12-04-19'); -- Error report - ORA-01400: cannot insert NULL into ("HR"."PERSONEL"."MAAS") - null olamaz.

SELECT * FROM Personel;


-- Ogrenciler3 tablosu olusturalim ve ogrenci_id'yi PRIMARY KEY yapalim.
CREATE TABLE Ogrenciler3 (
ogrenci_id char(4) PRIMARY KEY,
Isim_soyisim varchar2(50),
not_ort number(5,2), -- 100,00
kayit_tarihi date -- 14-01-2021
);

INSERT INTO Ogrenciler3 VALUES ('1234','Hasan Yaman',75.70,'14-01-2020');
INSERT INTO Ogrenciler3 VALUES (null,'Veli Yaman',85.70,'14-01-2020'); -- id null olamaz.
INSERT INTO Ogrenciler3 VALUES ('1234','Ali Can',55.70,'14-06-2020'); -- id benzersiz olmali, daha önce verilen id kullanilamaz.
INSERT INTO Ogrenciler3 (isim_soyisim) VALUES ('Veli Cem'); -- id vermeden baska seyler vermeye gecemezsin, default null atar, buda primary'ye uymaz.
INSERT INTO Ogrenciler3 (ogrenci_id) VALUES ('5687');

SELECT * FROM Ogrenciler3;

-- Primary Key Alternatif Yöntem --
-- Bu yöntemde kisitlamaya istedigimiz ismi atayabiliriz.

CREATE TABLE Calisanlar (
id char(5), -- Primary Key
isim varchar(50) UNIQUE,
maas number(5) NOT NULL,
CONSTRAINT id_primary PRIMARY KEY(id)
);

INSERT INTO Calisanlar VALUES('10001','Ahmet Aslan',7000);
INSERT INTO Calisanlar VALUES('10002','Mehmet Yilmaz',12000);
INSERT INTO Calisanlar VALUES('10003','Can',5000);

-- Bir tabloya data eklerken constraint'lere dikkat edilmelidir.

-- ORNEK IV Foreign Key

CREATE TABLE Adresler (
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(15),
CONSTRAINT id_foreign FOREIGN KEY(adres_id) REFERENCES Calisanlar(id)
);

INSERT INTO Adresler VALUES('10001','Mutlu Sok.','40.Cad.','IST');
INSERT INTO Adresler VALUES('10001','Can Sok.','50.Cad.','Ankara');
INSERT INTO Adresler VALUES('10002','Aga Sok.','30.Cad.','Antep');
INSERT INTO Adresler VALUES('','Aga Sok','30.Cad.','Antep');
INSERT INTO Adresler VALUES('','Aga Sok','30.Cad.','Antep');

INSERT INTO Adresler VALUES('10004','Gel Sok.','60.Cad.','Van'); -- Parent'te olmayan id'li veri giremeyiz.

SELECT * FROM Calisanlar; -- Parent
SELECT * FROM Adresler; -- Child

DROP TABLE Calisanlar; -- Child silinmeden parent silinmez.
DROP TABLE Adresler;


-- Ogrenciler5 tablosunu olusturun ve id, isim hanelerinin birlesimini PRIMARY KEY yapin.
CREATE TABLE Ogrenciler5 (
id char(4),
isim varchar(20),
not_ort number(5,2),
kayit_tarihi date,
CONSTRAINT Ogrenciler5_primary PRIMARY KEY(id,isim)
);

INSERT INTO Ogrenciler5 VALUES (null,'Veli Cem',90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
INSERT INTO Ogrenciler5 VALUES (1234,null,90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
INSERT INTO Ogrenciler5 VALUES (1234,'Ali Can',90.6,'15-05-2019'); -- PK = 1234 Ali Can
INSERT INTO Ogrenciler5 VALUES (1234,'Veli Cem',90.6,'15-05-2019'); -- PK = 1234 Veli Cem
INSERT INTO Ogrenciler5 VALUES (1234,'Oli Can',90.6,'15-05-2019'); -- PK = 1234 Oli Can

SELECT * FROM Ogrenciler5;


--"tedarikciler4" isimli bir Tablo olusturun. Icinde "tedarikci_id", "tedarikci_isim", "iletisim_isim" field’lari olsun.
--"tedarikci_id" ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
--"urunler2" isminde baska bir tablo olusturun.Icinde “tedarikci_id” ve "urun_id" fieldlari olsun.
--"tedarikci_id" ve “urun_id” field'larini birlestirerek Foreign Key olusturun.

CREATE TABLE Tedarikciler4 (
tedarikci_id char(4),
tedarikci_isim varchar(20),
iletisim_ismi varchar(20),
CONSTRAINT Tedarikciler4_pk PRIMARY KEY(tedarikci_id, tedarikci_isim) -- char + varchar
);

CREATE TABLE Urunler2 (
tedarikci_id char(4),
urun_id varchar(5),
-- yas number,
CONSTRAINT Urunler2_fk FOREIGN KEY(tedarikci_id, urun_id) REFERENCES Tedarikciler4
);

-------------------------------------------------------------------------------

CREATE TABLE Sehirler2 (	
alan_kodu CHAR(3),
isim VARCHAR2(50),
nufus NUMBER(8,0) CHECK (nufus>1000)
);

INSERT INTO Sehirler2 VALUES ('312','Ankara',5750000);
INSERT INTO Sehirler2 VALUES ('232','Izmir',375); -- Error report - ORA-02290: check constraint (HR.SYS_C007017) violated
INSERT INTO Sehirler2 VALUES ('232','Izmir',3750000);
INSERT INTO Sehirler2 VALUES ('436','Maras',null);