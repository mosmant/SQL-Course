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
   Verileri SELECT komutu ile veritabanýndan çekerken filtreleme yapmak için 
   
   Syntax
   --------
    SELECT ile birlikte WHERE komutu kullanýlabilir. 
   
    SELECT sutün1, sutün2
        ...
    FROM  tablo_adý WHERE koþul;
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
DELETE FROM ogrencýler 
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

-- ORNEK 5 Mehmet Yilmaz ile Veli Han arasýndaki personel bilgilerini listele
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
    IN birden fazla mantýksal ifade ile tanýmlayabileceðimiz durumlarý 
    tek komutla yazabilme imkâný verir

    SYNTAX:
    -------
    SELECT sutun1,sutun2, ...
    FROM tablo_adý
    WHERE sutun_adý IN (deger1, deger2, ...);
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

/*======================= SELECT - LIKE ======================================
    NOT:LIKE anahtar kelimesi, sorgulama yaparken belirli patternleri
    kullanabilmemize olanak saðlar.
    SYNTAX:
    -------
    SELECT sutün1, sutün2,…
    FROM  tablo_adý WHERE sütun LIKE pattern
    PATTERN ÝÇÝN
    -------------
    %    ---> 0 veya daha fazla karakteri belirtir.
    _    ---> Tek bir karakteri temsil eder.
 ==================================================== */
 
-- ORNEK ismi A harfi ile baslayanlari listele?

 SELECT * FROM personel WHERE ýsim LIKE 'A%';
 
 -- Ornek 9: ismi n harfi ile bitenleri listeleyiniz
 
 SELECT * FROM personel WHERE isim LIKE'%n';
?
-- Ornek 10: isminin 2. harfi e olanlarý listeleyiniz

 SELECT * FROM personel WHERE ýsim LIKE '_e%';
?
-- Ornek 11: isminin 2. harfi e olup diðer harflerinde y olanlarý listeleyiniz

? SELECT * FROM personel WHERE isim LIKE '_e%y%';

-- Ornek 12: ismi A ile baþlamayanlarý listeleyiniz

 SELECT * FROM personel WHERE ýsim NOT LIKE 'A%';
?
-- Ornek 13:  isminde a harfi olmayanlarý listeleyiniz
 
 SELECT * FROM personel WHERE isim NOT LIKE '%a%';
?
-- Ornek 14:  maaþýnýn son 2 hanesi 00 olmayanlarý listeleyiniz
? 
SELECT * FROM personel WHERE maas NOT LIKE '%00';

-- Ornek 15:  maaþýnýn 4000 olmayanlarý listeleyiniz

SELECT * FROM personel WHERE maas NOT LIKE '4000';

--   ORNEK18: maaþý 5 haneli olanlarý listeleyiniz

SELECT * FROM personel WHERE maas LIKE'_____';

-- ORNEK20: 1. harfi A ve 7.harfi A olan personeli listeleyiniz.

SELECT * FROM personel WHERE maas LIKE 'A_____a%';

/*======================= SELECT - REGEXP_LIKE ================================
    Daha karmaþýk pattern ile sorgulama iþlemi için REGEXP_LIKE kullanýlabilir.
    Syntax:
    --------
    REGEXP_LIKE(sutun_adý, ‘pattern[] ‘, ‘c’ ] )
             -- 'c' => case-sentisitive demektir ve default case-sensitive aktiftir.
     -- 'i' => incase-sentisitive demektir.
/* ========================================================================== */
    CREATE TABLE kelimeler
    (
        id NUMBER(10) UNIQUE,
        kelime VARCHAR2(50) NOT NULL,
        harf_sayisi NUMBER(6)
    );
    INSERT INTO kelimeler VALUES (1001, 'hot', 3);
    INSERT INTO kelimeler VALUES (1002, 'hat', 3);
    INSERT INTO kelimeler VALUES (1003, 'hit', 3);
    INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
    INSERT INTO kelimeler VALUES (1005, 'hct', 3);
    INSERT INTO kelimeler VALUES (1006, 'adem', 4);
    INSERT INTO kelimeler VALUES (1007, 'selim', 5);
    INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
    INSERT INTO kelimeler VALUES (1009, 'hip', 3);
    INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
    INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
    INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
    INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
    INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
    
-- ORNEK21: Ýçerisinde 'hi' bulunan kelimeleri listeleyeniz

select *from kelimeler where kelime lýke '%hi%'; --1.yol

select *from kelimeler where REGEXP_LIKE (kelime, 'hi');

--ORNEK22: Ýçerisinde 'ot' veya 'at' bulunan kelimeleri listel buyuk kucuk harfe duyarsiz olacak.

select *from kelimeler where REGEXP_LIKE (kelime, 'at|ot','i'); -- sql de veya yazilimi | seklindedir.

--ORNEK24: 'ho' veya 'hi' ile baþlayan kelimeleri büyük-küçük harfe dikkat etmeksizin listeleyeniz

select *from kelimeler where REGEXP_LIKE (kelime, '^ho|^hi','i'); -- ^ bu kullanim baslangic icin

--ORNEK25: Sonu 't' veya 'm' ile bitenleri büyük-küçük harfe dikkat etmeksizin listeleyeniz

select *from kelimeler where REGEXP_LIKE (kelime, 't$|m$','i'); -- $ bu kullanim bitis icin.

--ORNEK26: h ile baþlayýp t ile biten 3 harfli kelimeleri büyük-küçük harfe dikkat etmeksizin listeleyeniz (like ile olmaz case sensitive 'h_t')

select *from kelimeler where REGEXP_LIKE (kelime,'h[a-zA-Z0-9]t','i');  --[oa]vs biseyler yazarsak icindekiler de olabilir. 
--bu kullaným bir ust konudaki like ile cozulemez cunku case sensitive kullanamýyoruz.

--ORNEK28: Ýçinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.
select *from kelimeler where REGEXP_LIKE (kelime, 'm|i|e');  -- veya nin bu sekilde kullanimi 