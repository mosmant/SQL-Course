------ UPDATE - SET ------
/*-- A�a��daki gibi tedarikciler ad�nda bir tablo olu�turunuz ve vergi_no
-- sutununu primary key yap�n�z. Ayr�ca a�a��daki verileri tabloya giriniz.
    vergi_no NUMBER(3),
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50),
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huawei', '�in Li');
	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
--Sonras�nda a�a��daki gibi urunler ad�nda bir ba�ka tablo olu�turunuz ve bu
--tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
--ili�kilendiriniz. Verileri giriniz.
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
    INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ay�e Can');
    INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan �z');
    INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Y�lmaz');*/

CREATE TABLE tedarikciler1(
vergi_no NUMBER(3) PRIMARY KEY,
firma_ismi VARCHAR2(50),
irtibat_ismi VARCHAR2(50)
);

INSERT INTO tedarikciler1 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler1 VALUES (102, 'Huawei', '�in Li');
INSERT INTO tedarikciler1 VALUES (103, 'Erikson', 'Maki Tammamen');
INSERT INTO tedarikciler1 VALUES (104, 'Apple', 'Adam Eve');

SELECT * FROM tedarikciler1;

CREATE TABLE urunler1(
ted_vergino NUMBER(3),
urun_id NUMBER(11),
urun_isim VARCHAR2(50),
musteri_isim VARCHAR2(50),
CONSTRAINT urunler_fk FOREIGN KEY (ted_vergino) REFERENCES tedarikciler1(vergi_no) -- burada table lari birbirine ba�lad�k vergi nolar
);

INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ay�e Can');
INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan �z');
INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Y�lmaz');

SELECT * FROM urunler1;
-- ====================================================================
-- SYNTAX
----------
-- UPDATE tablo_ad�
-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
-- WHERE ko�ul;
-- ====================================================================
-- ORNEK 1 VERGI NOSU 101 OLAN TEDARIKCININ FIRMA ISMINI 'LG'OLARAK GUNCELLEYIN.
UPDATE tedarikciler1
SET firma_ismi='LG'
WHERE vergi_no='101';
SELECT * FROM tedarikciler1;
-- BURADA tedarikciler tablosundaki vergi no 101 olan firma ismini LG olarak degistirdik.
-- ====================================================================
-- ORNEK 2 TEDARIKCILER TABLOSUNDAKI TUM FIRMA ISIMLERINI SAMSUNG OLARAK GUNCELLE
UPDATE tedarikciler1
SET firma_ismi='SAMSUNG';
SELECT * FROM tedarikciler1;

-- burada tedarikciler listesindeki firma isimlerinin tamam�n� SAMSUNG olarak degistirdik
-- ====================================================================
-- ORNEK3: vergi_no�su 102 olan tedarikcinin ismini 'lENOVO' ve irtibat_ismi�ni 'Ali Veli' olarak g�ncelleyeniz.
UPDATE tedarikciler1
SET firma_ismi='LENOVO', irtibat_ismi= 'Ali Veli'
WHERE vergi_no=102;
SELECT * FROM tedarikciler1;
-- burda tedarikciler de vergi no 102 olan�n firma ismi lenovo irt ismi ali veli oldu.
-- ====================================================================
-- ORNEK4: firma ismi samsung olan tedarikcinin irt ismini ayse yilmaz olarak guncelleyiniz.
UPDATE tedarikciler1
SET irtibat_ismi= 'Ayse Yilmaz'
WHERE firma_ismi= 'SAMSUNG';
SELECT * FROM tedarikciler1;
-- burada tedariciler tablosundan firma ismi samsung olanlar�n irt ismi ayse yilmaz oldu.
-- ====================================================================
-- ORNEK5:urunler tablosundaki urun_id de�eri 1004'ten b�y�k olanlar�n urun_id de�erlerini bir artt�r�n�z
UPDATE urunler1
SET urun_id=urun_id+1
WHERE urun_id >1004;
SELECT * FROM urunler1;
-- burada urun_id si 1004 den buyuk olanlar�n urun id si 1005=> 1006 1006=> 1007 seklinde oldu.
-- ====================================================================
-- ORNEK6: urunler tablosundaki tum urunlerin urun_id degerini ted_vergino sutun degeri ile toplayarak guncelleyiniz.
UPDATE urunler1
SET urun_id = ted_vergino+ urun_id;
SELECT * FROM urunler1;

-- burada tum urunler�n dedigi icin WHERE kullanmazsak tablonun tamamina uygulanacak.
-- ====================================================================
-- ORNEK7:urunler tablosundan Ali Veli�in aldigi urunun ismini, TEDAR�KC� TABLOSUNDA �RT�BAT_�SM� 'Ayse Yilmaz' OLAN F�RMANIN �SM� (F�RMA_�SM�) ile degistiriniz.
DROP TABLE 
UPDATE urunler1
SET urun_isim = (SELECT firma_ismi FROM tedarikciler1
WHERE irtibat_ismi = 'Ayse Yilmaz')
WHERE musteri_isim= 'Ali Veli';
SELECT * FROM urunler1;
-- burada hoca adam eve olarak yazdi fakat adam eve yukarilarda birkac kez update oldu. o yuzden hata verdi soruyu basta ayse yilmaz yapsayd� sorun olmayacakti.
-- asil onemli olan set kisiminda ( ) icindeki select from where kisimi.


