/*============================ GROUP BY =====================================
    GROUP BY c�mleci�i bir SELECT ifadesinde sat�rlar�, sutunlar�n de�erlerine
    g�re �zet olarak gruplamak i�in kullan�l�r.
    GROUP BY c�mlece�i her grup ba��na bir sat�r d�nd�r�r.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlar� ile birlikte kullan�l�r.*/
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
    
--ORNEK1: kisi ismine g�re sat�lan toplam meyve miktarlar�n� g�steren sorguyu
--yaz�n�z. ali=>5+2+2+2 sum= meyve say�lar�n� toplucak

SELECT �sim ,SUM(urun_miktari) AS toplam_urun FROM manav GROUP BY �sim;

-- isim isim grupladik her ismi 1 kere yaz o isimdeki meyve sayilarini topla ilgili ismin satirinda gostert.

-- ORNEK2: sat�lan meyve t�r�ne (urun_adi) g�re urun alan ki�i say�s�n� g�steren
-- sorguyu yaz�n�z. NULL olarak girilen meyveyi listelemesin.count= elma alan ki�ileri sayacak

SELECT urun_adi, COUNT(isim) FROM manav
WHERE urun_ad� IS NOT NULL
GROUP BY urun_adi;

-- ORNEK3: sat�lan meyve t�r�ne (URUN_AD�) g�re sat�lan (urun_miktari )MIN ve
-- MAX urun miktarlarini, MAX urun miktarina g�re SIRALAYARAK listeyen sorguyu yaz�n�z.not null olmas�n

SELECT urun_adi, MIN(urun_miktari), MAX(urun_miktari) FROM manav WHERE urun_adi IS NOT NULL
GROUP BY urun_adi ORDER BY MAX(urun_miktari) DESC;

--======= KOMUT HIYERASISI =======--
-- SELECT, FROM 
-- WHERE  gruplamadan baz� �artlara g�re baz�lar�n� ele
-- GROUP BY �zelliklerine g�re grupla
-- HAVING grup �zelliklerine g�re �artla ele. ya where ya having yani
-- ORDER BY bu gruplar� istenilen �zelli�e g�re s�rala
-- FETCH 

-- ORNEK4: kisi ismine ve urun ad�na (select) g�re sat�lan �r�nlerin (sum)toplam�n�
-- grupland�ran ve �nce isme g�re sonra urun_adi na g�re ters s�rayla (order by) listeyen sorguyu yaz�n�z.
-- �nce isme g�re sonra meyvelere

SELECT �sim, urun_adi ,SUM(urun_miktari) FROM manav -- manavtablosundan 3 sey sectim. isim urun adi, uruntoplam�
GROUP BY �sim  , urun_adi  -- isimleri ve urun adlarini gruplandirdim
ORDER BY �sim ASC, urun_adi DESC; -- isimi duz urun_adini ters siraladim.

-- ORNEK5: kisi ISM�NE ve URUN ADINA g�re, sat�lan �r�nlerin toplam�n� bulan ve
-- ve bu toplam de�eri 3 ve fazlas� olan kay�tlar� toplam urun miktarlarina g�re
-- ters siralayarak listeyen sorguyu yaz�n�z.
 
SELECT isim, urun_adi, SUM(urun_miktari) FROM manav
GROUP BY isim,urun_adi HAVING SUM (urun_miktari)>=3
ORDER BY SUM(urun_miktari) DESC;

-- having tabloda yer almayan ve tablolardaki verilerden elde ettigiimiz toplam ve diger islemler icin kullan�r�z. where kullanamyayiz.aggregate

-- ORNEK6: sat�lan urun_adi'na g�re gruplay�p MAX urun say�lar�n�,(yine max �r�n say�s�na g�re)
-- s�ralayarak listeyen sorguyu yaz�n�z. NOT: Sorgu, sadece MAKS urun_miktari
-- MIN urun_miktar�na e�it olmayan kay�tlar� (where gibi ko�ul var) listelemelidir

SELECT urun_adi, MAX(urun_miktari) esit_olmayanlar FROM manav
GROUP BY urun_adi HAVING MAX (urun_miktari)!= min(urun_miktari)
ORDER BY MAX(urun_miktari);

/*============================= DISTINCT =====================================
    DISTINCT c�mleci�i bir SORGU ifadesinde benzer olan sat�rlar� flitrelemek
    i�in kullan�l�r. Dolay�s�yla se�ilen sutun yada sutunlar i�in benzersiz veri
    i�eren sat�rlar olu�turmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_ad�;**/
    
--ORNEK1: sat�lan farkl� meyve t�rlerinin say�s�n� listeyen sorguyu yaz�n�z.
-- (ka� farkl� meyve t�r� var, elma armut �z�m=3)   

SELECT COUNT(DISTINCT urun_adi) urun_cesit_sayisi FROM manav;
    
-- ORNEK2: satilan meyve adi ve isimlerin (totalde )farkli olanlarini listeyen sorguyu yaziniz.    

SELECT DISTINCT urun_adi, isim from manav;

-- ORNEK3: sat�lan meyvelerin urun_mikarlarinin benzersiz  olanlar�n�n
-- toplamlarini listeyen sorguyu yaz�n�z.2+3+4+5=14
select SUM(DISTINCT urun_miktari) benzersiz_urun_toplami FROM manav;
    
    
    
    
    
    
    
    
    
    
    
    
    
    




