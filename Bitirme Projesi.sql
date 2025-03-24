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
select sum(o.UnitPrice) as ToplamTutar
from dbo.[Order Details] o

--4. Gruplama:
--Hangi ülkeden kaç müşteri vardır?
select c.Country
,count(*)
from Customers c
group by c.Country
order by 2 

--5.Subquery Kullanımı:
--En pahalı ürünün adını ve fiyatını listeleyiniz.
select p.ProductName
,p.UnitPrice
from Products p
where p.UnitPrice = (
select max(unitprice)
from Products
)

--6. Çalışan başına düşen sipariş sayısını gösteren bir liste çıkarınız.
select o.EmployeeID
,count(o.orderID) as SiparisSayisi
from Orders o
group by o.EmployeeID



--7. 1997 yılında verilen siparişleri listeleyin.
select *
from Orders o
where year(o.OrderDate) = 1997 

--8. Ürünleri fiyat aralıklarına göre kategorilere ayırarak listeleyin: 020 → Ucuz, 2050 → Orta, 50+ → Pahalı.

--9. Nested Subquery:
--En çok sipariş verilen ürünün adını ve sipariş adedini (adet bazında) bulun.
--10. View Oluşturma:
--Ürünler ve kategoriler bilgilerini birleştiren bir görünüm (view) oluşturun.
