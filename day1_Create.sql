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
--tablodan veri sorgulama--
SELECT * FROM student;
--* bu isaret tum tabloyu getirir--
--tablo silme--
DROP TABLE student;
--PARCALI VERI GIRISI--
INSERT INTO student(id,name) VALUES('1003','FATMA');
--veri tabaninizda urunler adinda bir tablo olusturun.
--urun_ id==>number
--urun_adi=>VARCHAR(50)
--fiyat=>number
--(100,cips,5)
--(200,kola,6)
CREATE TABLE urunler(
urun_id NUMBER,
urun_name VARCHAR(50),
fiyat NUMBER
);
INSERT INTO urunler VALUES(100,'cips',5);
INSERT INTO urunler VALUES(200,'kola',6);
SELECT*FROM urunler;


drop table urunler;