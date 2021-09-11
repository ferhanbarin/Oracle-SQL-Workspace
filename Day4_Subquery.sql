----- SUBQUERY -----

-- Sorgu icinde calisan sorguya subquery(alt sorgu) denir.

CREATE TABLE Personel2 (
    
id NUMBER(9),
isim VARCHAR2(50),
sehir VARCHAR2(50),
maas NUMBER(20),
sirket VARCHAR2(20)
);

INSERT INTO Personel2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
INSERT INTO Personel2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
INSERT INTO Personel2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
INSERT INTO Personel2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
INSERT INTO Personel2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
INSERT INTO Personel2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
INSERT INTO Personel2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');


CREATE TABLE Sirketler (
    
sirket_id NUMBER(9),
sirket_adi VARCHAR2(20),
personel_sayisi NUMBER(20)
);

INSERT INTO Sirketler VALUES(100, 'Honda', 12000);
INSERT INTO Sirketler VALUES(101, 'Ford', 18000);
INSERT INTO Sirketler VALUES(102, 'Hyundai', 10000);
INSERT INTO Sirketler VALUES(103, 'Toyota', 21000);
INSERT INTO Sirketler VALUES(104, 'Mazda', 17000);

SELECT *FROM Sirketler;
SELECT * FROM Personel2;

-- ORNEK 1: PERSONEL SAYISI 15.000’den COK OLAN SIRKETLERIN ISIMLERINI (alt sorgu sirketler)ve bu sirkette calisan personelin isimlerini ve maaslarini (asil sorgu personel) listeleyin.

SELECT isim, maas, sirket FROM Personel2
WHERE sirket IN (SELECT sirket_adi FROM Sirketler WHERE personel_sayisi>15000);


-- ORNEK 2 : sirket_id'si 101'den büyük olan sirket calisanlarinin isim, maas ve sehirlerini listeleyiniz.

SELECT isim, maas, sehir FROM Personel2
WHERE sirket IN (SELECT sirket_adi FROM Sirketler WHERE sirket_id>101);


-- ORNEK3: Ankara'da personeli olan sirketlerin sirket id'lerini ve personel sayilarini listeleyiniz.

SELECT sirket_id, personel_sayisi FROM Sirketler
WHERE sirket_adi IN (SELECT sirket FROM Personel2 WHERE sehir = 'Ankara');


/* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlari(SUM,COUNT, MIN,MAX, AVG) Subquery icinde kullanilabilir.
    Ancak, Sorgu tek bir deger döndürüyor olmalidir.
-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz. --SELECT id,isim,maas
                                                                                                        --FROM personel
                                                                                                        --WHERE sirket='Honda';
-- Bir tablodan tek deger getirebilmek icin ortalama AVG , toplam SUM, adet COUNT, MIN, MAX gibi.
-- Fonksiyonlar kullanilir ve bu fonksiyonlara AGGREGATE FONKSIYONLAR denir.
==============================================================================*/  
  
-- ORNEK 4 : Her sirketin ismini, personel sayisini ve o sirkete ait personelin toplam maasini listeleyen bir sorgu yaziniz.

SELECT sirket_adi, personel_sayisi, (SELECT SUM (maas) FROM Personel2 WHERE Sirketler.sirket_adi = Personel2.sirket) AS toplam_maas
FROM Sirketler; 


-- ORNEK 5 : Her sirketin ismini, personel sayisini ve o sirkete ait personelin ortalama maasini listeleyen bir sorgu yaziniz.

SELECT sirket_adi, personel_sayisi, (SELECT ROUND (AVG (maas)) FROM Personel2 WHERE sirket_adi = sirket) AS ort_maas
FROM Sirketler;


-- ORNEK 6 : Her sirketin ismini, personel sayisini ve o sirkete ait personelin maksimum ve minumum maasini listeleyen bir sorgu yaziniz.
--           Maksimum ve minimum maasinin listeleyen bir sorgu yaziniz.

SELECT sirket_adi, personel_sayisi, (SELECT MAX (maas) FROM Personel2 WHERE sirket_adi = sirket) AS max_maas, (SELECT MIN (maas) FROM Personel2 WHERE sirket_adi = sirket) AS min_maas
FROM Sirketler;


-- ORNEK 7 : Her sirketin id'sini, ismini ve toplam kac sehirde bulundugunu listeleyen bir SORGU yaziniz.

SELECT sirket_id, sirket_adi, (SELECT COUNT (sehir) FROM Personel2 WHERE sirket = sirket_adi) AS sehir_sayisi
FROM Sirketler;