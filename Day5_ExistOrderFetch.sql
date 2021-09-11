CREATE TABLE Mart_Satislar (
    
urun_id number(10),
musteri_isim varchar2(50),
urun_isim varchar2(50)
);

CREATE TABLE Nisan_Satislar (
    
urun_id number(10),
musteri_isim varchar2(50),
urun_isim varchar2(50)
);

INSERT INTO Mart_Satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO Mart_Satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO Mart_Satislar VALUES (20, 'John', 'Toyota');
INSERT INTO Mart_Satislar VALUES (30, 'Amy', 'Ford');
INSERT INTO Mart_Satislar VALUES (20, 'Mark', 'Toyota');
INSERT INTO Mart_Satislar VALUES (10, 'Adem', 'Honda');
INSERT INTO Mart_Satislar VALUES (40, 'John', 'Hyundai');
INSERT INTO Mart_Satislar VALUES (20, 'Eddie', 'Toyota');

INSERT INTO Nisan_Satislar VALUES (10, 'Hasan', 'Honda');
INSERT INTO Nisan_Satislar VALUES (10, 'Kemal', 'Honda');
INSERT INTO Nisan_Satislar VALUES (20, 'Ayse', 'Toyota');
INSERT INTO Nisan_Satislar VALUES (50, 'Yasar', 'Volvo');
INSERT INTO Nisan_Satislar VALUES (20, 'Mine', 'Toyota');

SELECT * FROM Mart_Satislar;
SELECT * FROM Nisan_Satislar;

-- ORNEK1: MART VE NISAN aylarinda ayni URUN_ID ile satilan �r�nlerin URUN_ID'lerini listeleyen ve ayni zamanda bu �r�nleri MART ayinda alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaziniz.

SELECT urun_id, musteri_isim FROM Mart_Satislar 
WHERE EXISTS (SELECT urun_id FROM Nisan_Satislar WHERE Mart_Satislar.urun_id = Nisan_Satislar.urun_id);

-- ORNEK2: Her iki ayda da satilan �r�nlerin URUN_ISIM'lerini ve bu �r�nleri NISAN ayinda satin alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaziniz.

SELECT urun_isim, musteri_isim FROM Nisan_Satislar N
WHERE EXISTS (SELECT urun_isim FROM Mart_Satislar M WHERE M.urun_isim = N.urun_isim);


-- ORNEK3: Her iki ayda da ortak olarak satilmayan �r�nlerin URUN_ISIM'lerini ve bu �r�nleri NISAN ay�nda satin alan MUSTERI_ISIM'lerini listeleyiniz.

SELECT urun_isim, musteri_isim FROM Nisan_Satislar N
WHERE NOT EXISTS (SELECT urun_isim FROM Mart_Satislar M WHERE M.urun_isim = N.urun_isim);


/*===================== IS NULL, IS NOT NULL, COALESCE(kulesk=birlesmek) ========================
    IS NULL, ve IS NOT NULL BOOLEAN operat�rleridir. Bir ifadenin NULL olup
    olmadigini kontrol ederler.
==============================================================================*/
CREATE TABLE Insanlar (
    
ssn CHAR(9),
isim VARCHAR2(50),
adres VARCHAR2(50)
);

INSERT INTO Insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
INSERT INTO Insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
INSERT INTO Insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
INSERT INTO Insanlar (ssn, adres) VALUES('456789012', 'Bursa');
INSERT INTO Insanlar (ssn, adres) VALUES('567890123', 'Denizli');
INSERT INTO Insanlar (adres) VALUES('Sakarya');
INSERT INTO Insanlar (ssn) VALUES('999111222');

SELECT * FROM Insanlar;


-- ORNEK 1: Isim'i NULL olanlari sorgulayiniz.

SELECT * FROM Insanlar
WHERE isim IS NULL;


-- ORNEK 2: Isim'i NULL olmayanlari sorgulayiniz.

SELECT * FROM Insanlar
WHERE isim IS NOT NULL;


-- ORNEK 3: Isim'i NULL olan kisilerin isimine NO NAME yazisi atayiniz.

UPDATE Insanlar
SET isim = 'NO NAME'
WHERE isim IS NULL;


-------------------------------------------------------------------------------

/* COALESCE (birle�mek) ise bir fonksiyondur ve i�erisindeki parameterelerden NULL olmayan
    ilk ifadeyi d�nd�r�r. E�er ald�gi t�m ifadeler NULL ise NULL d�nd�r�r�r.
   *** select COALESCE (s�tun1,s�tun2,...) from tabloAd�;
    Birden fazla null ko�uluna g�re de�er atamak istiyorsak COALESCE deyimini kullanabiliriz.
    COALESCE asl�nda case mant���nda �al���r ve birden fazla kolon aras�nda kontrol sa�layabilirsiniz.
    Bir kosul gerceklesmez ise digerine bakar, oda gerceklesmez ise bir sonraki.
    Deyim bitene kadar
   -- CASE
   WHEN (expression1 IS NOT NULL) THEN expression1
   WHEN (expression2 IS NOT NULL) THEN expression2
   ...
   ELSE expressionN
   END  --gibi */

SELECT COALESCE (isim, ssn, adres) FROM Insanlar; 

-- ORNEK 1: Tablodaki b�t�n null verileri g�zel birer c�mle ile degistirin. :)

UPDATE Insanlar
SET isim = COALESCE (isim, 'Hen�z isim girilmedi.'),
adres = COALESCE (adres, 'Hen�z adres girilmedi.'),
ssn = COALESCE (ssn, 'No SSN.');

SELECT * FROM Insanlar;

/* ================================ ORDER BY  ===================================
   ORDER BY c�mlecigi bir SORGU deyimi icerisinde belli bir SUTUN�a g�re
   SIRALAMA yapmak icin kullanilir.
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
================================================================================= */

CREATE TABLE Kisiler (
    
ssn CHAR(9) PRIMARY KEY,
isim VARCHAR2(50),
soyisim VARCHAR2(50),
maas NUMBER,
adres VARCHAR2(50)
);

INSERT INTO Kisiler VALUES(123456789, 'Ali','Can', 3000,'Istanbul');
INSERT INTO Kisiler VALUES(234567890, 'Veli','Cem', 2890,'Ankara');
INSERT INTO Kisiler VALUES(345678901, 'Mine','Bulut',4200,'Ankara');
INSERT INTO Kisiler VALUES(256789012, 'Mahmut','Bulut',3150,'Istanbul');
INSERT INTO Kisiler VALUES (344678901, 'Mine','Yasa', 5000,'Ankara');
INSERT INTO Kisiler VALUES (345458901, 'Veli','Yilmaz',7000,'Istanbul');

SELECT * FROM Kisiler;

-- ORNEK1: Kisiler tablosunu adres'e g�re siralayarak sorgulayiniz.

SELECT * FROM Kisiler
ORDER BY adres;

-- ORNEK2 : Kisiler tablosunu maas'a g�re ters (azalan) siralayarak sorgulayiniz.

SELECT * FROM Kisiler
ORDER BY maas DESC;

-- ORNEK3 : Ismi Mina olanlari, SSN'e g�re azalan (DESC) sirada sorgulayiniz.

SELECT * FROM Kisiler
WHERE isim = 'Mine'
ORDER BY ssn DESC;

-- ORNEK4: Soyismi'i Bulut olanlari isim s�rali olarak sorgulayiniz.

SELECT * FROM Kisiler
WHERE soyisim = 'Bulut'
ORDER BY 2; -- Isim yerine ismin s�tun sirasi olan 2'yi kullanabiliriz.


/* ====================== FETCH NEXT, OFFSET (12C VE USTU Oracle'larda calisir, daha altsan�z calismaz) ======================
   FETCH c�mlecigi ile listelenecek kay�tlar� s�n�rland�rabiliriz. �stersek
   sat�r say�s�na g�re istersek de toplam sat�r say�s�n�n belli bir y�zdesine
   g�re s�n�rland�rma koymak m�mk�nd�r. (�u kadar sat�r� getir)
   Syntax
   ---------
   FETCH NEXT satir_sayisi ROWS ONLY;
   FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
   OFFSET C�mleci�i ile de listenecek olan sat�rlardan s�ras�yla istedi�imiz
   kadar�n� atlayabiliriz.
   Syntax
   ----------
   OFFSET sat�r_sayisi ROWS;
============================================================================== */

--  ORNEK1: MAAS'i en y�ksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz.

/* SELECT * FROM Kisiler
ORDER BY maas DESC 
FETCH NEXT 3 ROWS ONLY; */  -- Bu yeni s�r�mlerde calisir.

SELECT * FROM (SELECT * FROM Kisiler ORDER BY maas DESC) -- (1) kisilerde maasa g�re ters sirala 
WHERE ROWNUM < 4; -- 1.2 ve 3. satiri getir (bu eski s�r�mlerde calisir)


-- ORNEK 2: MAAS'i en d�s�k 2 kisinin bilgilerini listeleyen sorguyu yaziniz.

/* SELECT * FROM Kisiler
ORDER BY maas
FETCH NEXT 2 ROWS ONLY; */

SELECT * FROM (SELECT * FROM Kisiler ORDER BY maas) 
WHERE ROWNUM < 3; 


-- ORNEK 3: MAAS'a g�re siralamada 4. 5. ve 6. kisilerin bilgilerini listeleyen sorguyu yaziniz.

/* SELECT * FROM Kisiler
ORDER BY maas DESC
OFFSET 3 ROWS
FETCH NEXT 3 ROWS ONLY; */

SELECT * FROM
(SELECT * FROM (SELECT * FROM Kisiler ORDER BY maas DESC)
WHERE ROWNUM <=6)   
WHERE ROWNUM <=3;                