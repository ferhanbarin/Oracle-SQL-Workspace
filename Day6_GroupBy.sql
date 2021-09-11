/* ============================ GROUP BY =====================================
    GROUP BY cümleciði bir SELECT ifadesinde satýrlarý, sutunlarýn deðerlerine
    göre özet olarak gruplamak için kullanýlýr.
    GROUP BY cümleceði her grup baþýna bir satýr döndürür.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlarý ile birlikte kullanýlýr. */

CREATE TABLE Manav (
    
isim varchar2(50),
urun_adi varchar2(50),
urun_miktari number(9)
);

INSERT INTO Manav VALUES('Ali', 'Elma', 5);
INSERT INTO Manav VALUES('Ayse', 'Armut', 3);
INSERT INTO Manav VALUES('Veli', 'Elma', 2);
INSERT INTO Manav VALUES('Hasan', 'Uzum', 4);
INSERT INTO Manav VALUES('Ali', 'Armut', 2);
INSERT INTO Manav VALUES('Ayse', 'Elma', 3);
INSERT INTO Manav VALUES('Veli', 'Uzum', 4);
INSERT INTO Manav VALUES('Ali', 'Armut', 2);
INSERT INTO Manav VALUES('Veli', 'Elma', 3);
INSERT INTO Manav VALUES('Ayse', 'Uzum', 4);
INSERT INTO Manav VALUES('Ali', '', 2);

SELECT * FROM Manav;

-- ORNEK1: Kisi ismine göre satilan toplam meyve miktarlarini gösteren sorguyu yaziniz. ali => 5+2+2+2 sum = meyve sayilarini toplayacak.

SELECT isim, SUM(urun_miktari) toplam_urun FROM Manav 
GROUP BY isim; -- Isým isim grupla, her ismi bir kere yaz. O isimdeki meyve sayilarini topla ilgili ismin satirinda göster.


-- ORNEK2: Satilan meyve türüne (urun_adi) göre urun alan kisi sayisini gösteren sorguyu yaziniz. NULL olarak girilen meyveyi listelemesin. Count = elma alan kisileri sayacak.

SELECT urun_adi, COUNT (isim) FROM Manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi;


-- ORNEK3: Satilan meyve türüne (urun_adi) göre satilan (urun_miktari) MIN ve MAX miktarlarini, MAX ürün miktarina göre SIRALAYARAK listeleyen sorguyu yaziniz.

SELECT urun_adi, MIN (urun_miktari), MAX (urun_miktari) FROM Manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
ORDER BY MAX (urun_miktari) DESC;


/* -- *********** SIRALAMA ASAGIDAKI GIBI OLMALI **********
SELECT FROM
WHERE -- Gruplamadan bazý sartlara göre bazilarini ele.
GROUP BY -- Ozelliklerine göre grupla.
HAVING -- Grup özelliklerine göre sartla ele. Ya where ya having yani.
ORDER BY -- Bu gruplari istenilen özellige göre sirala.  */


-- ORNEK4: Kisi ismine ve urun adýna (select) göre satýlan ürünlerin (sum)toplamýný gruplandýran ve önce isme göre sonra urun_adi na göre ters sýrayla (order by) listeyen sorguyu yazýnýz.
-- Once isme göre sonra meyvelere =  

SELECT isim, urun_adi, SUM (urun_miktari) FROM MANAV
GROUP BY isim, urun_adi
ORDER BY isim, urun_adi DESC; -- Isim dogal sirali, urun_adi ters sirali oldu.


/* ORNEK5: kisi ISMÝNE ve URUN ADINA göre, satýlan ürünlerin toplamýný bulan ve
   ** SELECT ISÝM, URUN_ADÝ    SUM(URUN_MÝKTARÝ) GROUP BY ISÝM, URUN_MÝKTARÝ **
   ve bu toplam deðeri 3 ve fazlasý olan kayýtlarý toplam urun miktarlarina göre ters siralayarak listeyen sorguyu yazýnýz.
     **HAVÝNG SUM(URUN_MÝKTARÝ)>=3      **  ORDER BY SUM(URUN_MÝKTARÝ)
     veli elma 5                              ali elma 5
       **DESC                                 ali armut 4... */                            

SELECT isim, urun_adi, SUM (urun_miktari) toplam_urun FROM MANAV
GROUP BY isim, urun_adi
HAVING SUM (urun_miktari) >= 3
ORDER BY SUM (urun_miktari) DESC; 

-- WHERE SUM (urun_miktari)>=3 mantýken calýsmali ama SQL (aggregate) bu sartý GROUP BY dan sonra HAVING ile yapýyor.
-- AGGREGATE (toplama sum, count vs)fonksiyonlarý ile ilgili bir kosul koymak.
-- Icin GROUP BY'dan sonra HAVING cümlecigi kullanýlýr.


-- ORNEK6: satýlan urun_adi'na göre gruplayýp MAX urun sayýlarýný,(yine max ürün sayýsýna göre) sýralayarak listeyen sorguyu yazýnýz. 
-- NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarýna esit olmayan kayýtlarý (where gibi koþul var) listelemelidir.  

SELECT urun_adi, MAX (urun_miktari) esit_olmayan_urunler FROM Manav
GROUP BY urun_adi
HAVING MAX (urun_miktari) != MIN (urun_miktari)
ORDER BY MAX (urun_miktari);


/* ============================= DISTINCT =====================================
    DISTINCT cümlecigi bir SORGU ifadesinde benzer olan satirlari filtrelemek
    icin kullanilir. Dolayisiyla secilen sutun yada sutunlar için benzersiz veri
    iceren satirlar olusturmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi, sutun_adi2, satin_adi3
    FROM  tablo_adý;  */
    

-- ORNEK1: Satilan farkli meyve türlerinin sayisini listeyen sorguyu yaziniz. (Kac farkli meyve türü var, elma armut üzüm=3)

SELECT COUNT (DISTINCT urun_adi) urun_cesit_sayisi FROM Manav;


-- ORNEK2: Satilan meyve adý ve isimlerin (totalde) farkli olanlarini listeyen sorguyu yaziniz.

SELECT DISTINCT urun_adi, isim FROM Manav;


-- ORNEK3: Satilan meyvelerin urun_miktarlarinin benzersiz olanlarinin toplamlarini listeyen sorguyu yaziniz. 2+3+4+5=14

SELECT SUM (DISTINCT urun_miktari) benzersiz_urun_sayisi_toplami FROM Manav;  