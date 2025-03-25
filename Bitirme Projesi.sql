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
select p.productID,
case when p.UnitPrice <= 20 then 'Ucuz'
when p.UnitPrice <= 50 then 'Orta'
when p.UnitPrice > 50 then 'Pahalı'
end as Kategori
from Products p

--9. Nested Subquery:
--En çok sipariş verilen ürünün adını ve sipariş adedini (adet bazında) bulun.
with ProductOrders AS (
    select p.ProductName, COUNT(o.OrderID) as siparis_adet
    from dbo.[Order Details] o
    inner join Products p on o.ProductID = p.ProductID
    group by p.ProductName
)
select ProductName, siparis_adet
from ProductOrders
where siparis_adet = (select MAX(siparis_adet) from ProductOrders)

--10. View Oluşturma:
--Ürünler ve kategoriler bilgilerini birleştiren bir görünüm (view) oluşturun.
create view vw_ProductsWithCategories as

select p.ProductName,
 p.ProductID,
    p.ProductName,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock,
    c.CategoryID,
    c.CategoryName,
    c.Description as CategoryDescription
from 
inner join Categories c on p.CategoryID = c.CategoryID

select *
from vw_ProductsWithCategories


--11. Trigger:Ürün silindiğinde log tablosuna kayıt yapan bir trigger yazınız.


--12. Stored Procedure: Belirli bir ülkeye ait müşterileri listeleyen bir stored procedure yazınız.


--13. Left Join Kullanımı: Tüm ürünlerin tedarikçileriyle (suppliers) birlikte listesini yapın. Tedarikçisi olmayan ürünler de listelensin.


--14. Fiyat Ortalamasının Üzerindeki Ürünler: Fiyatı ortalama fiyatın üzerinde olan ürünleri listeleyin.


--15. En Çok Ürün Satan Çalışan: Sipariş detaylarına göre en çok ürün satan çalışan kimdir?

