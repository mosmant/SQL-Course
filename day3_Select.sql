-------- SELECT - WHERE --------

CREATE TABLE ogrenciler
(
id NUMBER(9),
isim VARCHAR2(50),
adres VARCHAR2(100),
sinav_notu NUMBER(3)
);

DROP TABLE ogrenciler;
INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Ankara',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ankara',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Istanbul',85);
SELECT * FROM ogrenciler;

/* ============================================================================
   Verileri SELECT komutu ile veritaban�ndan �ekerken filtreleme yapmak i�in 
   
   Syntax
   --------
    SELECT ile birlikte WHERE komutu kullan�labilir. 
   
    SELECT sut�n1, sut�n2
        ...
    FROM  tablo_ad� WHERE ko�ul;
==============================================================================*/

-- ORNEK 1: SINAV NOTU 80 DEN BUYUK OLAN TUM OGRENCILERIN BILGILERINI LISTELE...
SELECT * FROM ogrenciler 
WHERE sinav_notu>80;
--=====================================================================
-- ORNEK 2: ADRESI ANKARA OLAN OGRENCILERIN ISIM ADRES BILGILERI LISTELE...
SELECT isim, adres FROM ogrenciler --once sec soruda isim ve adres giriliyor.
WHERE adres='Ankara';              --sonra sarti gir.

--=====================================================================

-- ORNEK 3: ID SI 124 OLAN OGRENCILERIN TUM BILGILERINI SIL...
DELETE FROM ogrenc�ler 
WHERE id=124; 
SELECT * FROM ogrenciler;
-- NOT : DELETE ISLEMI YAPILDIKTAN SONRA "SELECT * FROM table" 
-- YAZILMALI KI DEGISIKLIGI GOREBILELIM.

CREATE TABLE personel
(
id CHAR(5),
isim VARCHAR2(50),
maas NUMBER(5)
);

drop table personel;
INSERT INTO personel VALUES('10001', 'Ahmet Aslan', 7000);
INSERT INTO personel VALUES( '10002', 'Mehmet Yilmaz' ,12000);
INSERT INTO personel VALUES('10003', 'Meryem ', 7215);
INSERT INTO personel VALUES('10004', 'Veli Han', 5000);
INSERT INTO personel VALUES('10005', 'Mustafa Ali', 5500);
INSERT INTO personel VALUES('10005', 'Ayse Can', 4000);
SELECT * FROM personel;
    
-- ORNEK 4 ID SI 10002 ILE 10005 ARASINDA OLAN PERSONELIN BILGILERINI LISTELE
--1.YOL
SELECT * FROM personel 
WHERE id BETWEEN '10002' AND '10005'
-- 2.YOL 
SELECT * FROM personel
WHERE  id >= '10002' AND id <= '10005';

-- ORNEK 5 Mehmet Yilmaz ile Veli Han aras�ndaki personel bilgilerini listele
-- sql bu durumda alfabetik siralamaya bakarak filtreliyecek.

SELECT* FROM personel
WHERE isim BETWEEN 'Mehmet Yilmaz' AND 'Veli Han';

-- isim = 'Mehmet Yilmaz' and isim ='Veli Han' seklinde yazilmaz.

--ORNEK 6 10002 -10004 ARASINDA OLMAYAN PERSONELIN ID VE MAASINI LISTELE...
SELECT id,maas FROM personel
WHERE id NOT BETWEEN  '10002' AND '10004';

-- between de belirtilenler dahildir. not between de bunlarin disindakiler olacak.
--==============================================================================

-------- SELECT - IN --------
/* ======================= SELECT - IN ======================================
    IN birden fazla mant�ksal ifade ile tan�mlayabilece�imiz durumlar� 
    tek komutla yazabilme imk�n� verir

    SYNTAX:
    -------
    SELECT sutun1,sutun2, ...
    FROM tablo_ad�
    WHERE sutun_ad� IN (deger1, deger2, ...);
/* ========================================================================== */


-- ORNEK 7: MAASI 4000, 5000, VE 7000 OLAN PERSONELIN BILGILERINI LISTELE...
SELECT * FROM personel
WHERE maas IN (4000,5000,7000); -- PARANTEZ ICINDEKI HERKESI AL DEMEK.

-- *** NOT BETWEEN 4000 AND 7000 OLSAYDI 5500 ARAYA GIRERDI.
--2.YOL
SELECT * FROM personel
WHERE maas = 4000 OR maas = 7000 OR maas=5000;

-- ORNEK 8 VELI HAN ILE AHMET ASLAN ARASINDAKILERI BULAN LISTE...
SELECT * FROM personel
WHERE isim IN('Veli Han','Ahmet Aslan');







