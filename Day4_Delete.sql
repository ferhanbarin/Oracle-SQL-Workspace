-- ============================== DELETE ===================================  

-- DELETE FROM tablo_adý;  Tablonun tüm içerðini siler.
-- Bu komut bir DML komutudur. Dolayýsýyla devamýnda WHERE gibi cümlecikler kullanýlabilir.

-- DELETE FROM tablo_adý
-- WHERE sutun_adi = veri;
    
CREATE TABLE Ogrenciler (
id CHAR(3),
isim VARCHAR2(50),
veli_isim VARCHAR2(50),
yazili_notu NUMBER(3)       
);
    
INSERT INTO Ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO Ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO Ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO Ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO Ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
SAVEPOINT ABC; --ROLLBACK kýsmýnda aciklamasi var.
SELECT * FROM Ogrenciler;
    
DROP TABLE Ogrenciler;      
     
/* =============================================================================
         Secerek silmek için WHERE Anahtar kelimesi kullanýlabilir. 
===============================================================================*/     
?
/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/ 
  
      DELETE FROM Ogrenciler
      WHERE id = 124;
    
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan satýrýný siliniz.
 -----------------------------------------------------------------------------*/   
     
      DELETE FROM Ogrenciler
      WHERE isim = 'Kemal Yasa';
      
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz ve Mustafa Bak olan kayýtlarý silelim.
 -----------------------------------------------------------------------------*/        
      DELETE FROM Ogrenciler
      WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak';
                -- IN('nesibe','mustafa')
/* ----------------------------------------------------------------------------
  ORNEK4: Ýsmi Ali Can ve id'si 123 olan kaydý siliniz.
 -----------------------------------------------------------------------------*/    
      
     DELETE FROM Ogrenciler
     WHERE isim = 'Ali Can' AND id = 123;
   
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kayýtlarý silelim.
 -----------------------------------------------------------------------------*/  
  
    DELETE FROM Ogrenciler
    WHERE id>126;
 
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanlarý silelim.
 -----------------------------------------------------------------------------*/     
    
    DELETE FROM Ogrenciler
    WHERE id IN(123,125,126);
    
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKI TUM KAYITLARI SILELIM..
 -----------------------------------------------------------------------------*/     
    DELETE FROM Ogrenciler; 
    
    
    
--*************************************************    
    
      -- Tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir.
-- Silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz. 
-- Ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir.   

/* ======================== DELETE - TRUCATE - DROP ============================   
  
1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamýný siler.
    Ancak, secmeli silme yapamaz. Cünkü Truncate komutu DML deðil DDL komutudur.*/ 
    TRUNCATE TABLE Ogrenciler;  -- Dogru yazim
           
/* 2-) DELETE komutu beraberinde WHERE cümlecigi kullanýlabilir. TRUNCATE ile kullanilmaz. 
    
TRUNCATE TABLE Ogrenciler.....yanlis yazim
WHERE veli_isim='Hasan';
-- TRUNCATE komutu tablo yapisini degistirmeden, 
-- Tablo icinde yer alan tüm verileri tek komutla silmenizi saglar.
        
3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylikla geri alinabilir.
       
4-) Truncate ile silinen veriler geri alinmasi daha zordur. Ancak Transaction yöntemi ile geri alinmasi mümkün olabilir.   
    
5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da siler. Silinen tablo veritabaninin geri dönüsüm kutusuna gider. Silinen tablo asagidaki komut ile geri alinabilir. Veya SQL GUI'den geri alinabilir.
               
     FLASHBACK TABLE tablo_adý TO BEFORE DROP; -> tabloyu geri alir.
     
     PURGE TABLE tablo_adý; -> Geri dönüsümdeki tabloyu siler.
            
     DROP TABLE tablo_adý PURGE; -> Tabloyu tamamen siler.

Connections'da table'yi sag tikla => table => drop, purge isaretle, cöp kutusuna atilmaksizin direk siler.

Connections recyle bin sag tikla, purge => tabloyu tamamen siler. flashback => tabloyu geri getirir.
==============================================================================*/ 
    --INSERT veri girisinden sonra SAVEPOINT ABC; ile verileri buraya sakla
    --(yanlislik yapma olasiligina karsin önlem gibi, AYNI ÝSÝMDE BAÞKA TABLO VARSA)
    --sonra istedigini sil (ister tümü ister bir kismi)
    --sonra savepoint yaptigin yerden alttaki gibi rollback ile verileri geri getir
    DROP TABLE Ogrenciler;
    DELETE FROM Ogrenciler;  -- Tüm verileri sil.
    ROLLBACK TO ABC;         -- Silinen verileri geri getir.
    SELECT * FROM Ogrenciler;
        
        
    DROP TABLE Ogrenciler;   -- Tabloyu siler ve veritabaninin cöp kutusuna 
                             -- gönderir. (DDL komutudur.)
    
    
    -- Cöp kutusundaki tabloyu geri getirir.
    FLASHBACK TABLE Ogrenciler TO BEFORE DROP; 
         
    -- Tabloyu tamamen siler (Cöp kutusuna atmaz.)
    DROP TABLE Ogrenciler PURGE;  
    -- PURGE sadece DROP ile silinmis tablolar icin kullanilir
    -- DROP kullanmadan PURGE komutu kullanmak isterseniz 
    -- ORA-38302: invalid PURGE option hatasi alirsiniz
    -- Tüm veriler hassas bir þekilde siler. Rollback ile geri alinamaz.
    
    -- PURGE yapmak icin 2 yontem kullanabiliriz
--1 tek satirda DROP ve PURGE beraber kullanabiliriz
DROP TABLE Ogrenciler7 PURGE; 

-- Bu komut ile sildigimiz tabloyu geri getirmek icin FLASHBACK komutunu kullansak
-- ORA-38305: object not in RECYCLE BIN hatasini alirsiniz

-- 2 daha once DROP ile silinmis bir tablo varsa sadece PURGE kullanabiliriz
--Tabloyu yeniden olusturalim

DROP TABLE Ogrenciler7;
-- Bu asamada istersek FLASHBACK ile tablomuzu geri getirebiliriz.
PURGE TABLE Ogrenciler7;
-- Bu asamada istesem de tabloyu geri getiremem.
    
 
 
/* =============================================================================
    Tablolar arasinda iliski var ise veriler nasil silinebilir?
============================================================================= */ 
    
         
/*============================== ON DELETE CASCADE =============================

  Her defasinda önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelligini aktif hale getirebiliriz.
  
  Bunun icin FK olan satirin en sonuna ON DELETE CASCADE komutunu yazmak yeterli
  
==============================================================================*/ 
    
    CREATE TABLE Talebeler
    (
        id CHAR(3), -- PK
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3),
        CONSTRAINT talebe_pk PRIMARY KEY (id)
    );
    
    INSERT INTO Talebeler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO Talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO Talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO Talebeler VALUES(126, 'Nesibe Yýlmaz', 'Ayse',95);
	INSERT INTO Talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

     CREATE TABLE Notlar 
    ( 
        talebe_id char(3), --FK
        ders_adi varchar2(30), 
        yazili_notu number (3), 
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) 
        REFERENCES talebeler(id) ON DELETE CASCADE --on delete cascade sayesinde
       --parent taki silinen bir kayit ile iliskili olan tüm child kayitlarini
       --siler.  DELETE FROM talebeleR WHERE id = 124; yaparsak child daki 124 lerde silinir.
       --mesela bir hastane silindi o hastanedeki bütün kayitlar silinmeli, oda böyle olur.
       --cascade yoksa önce child temizlenir sonra parent
    );

    INSERT INTO Notlar VALUES ('123','kimya',75);
    INSERT INTO Notlar VALUES ('124', 'fizik',65);
    INSERT INTO Notlar VALUES ('125', 'tarih',90);
	INSERT INTO Notlar VALUES ('126', 'Matematik',90);
    
    SELECT * FROM TALEBELER;
    SELECT * FROM NOTLAR;
    
    DELETE FROM Notlar
    WHERE talebe_id = 124;
    
    DELETE FROM Talebeler
    WHERE id = 124;