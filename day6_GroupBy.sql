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

SELECT urun_adi, COUNT(isim) FROM manav
WHERE urun_adý IS NOT NULL
GROUP BY urun_adi;

-- ORNEK3: satýlan meyve türüne (URUN_ADÝ) göre satýlan (urun_miktari )MIN ve
-- MAX urun miktarlarini, MAX urun miktarina göre SIRALAYARAK listeyen sorguyu yazýnýz.not null olmasýn

SELECT urun_adi, MIN(urun_miktari), MAX(urun_miktari) FROM manav WHERE urun_adi IS NOT NULL
GROUP BY urun_adi ORDER BY MAX(urun_miktari) DESC;

--======= KOMUT HIYERASISI =======--
-- SELECT, FROM 
-- WHERE  gruplamadan bazý þartlara göre bazýlarýný ele
-- GROUP BY özelliklerine göre grupla
-- HAVING grup özelliklerine göre þartla ele. ya where ya having yani
-- ORDER BY bu gruplarý istenilen özelliðe göre sýrala
-- FETCH 

-- ORNEK4: kisi ismine ve urun adýna (select) göre satýlan ürünlerin (sum)toplamýný
-- gruplandýran ve önce isme göre sonra urun_adi na göre ters sýrayla (order by) listeyen sorguyu yazýnýz.
-- önce isme göre sonra meyvelere

SELECT ýsim, urun_adi ,SUM(urun_miktari) FROM manav -- manavtablosundan 3 sey sectim. isim urun adi, uruntoplamý
GROUP BY ýsim  , urun_adi  -- isimleri ve urun adlarini gruplandirdim
ORDER BY ýsim ASC, urun_adi DESC; -- isimi duz urun_adini ters siraladim.

-- ORNEK5: kisi ISMÝNE ve URUN ADINA göre, satýlan ürünlerin toplamýný bulan ve
-- ve bu toplam deðeri 3 ve fazlasý olan kayýtlarý toplam urun miktarlarina göre
-- ters siralayarak listeyen sorguyu yazýnýz.
 
SELECT isim, urun_adi, SUM(urun_miktari) FROM manav
GROUP BY isim,urun_adi HAVING SUM (urun_miktari)>=3
ORDER BY SUM(urun_miktari) DESC;

-- having tabloda yer almayan ve tablolardaki verilerden elde ettigiimiz toplam ve diger islemler icin kullanýrýz. where kullanamyayiz.aggregate

-- ORNEK6: satýlan urun_adi'na göre gruplayýp MAX urun sayýlarýný,(yine max ürün sayýsýna göre)
-- sýralayarak listeyen sorguyu yazýnýz. NOT: Sorgu, sadece MAKS urun_miktari
-- MIN urun_miktarýna eþit olmayan kayýtlarý (where gibi koþul var) listelemelidir

SELECT urun_adi, MAX(urun_miktari) esit_olmayanlar FROM manav
GROUP BY urun_adi HAVING MAX (urun_miktari)!= min(urun_miktari)
ORDER BY MAX(urun_miktari);

/*============================= DISTINCT =====================================
    DISTINCT cümleciði bir SORGU ifadesinde benzer olan satýrlarý flitrelemek
    için kullanýlýr. Dolayýsýyla seçilen sutun yada sutunlar için benzersiz veri
    içeren satýrlar oluþturmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_adý;**/
    
--ORNEK1: satýlan farklý meyve türlerinin sayýsýný listeyen sorguyu yazýnýz.
-- (kaç farklý meyve türü var, elma armut üzüm=3)   

SELECT COUNT(DISTINCT urun_adi) urun_cesit_sayisi FROM manav;
    
-- ORNEK2: satilan meyve adi ve isimlerin (totalde )farkli olanlarini listeyen sorguyu yaziniz.    

SELECT DISTINCT urun_adi, isim from manav;

-- ORNEK3: satýlan meyvelerin urun_mikarlarinin benzersiz  olanlarýnýn
-- toplamlarini listeyen sorguyu yazýnýz.2+3+4+5=14
select SUM(DISTINCT urun_miktari) benzersiz_urun_toplami FROM manav;
    
    
    
    
    
    
    
    
    
    
    
    
    
    




