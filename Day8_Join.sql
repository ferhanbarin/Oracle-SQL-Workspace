/* ============================== JOIN ÝSLEMLERÝ ===============================
    Foreign Key id'si ortaklari yanyana yaziyordu bu birkac tablodan istenilen sütunlari alir birlestirir. set istenilen sütunlarý tek sütunda birlestirir.
    Set Operatorleri (Union,Intersect,Minus) farkli tablolardaki sutunlari birlestirmek için de kullanilir.
    Join islemleri ise farkli Tablolari birlestirmek icin kullanilir. Diger bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo olusturmak icin kullanilabilir.   
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir özelliktir. Cünkü Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek icin JOIN islemleri kullanilabilir.
    ORACLE SQL'de 4 Cesit Join islemi kullanilabilmektedir.
    1) FULL JOIN:  Tablodaki tum sonuclari gosterir.
    2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir.
    3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir.
    4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.
=============================================================================== */

CREATE TABLE Sirketler (

sirket_id NUMBER(9),
sirket_isim VARCHAR2(20)
);
    
INSERT INTO Sirketler VALUES(100, 'Toyota');
INSERT INTO Sirketler VALUES(101, 'Honda');
INSERT INTO Sirketler VALUES(102, 'Ford');
INSERT INTO Sirketler VALUES(103, 'Hyundai');

CREATE TABLE Siparisler (
    
siparis_id NUMBER(9),
sirket_id NUMBER(9),
siparis_tarihi DATE
);

INSERT INTO Siparisler VALUES(11, 101, '17-04-2020');
INSERT INTO Siparisler VALUES(22, 102, '18-04-2020');
INSERT INTO Siparisler VALUES(33, 103, '19-04-2020');
INSERT INTO Siparisler VALUES(44, 104, '20-04-2020');
INSERT INTO Siparisler VALUES(55, 105, '21-04-2020');

SELECT * FROM Siparisler;
SELECT * FROM Sirketler;


/*=============================== FULL JOIN  ==================================
    FULL JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari getirmek icin kullanilir. Ortaklar ayni satirda yazilir, extra fazla satir varsa o da yazilir.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    FULL JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/

-- ORNEK1: Sirketler ve Siparisler adindaki tablolarda yer alan sirket_isim, siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.

SELECT sirket_isim, siparis_id, siparis_tarihi, SP.sirket_id
FROM Sirketler S
FULL JOIN Siparisler SP
ON S.sirket_id = SP.sirket_id;


/* =============================== INNER JOIN  ==================================
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
================================================================================
/* -----------------------------------------------------------------------------
  ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
  Null olanlar cikmicak çünkü NULL ortak deðil(bir tabloda null iken diðerinde id null yok, 100, 101 vs var)
------------------------------------------------------------------------------*/

SELECT sirket_isim, siparis_id, siparis_tarihi, SP.sirket_id
FROM Sirketler S
INNER JOIN Siparisler SP
ON S.sirket_id = SP.sirket_id;

-- INNER JOIN ile sadece iki tablodaki ortak olan satirlar secilir.
-- Diger ifadeyle iki tablodaki ortak olan sirket_id degerleri icin ilgili sutunlar listenir.

/* =============================== LEFT JOIN  ==================================
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir.
    Ancak, diger tablodan sadece ON ile belirtilen 2.tablodan kosula uyan satirlari getirir.
    -- ancak ortak olmayan kisimlar bos kalir. 2. tablodan 104,105 yok mesela.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK3: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/ 

SELECT sirket_isim, siparis_id, siparis_tarihi, SP.sirket_id, S.sirket_id
FROM Sirketler S
LEFT JOIN Siparisler SP
ON SP.sirket_id = S.sirket_id;


/* ============================== RIGHT JOIN  ==================================
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir.
     diger tablodan sadece ON ile belirtilen 1. tablodan kosula uyan (ortak) satirlari getirir.
    ancak ortak olmayan kisimlar bos kalir.1. tablodaki Toyota yazýlmaz, ortak olmadýðý için
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK4: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile
  bunlara karþýlýk gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

SELECT siparis_id, siparis_tarihi, sirket_isim, S.sirket_id, SP.sirket_id
FROM Sirketler S
RIGHT JOIN Siparisler SP
ON SP.sirket_id = S.sirket_id;

---------------------------------------------------------------------------------
-- ORNEKLER

CREATE TABLE Bolumler (

bolum_id NUMBER(2) ,
bolum_isim VARCHAR2(14),
konum VARCHAR2(13)
);

INSERT INTO Bolumler VALUES (10,'MUHASABE','IST');
INSERT INTO Bolumler VALUES (20,'MUDURLUK','ANKARA');
INSERT INTO Bolumler VALUES (30,'SATIS','IZMIR');
INSERT INTO Bolumler VALUES (40,'ISLETME','BURSA');
INSERT INTO Bolumler VALUES (50,'DEPO', 'YOZGAT');

CREATE TABLE Personel (
personel_id NUMBER(4) ,
personel_isim VARCHAR2(10),
meslek VARCHAR2(9),
mudur_id NUMBER(4),
ise_baslama DATE,
maas NUMBER(7,2),
bolum_id NUMBER(2)
);
   
INSERT INTO Personel VALUES (7369,'AHMET','KATIP',7902,'17.12.1980',800,20);
INSERT INTO Personel VALUES (7499,'BAHATTIN','SATIS',7698,'20.02.1981',1600,30);
INSERT INTO Personel VALUES (7521,'NESE','SATIS',7698,'22.02.1981',1250,30);
INSERT INTO Personel VALUES (7566,'MUZAFFER','MUDUR',7839,'02.04.1981',2975,20);
INSERT INTO Personel VALUES (7654,'MUHAMMET','SATIS',7698,'28.09.1981',1250,30);
INSERT INTO Personel VALUES (7698,'EMINE','MUDUR',7839,'01.05.1981',2850,30);
INSERT INTO Personel VALUES (7782,'HARUN','MUDUR',7839,'09.06.1981', 2450,10);
INSERT INTO Personel VALUES (7788,'MESUT','ANALIST',7566,'13.07.87',3000,20);
INSERT INTO Personel VALUES (7839,'SEHER','BASKAN',NULL,'17.11.1981',5000,10);
INSERT INTO Personel VALUES (7844,'DUYGU','SATIS',7698,'08.09.1981',1500,30);
INSERT INTO Personel VALUES (7876,'ALI','KATIP',7788,'13.07.1987',1100,20);
INSERT INTO Personel VALUES (7900,'MERVE','KATIP',7698,'03.12.1981',950,30);
INSERT INTO Personel VALUES (7902,'NAZLI','ANALIST',7566,'03.12.1981',3000,20);
INSERT INTO Personel VALUES (7934,'EBRU','KATIP',7782,'23.01.1982',1300,10);
INSERT INTO Personel VALUES (7956,'SIBEL','MIMAR',7782,'29.01.1991',3300,60);
INSERT INTO Personel VALUES (7933,'ZEKI','MUHENDIS',7782,'26.01.1987',4300,60);
    
-- ORNEK1: SATIS ve MUHASABE bolumlerinde calisan personelin isimlerini ve bolumlerini, once bolum sonra isim sýralý olarak listeleyiniz.
  
SELECT Personel_isim, bolum_isim
FROM Personel P
FULL JOIN Bolumler B
ON B.bolum_id = P.bolum_id
WHERE bolum_isim IN ('SATIS', 'MUHASABE')
ORDER BY bolum_isim, personel_isim;


-- ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,  bolumlerini ve ise_baslama tarihlerini bolum_isim sýralý olarak listeleyiniz.
-- NOT: Calisani olmasa bile bolum ismi gosterilmelidir.

SELECT bolum_isim, personel_isim, ise_baslama
FROM Bolumler B
LEFT JOIN Personel P
ON P.bolum_id = B.bolum_id
WHERE bolum_isim IN ('SATIS', 'ISLETME', 'DEPO')
ORDER BY bolum_isim; 