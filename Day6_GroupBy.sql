/* ============================ GROUP BY =====================================
    GROUP BY c�mleci�i bir SELECT ifadesinde sat�rlar�, sutunlar�n de�erlerine
    g�re �zet olarak gruplamak i�in kullan�l�r.
    GROUP BY c�mlece�i her grup ba��na bir sat�r d�nd�r�r.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlar� ile birlikte kullan�l�r. */

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

-- ORNEK1: Kisi ismine g�re satilan toplam meyve miktarlarini g�steren sorguyu yaziniz. ali => 5+2+2+2 sum = meyve sayilarini toplayacak.

SELECT isim, SUM(urun_miktari) toplam_urun FROM Manav 
GROUP BY isim; -- Is�m isim grupla, her ismi bir kere yaz. O isimdeki meyve sayilarini topla ilgili ismin satirinda g�ster.


-- ORNEK2: Satilan meyve t�r�ne (urun_adi) g�re urun alan kisi sayisini g�steren sorguyu yaziniz. NULL olarak girilen meyveyi listelemesin. Count = elma alan kisileri sayacak.

SELECT urun_adi, COUNT (isim) FROM Manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi;


-- ORNEK3: Satilan meyve t�r�ne (urun_adi) g�re satilan (urun_miktari) MIN ve MAX miktarlarini, MAX �r�n miktarina g�re SIRALAYARAK listeleyen sorguyu yaziniz.

SELECT urun_adi, MIN (urun_miktari), MAX (urun_miktari) FROM Manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
ORDER BY MAX (urun_miktari) DESC;


/* -- *********** SIRALAMA ASAGIDAKI GIBI OLMALI **********
SELECT FROM
WHERE -- Gruplamadan baz� sartlara g�re bazilarini ele.
GROUP BY -- Ozelliklerine g�re grupla.
HAVING -- Grup �zelliklerine g�re sartla ele. Ya where ya having yani.
ORDER BY -- Bu gruplari istenilen �zellige g�re sirala.  */


-- ORNEK4: Kisi ismine ve urun ad�na (select) g�re sat�lan �r�nlerin (sum)toplam�n� grupland�ran ve �nce isme g�re sonra urun_adi na g�re ters s�rayla (order by) listeyen sorguyu yaz�n�z.
-- Once isme g�re sonra meyvelere =  

SELECT isim, urun_adi, SUM (urun_miktari) FROM MANAV
GROUP BY isim, urun_adi
ORDER BY isim, urun_adi DESC; -- Isim dogal sirali, urun_adi ters sirali oldu.


/* ORNEK5: kisi ISM�NE ve URUN ADINA g�re, sat�lan �r�nlerin toplam�n� bulan ve
   ** SELECT IS�M, URUN_AD�    SUM(URUN_M�KTAR�) GROUP BY IS�M, URUN_M�KTAR� **
   ve bu toplam de�eri 3 ve fazlas� olan kay�tlar� toplam urun miktarlarina g�re ters siralayarak listeyen sorguyu yaz�n�z.
     **HAV�NG SUM(URUN_M�KTAR�)>=3      **  ORDER BY SUM(URUN_M�KTAR�)
     veli elma 5                              ali elma 5
       **DESC                                 ali armut 4... */                            

SELECT isim, urun_adi, SUM (urun_miktari) toplam_urun FROM MANAV
GROUP BY isim, urun_adi
HAVING SUM (urun_miktari) >= 3
ORDER BY SUM (urun_miktari) DESC; 

-- WHERE SUM (urun_miktari)>=3 mant�ken cal�smali ama SQL (aggregate) bu sart� GROUP BY dan sonra HAVING ile yap�yor.
-- AGGREGATE (toplama sum, count vs)fonksiyonlar� ile ilgili bir kosul koymak.
-- Icin GROUP BY'dan sonra HAVING c�mlecigi kullan�l�r.


-- ORNEK6: sat�lan urun_adi'na g�re gruplay�p MAX urun say�lar�n�,(yine max �r�n say�s�na g�re) s�ralayarak listeyen sorguyu yaz�n�z. 
-- NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktar�na esit olmayan kay�tlar� (where gibi ko�ul var) listelemelidir.  

SELECT urun_adi, MAX (urun_miktari) esit_olmayan_urunler FROM Manav
GROUP BY urun_adi
HAVING MAX (urun_miktari) != MIN (urun_miktari)
ORDER BY MAX (urun_miktari);


/* ============================= DISTINCT =====================================
    DISTINCT c�mlecigi bir SORGU ifadesinde benzer olan satirlari filtrelemek
    icin kullanilir. Dolayisiyla secilen sutun yada sutunlar i�in benzersiz veri
    iceren satirlar olusturmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi, sutun_adi2, satin_adi3
    FROM  tablo_ad�;  */
    

-- ORNEK1: Satilan farkli meyve t�rlerinin sayisini listeyen sorguyu yaziniz. (Kac farkli meyve t�r� var, elma armut �z�m=3)

SELECT COUNT (DISTINCT urun_adi) urun_cesit_sayisi FROM Manav;


-- ORNEK2: Satilan meyve ad� ve isimlerin (totalde) farkli olanlarini listeyen sorguyu yaziniz.

SELECT DISTINCT urun_adi, isim FROM Manav;


-- ORNEK3: Satilan meyvelerin urun_miktarlarinin benzersiz olanlarinin toplamlarini listeyen sorguyu yaziniz. 2+3+4+5=14

SELECT SUM (DISTINCT urun_miktari) benzersiz_urun_sayisi_toplami FROM Manav;  