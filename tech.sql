 --TABLO OLUSTURMA--
CREATE TABLE student
(
id CHAR(4),
name VARCHAR(20),
age NUMBER
);

--VERI GIRISI--
INSERT INTO student VALUES('1001','MEHMET ALA',25);
INSERT INTO student VALUES('1002','AYSE',12);

-- TABLODAN VERI SORGULAMA
SELECT * FROM student;

-- TABLO SILME--
DROP TABLE student;

-- PARCALI VERI GIRISI--
INSERT INTO student(id,name) VALUES ('1003','FATMA');

-- EX: VERI TABANINIZDA URUNLER ADINDA BIR TABLO OLUÞTURUN.
-- urun_id -> NUMBER
-- urun_adi_> VARCHAR(50)
-- fiyat-> NUMBER
-- (100,'cips',5)
-- (200,'kola',6)

CREATE TABLE urunler(
urun_id  NUMBER,
urun_adi VARCHAR(50),
fiyat NUMBER
);
INSERT INTO urunler (urun_id,urun_adi,fiyat)VALUES(100,'cips',5);
INSERT INTO urunler (urun_id,urun_adi,fiyat)VALUES(200,'kola',6);
SELECT * FROM urunler;
