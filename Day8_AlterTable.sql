/* =============================== ALTER TABLE ====================================
    Ic kaporta icin UPDATE (DML), dis kaporta icin ALTER (DDL)
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin kullanilir.
    
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de kullanilir.
==================================================================================== */

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
INSERT INTO Personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');

SELECT * FROM Personel;

--------------------------------------------------------------------------------------------------------
--ORNEK1: Personel tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan yeni bir sutun ekleyiniz.

ALTER TABLE Personel
ADD ulke_isim VARCHAR(20) DEFAULT 'TURKIYE';


-- ORNEK2: Personel tablosuna cinsiyet VARCHAR2(20) ve yas NUMBER(3) seklinde yeni sutunlar ekleyiniz.
  
ALTER TABLE Personel
ADD (cinsiyet VARCHAR2 (7), yas NUMBER (3));


-- ORNEK3: Personel tablosundan yas sutununu siliniz.

ALTER TABLE Personel
DROP COLUMN yas;


-- ORNEK4: Personel tablosundaki ulke_isim sutununun adini ulke_adi olarak degistiriniz.

ALTER TABLE Personel
RENAME COLUMN ulke_isim TO ulke_adi;


-- ORNEK5: Personel tablosunun adini isciler olarak degistiriniz.

ALTER TABLE Personel
RENAME TO insan_kaynaklari;
SELECT * FROM insan_kaynaklari; -- Artik böyle cagiririz.


-- ORNEK6: Isciler tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ve VARCHAR(30) ekleyiniz.

ALTER TABLE insan_kaynaklari
MODIFY ulke_adi VARCHAR(30) NOT NULL;


-- Maas UNIQUE kisitlamasi ekleyiniz.

ALTER TABLE insan_kaynaklari
MODIFY maas UNIQUE; -- Tekrarli maaslar oldugu icin UNIQUE modify yapilamaz.

-- Check kisitlamasi ekleyelim.

ALTER TABLE insan_kaynaklari
MODIFY maas CHECK (maas>3000); -- Bundan sonrada 3000'den düsük maas verilemez.