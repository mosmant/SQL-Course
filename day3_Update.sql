------ UPDATE - SET ------
/*-- Aþaðýdaki gibi tedarikciler adýnda bir tablo oluþturunuz ve vergi_no
-- sutununu primary key yapýnýz. Ayrýca aþaðýdaki verileri tabloya giriniz.
    vergi_no NUMBER(3),
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50),
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
--Sonrasýnda aþaðýdaki gibi urunler adýnda bir baþka tablo oluþturunuz ve bu
--tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
--iliþkilendiriniz. Verileri giriniz.
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
    INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayþe Can');
    INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yýlmaz');*/

CREATE TABLE tedarikciler1(
vergi_no NUMBER(3) PRIMARY KEY,
firma_ismi VARCHAR2(50),
irtibat_ismi VARCHAR2(50)
);

INSERT INTO tedarikciler1 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler1 VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler1 VALUES (103, 'Erikson', 'Maki Tammamen');
INSERT INTO tedarikciler1 VALUES (104, 'Apple', 'Adam Eve');

SELECT * FROM tedarikciler1;

CREATE TABLE urunler1(
ted_vergino NUMBER(3),
urun_id NUMBER(11),
urun_isim VARCHAR2(50),
musteri_isim VARCHAR2(50),
CONSTRAINT urunler_fk FOREIGN KEY (ted_vergino) REFERENCES tedarikciler1(vergi_no) -- burada table lari birbirine baðladýk vergi nolar
);

INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ayþe Can');
INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Yýlmaz');

SELECT * FROM urunler1;
-- ====================================================================
-- SYNTAX
----------
-- UPDATE tablo_adý
-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
-- WHERE koþul;
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

-- burada tedarikciler listesindeki firma isimlerinin tamamýný SAMSUNG olarak degistirdik
-- ====================================================================
-- ORNEK3: vergi_no’su 102 olan tedarikcinin ismini 'lENOVO' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyeniz.
UPDATE tedarikciler1
SET firma_ismi='LENOVO', irtibat_ismi= 'Ali Veli'
WHERE vergi_no=102;
SELECT * FROM tedarikciler1;
-- burda tedarikciler de vergi no 102 olanýn firma ismi lenovo irt ismi ali veli oldu.
-- ====================================================================
-- ORNEK4: firma ismi samsung olan tedarikcinin irt ismini ayse yilmaz olarak guncelleyiniz.
UPDATE tedarikciler1
SET irtibat_ismi= 'Ayse Yilmaz'
WHERE firma_ismi= 'SAMSUNG';
SELECT * FROM tedarikciler1;
-- burada tedariciler tablosundan firma ismi samsung olanlarýn irt ismi ayse yilmaz oldu.
-- ====================================================================
-- ORNEK5:urunler tablosundaki urun_id deðeri 1004'ten büyük olanlarýn urun_id deðerlerini bir arttýrýnýz
UPDATE urunler1
SET urun_id=urun_id+1
WHERE urun_id >1004;
SELECT * FROM urunler1;
-- burada urun_id si 1004 den buyuk olanlarýn urun id si 1005=> 1006 1006=> 1007 seklinde oldu.
-- ====================================================================
-- ORNEK6: urunler tablosundaki tum urunlerin urun_id degerini ted_vergino sutun degeri ile toplayarak guncelleyiniz.
UPDATE urunler1
SET urun_id = ted_vergino+ urun_id;
SELECT * FROM urunler1;

-- burada tum urunlerýn dedigi icin WHERE kullanmazsak tablonun tamamina uygulanacak.
-- ====================================================================
-- ORNEK7:urunler tablosundan Ali Veli’in aldigi urunun ismini, TEDARÝKCÝ TABLOSUNDA ÝRTÝBAT_ÝSMÝ 'Ayse Yilmaz' OLAN FÝRMANIN ÝSMÝ (FÝRMA_ÝSMÝ) ile degistiriniz.
DROP TABLE 
UPDATE urunler1
SET urun_isim = (SELECT firma_ismi FROM tedarikciler1
WHERE irtibat_ismi = 'Ayse Yilmaz')
WHERE musteri_isim= 'Ali Veli';
SELECT * FROM urunler1;
-- burada hoca adam eve olarak yazdi fakat adam eve yukarilarda birkac kez update oldu. o yuzden hata verdi soruyu basta ayse yilmaz yapsaydý sorun olmayacakti.
-- asil onemli olan set kisiminda ( ) icindeki select from where kisimi.


