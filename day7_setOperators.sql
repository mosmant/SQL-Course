/*==================== SET (küme) OPERATORLERI: UNION, UNION ALL======================
    set=küme diyelim diðer set (sql komutu) ile karýþmasýn
    UNION, UNION ALL, INTERSECT, ve MINUS gibi SET operatorleri yardimiyla  
    Çoklu Sorgular birlestirilebilirler.ayný tablodan yada farklý tablodan sütunlarý birleþtirip ayný sütunda yazdýrma
?
UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc kumelerini birlesitirerek tek bir sonuc kumesi olusturur. (iki kümenin birleþimi)   
-- UNION 
-- Eger tek sorguda birlestiremeyecegim iki sorgunun sonucunu ayni tabloda 
-- gormek istersek UNION islemi kullanilir
-- BU durumda dikkat etmemiz gereken konu iki sorguda da field sayisi ve 
-- alt alta gelecek field data tiplerinin ayni olmasidir
?
    
-- UNION ALL komutu ise tekrara bakmaksizin iki sorgudan gelen tum sonuclari listeler
-- UNION ALL komutunda da iki sorgunun sonucunun esit sayida field'a ve data 
-- tiplerine sahip olmasi gereklidir
?
     SÜTUN birleþtirme=> SET
     TABLO birleþtirme=> JOIN
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT: UNION operatoru SADECE benzersiz degerleri alýr. Benzerli verileri almak
    için UNION ALL kullanýlýr.
==============================================================================*/

 CREATE TABLE personel 
    (
        id NUMBER(9), 
        isim VARCHAR2(50), 
        sehir VARCHAR2(50), 
        maas NUMBER(20), 
        sirket VARCHAR2(20)
        --CONSTRAINT personel_pk PRIMARY KEY(id)
    );
    
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');

SELECT * FROM personel;
 /* -----------------------------------------------------------------------------
  ORNEK1: Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas 
  alinan sehirleri gosteren sorguyu yaziniz.
------------------------------------------------------------------------------*/
SELECT isim AS isim_veya_sehir,maas  from personel
where maas>4000
UNION ALL
select sehir,maas from personel
where maas>5000;
-- UNION ALL yazdigimiz zaman tum satýrlardaki elemanlari aldi. 9 sutun var.

SELECT isim AS isim_veya_sehir,maas  from personel
where maas>4000
UNION
select sehir,maas from personel
where maas>5000;

-- UNION yazdigim zaman tekrar eden satirlardaki elemanlari almaz.unique dir. 8 sutun var.

/* -----------------------------------------------------------------------------
  ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki 
  personelin maaslarini yüksekten alçaða doðru sýralayarak bir tabloda gosteren 
  sorguyu yaziniz.    
------------------------------------------------------------------------------*/  

select isim AS isim_sehir,maas from personel
where isim ='Mehmet Ozturk'
UNION
-- TEKRARSIZ BIRLESTIRME YAPTIM.. satirlarin tamami ayný olmalý.
select sehir,maas from personel
where sehir ='Istanbul' 
order by maas desc;
-- MAASI AZALAN SEKILDE YAZDIR DESCENDING

/*======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/   
 --   hata verirse personel i sil bir daha create et
    CREATE TABLE personel_bilgi 
    (
        id NUMBER(9), 
        tel char(10) UNIQUE , 
        cocuk_sayisi NUMBER(2) 
       -- CONSTRAINT fk_personel FOREIGN KEY (id) REFERENCES personel(id) 
    ); 
    
    INSERT INTO personel_bilgi VALUES(123456789, '5302345678' , 5);
    INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
    INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3); 
    INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
    INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
    INSERT INTO personel_bilgi VALUES(453445611, '5524578574', 2);
    INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);
?
    SELECT * FROM personel_bilgi;
?
/* -----------------------------------------------------------------------------
  ORNEK4: id’si 123456789 olan personelin Personel tablosundan sehir ve 
  maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin  
------------------------------------------------------------------------------*/    
    --console da ilk select teki isimler çýkar
    SELECT sehir AS sehir_tel, maas AS maas_cocukSayisi
    FROM personel
    WHERE id = 123456789
    UNION 
    SELECT tel, cocuk_sayisi
    FROM personel_bilgi
    WHERE id = 123456789;
    
    -- sehir ile tel, maas ile cocuk ayni sutunda birlestiði icin veri tipleri
    -- uygun olmalidir.
     
/*========================= SET OPERATORLERI: INTERSECT ========================
    --ýntersect=> iki kümenin kesiþimini döndürür
    INTERSECT operarotu 2 veya daha fazla Sorgu ifadesinin sonuclarini 
    dondurmek icin kullanilir. Ancak, intersect SADECE tum sorgularin ortak 
    verilerini (kesimlerini) dondurur. 
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    INTERSECT
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
==============================================================================*/
?
/* -----------------------------------------------------------------------------
  ORNEK5: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini
  sorgulayiniz. 
 
  Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.
  Bu iki sorguyu INTERSECT ile birlesitiriniz.
------------------------------------------------------------------------------*/
    
    SELECT id FROM personel
    WHERE sehir IN('Istanbul','Ankara')
    INTERSECT
    SELECT id FROM personel_bilgi
   WHERE cocuk_sayýsý IN (2,3);--2 olanlar veya 3 olanlar demek (IN)
      --WHERE cocuk_sayisi = 2 or cocuk_sayýsý=3; üsttekiyle ayný þey
?
  
/* -----------------------------------------------------------------------------
  ORNEK6: Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
------------------------------------------------------------------------------*/  
    --UNION yazarsak istenen herþeyi alýr gelir (tofas+honda+ford), INTERSECT ortaklarý alýyor
    SELECT isim FROM personel
    WHERE sirket = 'Honda'
    INTERSECT
    SELECT isim FROM personel
    WHERE sirket = 'Ford'
    INTERSECT
    SELECT isim FROM personel
    WHERE sirket = 'Tofas';

-- tek satirda birkac veri birden isteniyorsa and ile birlesir 
-- farkli satirlardan oertaklik isteniyorsa INTERSECT kullanilir.

/* -----------------------------------------------------------------------------
  ORNEK7: Toyota ve Ford sirketlerinde ayni maasi alan personel isimlerini
  listeleyin
------------------------------------------------------------------------------*/    

select isim, maas from  personel
where sirket ='Toyota'
INTERSECT
select isim, maas from  personel
where sirket ='Ford';

-- iki þeyin ortaklýðý baþka yolla olmaz (AND OR gibi yollarla olmaz)4 lü tablo kümesi gibi çünkü. 
-- normal küme olacaksa AND olur. altlarda var,3 yöntemli soru

-- bazý iþlemleri AND ile yapabilirdik
-- INTERSECT islemi mantik olarak AND komutu ile aynidir(isim...and sehir...olur.sirket... and sirket... olmaz)
-- ancak INTERSECT ile cozulen her soru AND ile cozulemez

/*========================= SET OPERATORLERI: MINUS ============================
    
    MINUS operatoru ilk Sorgu ifadesinde olup da diger sorgu ifadesinde olmayan 
    verileri dondurur. Yani 1. sorgu ile 2. sorgu arasindaki farklý olanlarý 
    dondurur
    
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    MINUS
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
==============================================================================*/
?
?
/* -----------------------------------------------------------------------------
  ORNEK8: 5000’den az maas alan ve Honda calisani olmayanlarýn bilgilerini
  listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 
-- 1.yontem
select isim , maas, sirket from personel
where maas <5000
INTERSECT
select isim, maas,sirket from personel
where sirket != 'Honda';

--2.yol

select isim , maas, sirket from personel
where maas <5000
MINUS
select isim, maas,sirket from personel
where sirket = 'Honda';


--3. YÖNTEM-------
SELECT isim,maas, sirket 
FROM personel
WHERE maas < 5000 AND sirket!='Honda';

/* -----------------------------------------------------------------------------
  ORNEK8: Ismi Mehmet Ozturk olup Izmir’de calismayanlarin isimlerini ve 
  sehirlerini listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/

select isim,sehir from personel
where isim = 'Mehmet Ozturk'

MINUS
select isim,sehir from personel
where sehir = 'Izmir';

-- MINUS ta UNION gibi tekrarli satirlardan sadece birini yazdirir.

