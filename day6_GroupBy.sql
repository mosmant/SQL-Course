/*============================ GROUP BY =====================================
    GROUP BY cümleciði bir SELECT ifadesinde satýrlarý, sutunlarýn deðerlerine
    göre özet olarak gruplamak için kullanýlýr.
    GROUP BY cümleceði her grup baþýna bir satýr döndürür.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlarý ile birlikte kullanýlýr.*/
CREATE TABLE manav
    (
        isim varchar2(50),
        urun_adi varchar2(50),
        urun_miktari number(9)
    );
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);   
    SELECT * FROM manav;
    
--ORNEK1: kisi ismine göre satýlan toplam meyve miktarlarýný gösteren sorguyu
--yazýnýz. ali=>5+2+2+2 sum= meyve sayýlarýný toplucak

SELECT ýsim ,SUM(urun_miktari) AS toplam_urun FROM manav GROUP BY ýsim;

-- isim isim grupladik her ismi 1 kere yaz o isimdeki meyve sayilarini topla ilgili ismin satirinda gostert.

-- ORNEK2: satýlan meyve türüne (urun_adi) göre urun alan kiþi sayýsýný gösteren
-- sorguyu yazýnýz. NULL olarak girilen meyveyi listelemesin.count= elma alan kiþileri sayacak

select urun_adi, count(isim) from manav
where urun_adý IS NOT NULL
GROUP BY urun_adi;

