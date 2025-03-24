--SORULAR
--Northwind veritabanında toplam kaç tablo vardır? Bu tabloların isimlerini listeleyiniz.
USE Northwind;
GO
SELECT name AS TableName 
FROM sys.tables;

--2. JOIN Sorusu:
--Her sipariş (Orders) için, müşterinin adı (CustomerName), çalışan adı (Employee Full Name), sipariş tarihi ve gönderici şirketin adı (Shipper) ile birlikte bir liste çıkarın.
select o.OrderID
,c.ContactName
,e.FirstName + ' ' + e.LastName as FullName
,o.OrderDate 
,s.CompanyName
from orders o
inner join customers c on c.CustomerID = o.CustomerID
inner join Employees e on e.EmployeeID = o.EmployeeID
inner join Shippers s on s.ShipperID = o.ShipVia


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
