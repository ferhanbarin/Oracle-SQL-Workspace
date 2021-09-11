----- SELECT - WHERE -----

CREATE TABLE Ogrenciler1 (
    
id NUMBER(9),
isim VARCHAR2(50),
adres VARCHAR2(100),
sinav_notu NUMBER(3)
);

INSERT INTO Ogrenciler1 VALUES(123,'Ali Can','Ankara',75);
INSERT INTO Ogrenciler1 VALUES(124,'Merve Gül','Ankara',85);
INSERT INTO Ogrenciler1 VALUES(125,'Kemal Yasa','Istanbul',85);

SELECT * FROM Ogrenciler1;

/* ============================================================================
   Verileri SELECT komutu ile veritabanindan cekerken filtreleme yapmak icin 
   
   Syntax
   --------
   SELECT ile birlikte WHERE komutu kullanilabilir. 
   
   SELECT sutun1, sutun2
        ...
   FROM  tablo_adi WHERE kosul;
==============================================================================*/

-- ORNEK I : Sinav notu 80'den büyük olan tüm ögrencilerin bilgilerini listele.

SELECT * FROM Ogrenciler1 WHERE sinav_notu>80;


-- ORNEK II : Adresi Ankara olan ögrencilerin isim ve adres bilgilerini listele.

SELECT isim, adres FROM Ogrenciler1
WHERE adres = 'Ankara';

-- ORNEK III : ID'si 124 olan ögrencilerin tüm bilgilerini sil.

DELETE FROM Ogrenciler1
WHERE id = 124;


----- SELECT - BETWEEN -----

CREATE TABLE Personel1 (
    
id CHAR(5),
isim VARCHAR2(50),
maas NUMBER(5)
);

INSERT INTO Personel1 VALUES('10001','Ahmet Aslan',7000);
INSERT INTO Personel1 VALUES( '10002','Mehmet Yilmaz',12000);
INSERT INTO Personel1 VALUES('10003','Meryem',7215);
INSERT INTO Personel1 VALUES('10004','Veli Han',5000);
INSERT INTO Personel1 VALUES('10005','Mustafa Ali',5500);
INSERT INTO Personel1 VALUES('10005','Ayse Can',4000);

-- ORNEK IV : ID'si 10002 ile 10005 arasinda olan personelin bilgilerini listele.

SELECT * FROM Personel1
WHERE id BETWEEN '10002' AND '10005'; -- BETWEEN'de ilk ve son deger dahildir.

-- 2. YONTEM

SELECT * FROM Personel1
WHERE id>='10002' AND id<='10005';

-- ORNEK V : Ismi M.Yilmaz ile V.Han arasinda olan personel bilgilerini listele.

SELECT * FROM Personel1
WHERE isim BETWEEN 'Mehmet Yilmaz' AND 'Veli Han';

-- ORNEK VI : ID'si 10002 - 10004 arasinda olmayan personelin ismini listele.

SELECT id, maas FROM Personel1
WHERE id NOT BETWEEN '10002' AND '10004'; 

----- SELECT - IN -----

/*IN birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme imkani verir.
    
SYNTAX:

SELECT sutun1,sutun2, ...
FROM tablo_adý
WHERE sutun_adý IN (deger1, deger2, ...); */


-- ORNEK VII : Maasi 4000, 5000, 7000 olan personelin bilgilerini listele.

SELECT * FROM Personel1
WHERE maas IN(4000,5000,7000);


/* ======================= SELECT - LIKE ======================================
    NOT:LIKE anahtar kelimesi, sorgulama yaparken belirli patternleri kullanabilmemize olanak saglar.
    
    SYNTAX:
    -------
    SELECT sutun1, sutun2,…
    FROM  tablo_adi WHERE sutun LIKE pattern
    PATTERN ÝCÝN
    -------------
    %    ---> 0 veya daha fazla karakteri belirtir.
    _    ---> Tek bir karakteri temsil eder.
  =========================================================================== */
  
-- ORNEK: Ismi A harfi ile baslayanlari listeleyiniz.

SELECT * FROM Personel1
WHERE isim LIKE 'A%';

-- ORNEK10: Ismi n harfi ile bitenleri listeleyiniz.

SELECT * FROM Personel1
WHERE isim LIKE '%n';

-- ORNEK11: Isminin 2. harfi e olanlarý listeleyiniz.

SELECT * FROM Personel1
WHERE isim LIKE '_e%';

-- ORNEK12: Isminin 2. harfi e olup diðer harflerinde y olanlarý listeleyiniz.

SELECT * FROM Personel1
WHERE isim LIKE '_e%y%';

-- ORNEK13: Ismi A ile baslamayanlari listeleyiniz.

SELECT * FROM Personel1
WHERE isim NOT LIKE 'A%';

-- ORNEK15: Isminde a harfi olmayanlari listeleyiniz.

SELECT * FROM Personel1
WHERE isim LIKE 'a%';

-- ORNEK16: Maasinin son 2 hanesi 00 olmayanlari listeleyiniz.

SELECT * FROM Personel1
WHERE maas NOT LIKE '%00';

-- ORNEK17: Maasi 5 haneli olanlari listeleyiniz.

SELECT * FROM Personel1
WHERE maas LIKE '_____';

-- ORNEK18: 1. harfi A ve 7.harfi A olan personeli listeleyiniz.

SELECT * FROM Personel1
WHERE isim LIKE 'A_______A%';

/* ======================= SELECT - REGEXP_LIKE ================================
    Daha karmasik pattern ile sorgulama islemi için REGEXP_LIKE kullanilabilir.
    Syntax:
    --------
    REGEXP_LIKE(sutun_adý, ‘pattern[] ‘, ‘c’ ] )
             -- 'c' => case-sentisitive demektir ve default case-sensitive aktiftir.
     -- 'i' => incase-sentisitive demektir.
/* ========================================================================== */

CREATE TABLE Kelimeler (
    
id NUMBER(10) UNIQUE,
kelime VARCHAR2(50) NOT NULL,
harf_sayisi NUMBER(6)
);
 
INSERT INTO Kelimeler VALUES (1001, 'hot', 3);
INSERT INTO Kelimeler VALUES (1002, 'hat', 3);
INSERT INTO Kelimeler VALUES (1003, 'hit', 3);
INSERT INTO Kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO Kelimeler VALUES (1005, 'hct', 3);
INSERT INTO Kelimeler VALUES (1006, 'adem', 4);
INSERT INTO Kelimeler VALUES (1007, 'selim', 5);
INSERT INTO Kelimeler VALUES (1008, 'yusuf', 5);
INSERT INTO Kelimeler VALUES (1009, 'hip', 3);
INSERT INTO Kelimeler VALUES (1010, 'HOT', 3);
INSERT INTO Kelimeler VALUES (1011, 'hOt', 3);
INSERT INTO Kelimeler VALUES (1012, 'h9t', 3);
INSERT INTO Kelimeler VALUES (1013, 'hoot', 4);
INSERT INTO Kelimeler VALUES (1014, 'haaat', 5);

-- ORNEK: Ýcerisinde 'hi' bulunan kelimeleri listeleyeniz.

SELECT * FROM Kelimeler
WHERE kelime LIKE '%hi%';

SELECT * FROM Kelimeler
WHERE REGEXP_LIKE (kelime, 'hi');

-- ORNEK: Ýcerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz.

SELECT * FROM Kelimeler
WHERE REGEXP_LIKE (kelime, 'at|ot'); -- veya islemi icin | kullanilir.


-- ORNEK24: 'ho' veya 'hi' ile baslayan kelimeleri büyük-kücük harfe dikkat etmeksizin listeleyeniz.

SELECT * FROM Kelimeler
WHERE REGEXP_LIKE (kelime, '^ho|^hi','i'); -- ... baslangic oldugunu belirtmek icin ^ isareti kullanilir.


-- ORNEK: Sonu 't' veya 'm' ile bitenleri büyük-kücük harfe dikkat etmeksizin listeleyeniz.

SELECT * FROM Kelimeler
WHERE REGEXP_LIKE (kelime, 't$|m$','i'); -- Bitisi kastetmek icin $ isareti kullanilir.


-- ORNEK26: h ile baslayip t ile biten 3 harfli kelimeleri büyük-kücük harfe dikkat etmeksizin listeleyeniz.

SELECT * FROM Kelimeler
WHERE REGEXP_LIKE (kelime, 'h[a-zA-Z0-9]t','i'); -- h_t yazilabilir ama büyük-kücük harf duyarliligi yok.   


-- ORNEK: Ýcinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.

SELECT * FROM Kelimeler
WHERE REGEXP_LIKE (kelime, 'm|i|e');