/* ==================== SET (küme) OPERATORLERI: UNION, UNION ALL======================
    set=küme diyelim diðer set (sql komutu) ile karýþmasýn
    UNION, UNION ALL, INTERSECT, ve MINUS gibi SET operatorleri yardimiyla
    Çoklu Sorgular birlestirilebilirler.ayný tablodan yada farklý tablodan sütunlarý birleþtirip ayný sütunda yazdýrma
    UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc
    kumelerini birlesitirerek tek bir sonuc kumesi olusturur. (iki kümenin birleþimi)
    -- UNION
-- Eger tek sorguda birlestiremeyecegim iki sorgunun sonucunu ayni tabloda
-- gormek istersek UNION islemi kullanilir
-- BU durumda dikkat etmemiz gereken konu iki sorguda da field sayisi ve
-- alt alta gelecek field data tiplerinin ayni olmasidir
    -- UNION ALL komutu ise tekrara bakmaksizin iki sorgudan gelen tum sonuclari listeler
-- UNION ALL komutunda da iki sorgunun sonucunun esit sayida field'a ve data
-- tiplerine sahip olmasi gereklidir
     SÜTUN birleþtirme=> SET
     TABLO birleþtirme=> JOIN
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    NOT: UNION operatoru SADECE benzersiz degerleri alýr. Benzerli verileri almak
    için UNION ALL kullanýlýr. */
    
CREATE TABLE Personel (
    
id NUMBER(9),
isim VARCHAR2(50),
sehir VARCHAR2(50),
maas NUMBER(20),
sirket VARCHAR2(20)
);

INSERT INTO Personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO Personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO Personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO Personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO Personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO Personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO Personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');

-- ORNEK1: Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz. 

SELECT isim AS isim_veya_sehir, maas FROM Personel
WHERE maas > 4000
UNION -- Union ALL kullanilirsa tekrarli veriler elenmez, union yazarsak 2 tane olan Veli Sahin tek yazilir.
SELECT sehir, maas FROM Personel
WHERE maas > 5000;


-- ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul'daki personelin maaslarini yüksekten alçaða doðru sýralayarak bir tabloda gosteren sorguyu yaziniz.

SELECT isim AS isim_sehir, maas FROM Personel
WHERE isim = 'Mehmet Ozturk'
UNION
SELECT sehir, maas FROM Personel
WHERE sehir = 'Istanbul'
ORDER BY maas DESC;


/* ======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/

CREATE TABLE Personel_Bilgi (
    
id NUMBER(9),
tel char(10) UNIQUE ,
cocuk_sayisi NUMBER(2)
);

INSERT INTO Personel_Bilgi VALUES(123456789, '5302345678' , 5);
INSERT INTO Personel_Bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO Personel_Bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO Personel_Bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO Personel_Bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO Personel_Bilgi VALUES(453445611, '5524578574', 2);
INSERT INTO Personel_Bilgi VALUES(123456710, '5537488585', 1);


-- ORNEK4: id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin.

SELECT id, sehir AS sehir_tel, maas AS maas_cocuk_sayisi FROM Personel
WHERE id = 123456789
UNION
SELECT id, tel, cocuk_sayisi FROM Personel_Bilgi
WHERE id = 123456789;


/* ========================= SET OPERATORLERI: INTERSECT ========================
    --ýntersect=> iki kümenin kesiþimini döndürür
    INTERSECT operarotu 2 veya daha fazla Sorgu ifadesinin sonuclarini
    dondurmek icin kullanilir. Ancak, intersect SADECE tum sorgularin ortak
    verilerini (kesimlerini) dondurur.
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    INTERSECT
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK5: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini
  sorgulayiniz.
  Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.
  Bu iki sorguyu INTERSECT ile birlesitiriniz.
------------------------------------------------------------------------------*/
  
SELECT id FROM Personel
WHERE sehir IN('Istanbul', 'Ankara')
INTERSECT
SELECT id FROM Personel_Bilgi
WHERE cocuk_sayisi IN (2,3);


-- ORNEK6: Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin.
-- UNION yazarsak istenen herþeyi alýr gelir (tofas+honda+ford), INTERSECT ortaklarý alýyor.

SELECT isim FROM Personel -- Tek satirda birkac veri birden isteniyorsa AND ile, farkli satirlardan ortaklik isteniyorsa INTERSECT.
WHERE sirket = 'Honda'

INTERSECT

SELECT isim FROM Personel
WHERE sirket = 'Ford'
INTERSECT
SELECT isim FROM Personel
WHERE sirket = 'Tofas';


-- ORNEK7: Toyota ve Ford sirketlerinde ayni maasi alan personel isimlerini listeleyin.

SELECT isim, maas FROM Personel
WHERE sirket = 'Toyota'
INTERSECT
SELECT isim, maas FROM Personel
WHERE sirket = 'Ford';

-- Bazý iþlemleri AND ile yapabilirdik
-- INTERSECT islemi mantik olarak AND komutu ile aynidir(isim...and sehir...olur.sirket... and sirket... olmaz)
-- Ancak INTERSECT ile cozulen her soru AND ile cozulemez  

/*========================= SET OPERATORLERI: MINUS ============================
    MINUS operatoru ilk Sorgu ifadesinde olup da diger sorgu ifadesinde olmayan
    verileri dondurur. Yani 1. sorgu ile 2. sorgu arasindaki farklý olanlarý
    dondurur
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    MINUS
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
==============================================================================*/
/* -----------------------------------------------------------------------------

ORNEK8: 5000’den az maas alan ve Honda calisani olmayanlarýn bilgilerini listeleyen bir sorgu yaziniz. */

-- 1. YONTEM  (maasi 5000 den az olanlar ile sirketi Honda olmayanlari (!=) sec)
SELECT isim, maas, sirket FROM Personel
WHERE maas<5000
INTERSECT
SELECT isim, maas, sirket FROM Personel
WHERE sirket != 'Honda';

-- 2. YONTEM  (maasi 5000 den az olanlar ile sirketi Honda'dan farkli olanlari sec)
SELECT isim, maas, sirket FROM Personel
WHERE maas<5000
MINUS
SELECT isim, maas, sirket FROM Personel
WHERE sirket = 'Honda';  
  
-- ORNEK8: Ismi Mehmet Ozturk olup Izmir’de calismayanlarin isimlerini ve sehirlerini listeleyen sorguyu yaziniz. 

SELECT isim, sehir FROM Personel
WHERE isim = 'Mehmet Ozturk'
MINUS
SELECT isim, sehir FROM Personel
WHERE sehir = 'Izmir';
-- MINUS'ta UNION gibi tekrarli satirlardan sadece birini yazdirir.