/*=============================== ALTER TABLE ==================================
    Ic kaporta icin UPDATE (DML), dis kaporta için ALTER (DDL)
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin
    kullanilir.
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de
    kullanilir. 
================================================================================*/
    
    CREATE TABLE personel
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
   
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    
    SELECT * FROM personel;

-- ORNEK 1: personel5 tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan yeni bir sutun ekleyiniz.

ALTER TABLE personel
ADD ulke_isim VARCHAR2(20) DEFAULT 'TURKIYE';

 SELECT * FROM personel;
 
 -- ORNEK 2 personel tablosuna cinsiyet Varchar2(20) ve yas Number(3) seklinde yeni sutunlar ekleyiniz.

ALTER TABLE personel
ADD (cinsiyet VARCHAR2(7),yas NUMBER(3));
 SELECT * FROM personel;
-- ORNEK 3 personel tablosundan yas sutununu siliniz.
ALTER TABLE personel 
DROP COLUMN yas;
SELECT * FROM personel;
 
-- ORNEK 4 personel tablosundaki ulke_isim sutununun adini ulke_adi olarak degistiriniz.
ALTER TABLE personel
RENAME COLUMN ulke_isim TO ulke_adi;
SELECT * FROM personel;

-- ORNEK 5 personel tablosunun adini insan_kaynaklari olarak degistiriniz.
alter table personel
rename to insan_kaynaklari;

select *FROM insan_kaynaklari;


-- ORNEK 6 insan_kaynaklari tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ve VARCHAR2(30) ekleyiniz.
alter table insan_kaynaklari
MODIFY ulke_adi VARCHAR2(30) NOT NULL;

select *FROM insan_kaynaklari;

-- ORNEK 7 maas'a UNIQUE kisitlamasi ekle
    
ALTER TABLE insan_kaynaklari 
MODIFY maas UNIQUE; -- tekrarli maaslar oldugu icin UNIQUE degisikligi yapamayiz
-- BUNU ÇALISTIRMADIK.

-- ORNEK 8 maas'a CHECK kisitlamasi ekleyelim
    
ALTER TABLE insan_kaynaklari 
MODIFY maas CHECK (maas>3000); -- bundan sonra da 3000'den dusuk maas veremem

INSERT INTO insan_kaynaklari VALUES (456715013, 'Ali Sahin','Ankara',2500,'Ford');
-- maas 3000 'den dusuk oldugundan check kisitlamasi devreye girer ve insert into calismaz.


