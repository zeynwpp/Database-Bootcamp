--SORULAR
--Northwind veritabanında toplam kaç tablo vardır? Bu tabloların isimlerini listeleyiniz.
USE Northwind;
GO
SELECT name AS TableName 
FROM sys.tables;

--2. JOIN Sorusu:
--Her sipariş (Orders) için, müşterinin adı (CustomerName), çalışan adı (Employee Full Name), sipariş tarihi ve gönderici şirketin adı (Shipper) ile birlikte bir liste çıkarın.

--3. Aggregate Fonksiyon:
--Tüm siparişlerin toplam tutarını bulun. (Order Details tablosundaki Quantity UnitPrice üzerinden
--hesaplayınız)
--4. Gruplama:
--Hangi ülkeden kaç müşteri vardır?
--5.Subquery Kullanımı:
--En pahalı ürünün adını ve fiyatını listeleyiniz.
--6. JOIN ve Aggregate:
-- Çalışan başına düşen sipariş sayısını gösteren bir liste çıkarınız.
--7. Tarih Filtreleme:
--1997 yılında verilen siparişleri listeleyin.
