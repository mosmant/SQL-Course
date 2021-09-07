------SUBQUERY---------------
--Sorgu icinde calisan sorguya subquery (alt sorgu) denir.

-- bu benim yorumum parent child iliskisi olmayan 2 tablo icin kulllanilir. birbirleri ile ayni verileri iceren 2 sutundaki veriler ile baglanti kurmaya calisma yapmaya yarar.
CREATE TABLE personel
(
id NUMBER(9),
isim VARCHAR2(50),
sehir VARCHAR2(50),
maas NUMBER(20),
sirket VARCHAR2(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
INSERT INTO personel VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
INSERT INTO personel VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');

CREATE TABLE sirketler
(
sirket_id NUMBER(9),
sirket_adi VARCHAR2(20),
personel_sayisi NUMBER(20)
);
INSERT INTO sirketler VALUES(100, 'Honda', 12000);
INSERT INTO sirketler VALUES(101, 'Ford', 18000);
INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
INSERT INTO sirketler VALUES(103, 'Toyota', 21000);
INSERT INTO sirketler VALUES(104, 'Mazda', 17000);
SELECT *FROM sirketler;
SELECT * FROM personel;
    
--ORNEK1: PERSONEL SAYISI 15.000�den COK OLAN S�RKETLER�N �S�MLER�N� (alt sorgu �irketler)ve bu
-- sirkette calisan personelin isimlerini ve maa�lar�n� (as�l sorgu personel) listeleyin
SELECT isim, maas, sirket FROM personel
WHERE sirket IN(SELECT sirket_adi FROM sirketler WHERE personel_sayisi>15000);
                    
--ORNEK2: sirket_id�si 101�den b�y�k olan �irket �al��anlar�n�n isim, maa� ve
--�ehirlerini listeleyiniz.
SELECT isim,maas,sehir FROM personel
WHERE sirket IN(SELECT sirket_adi FROM sirketler WHERE sirket_id>101);
                           
--ORNEK3: Ankara�da personeli olan �irketlerin �irket id'lerini ve personel say�lar�n� listeleyiniz
SELECT sirket_id, personel_sayisi FROM sirketler
WHERE sirket_adi IN(SELECT sirket FROM personel WHERE sehir='Ankara');

/* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlar�(SUM,COUNT, MIN,MAX, AVG) Subquery i�inde kullan�labilir.
    Ancak, Sorgu tek bir de�er d�nd�r�yor olmal�d�r.
-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz
--SELECT id,isim,maas
--FROM personel
--WHERE sirket='Honda';
-- bir tablodan tek deger getirebilmek icin ortalama AVG , toplam SUM, adet COUNT, MIN, MAX  gibi
-- fonksiyonlar kullanilir ve bu fonksiyonlara AGGREGATE FONKSIYONLAR denir
==============================================================================*/ 

--ORNEK4: Her �irketin ismini, personel say�s�n� ve o �irkete ait personelin
--toplam maa��n� listeleyen bir Sorgu yaz�n�z.
SELECT sirket_adi, personel_sayisi, (SELECT SUM(maas)FROM  personel WHERE sirketler1.sirket_adi=personel2.sirket) AS toplam_maas
FROM s�rketler;  
            
     
--ORNEK5: Her �irketin ismini, personel say�s�n� ve o �irkete ait personelin
--  ortalama maa��n� listeleyen bir Sorgu yaz�n�z.

SELECT sirket_adi , personel_sayisi, (SELECT ROUND(AVG(maas)) FROM personel WHERE sirket_adi=sirket)AS ort_maas
FROM sirketler;

-- ROUND YUVARLAMA YAPAR AVG MAAS 2666.66666...  GIBI CIKAR. ROUND KULLANARAK YUVARLAMA KURALLARINA UYDUK.

-- ORNEK6: Her �irketin ismini, personel say�s�n� ve o �irkete ait personelin
-- maksimum ve minumum maa��n� listeleyen bir Sorgu yaz�n�z.

SELECT sirket_adi,personel_sayisi, (SELECT MAX(maas) FROM personel WHERE sirket_adi= sirket ) AS max_maas,(Select MIN(maas) FROM personel WHERE sirket_adi= sirket )AS min_maas
FROM sirketler;

-- burada tek () max ve min yazilamaz. pl oracle bunlardan hangisini sececegine karar veremeyebilir.

-- ORNEK7: Her sirketin id�sini, ismini ve toplam ka� �ehirde bulundu�unu
-- listeleyen bir SORGU yaz�n�z.

SELECT sirket_id,sirket_adi,(select count(sehir) from personel where sirket_adi=sirket ) as sehir_sayisi
FROM sirketler;

