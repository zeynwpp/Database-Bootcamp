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
create table ProductLog(
	logID int identity(1,1) primary key,
	ProductID int,
	ProductName nvarchar(255),
	DeletedAt DATETIME default GETDATE(),
    DeletedBy NVARCHAR(255)
	)

create trigger trg_ProductDeleteLog
on Products
after delete
as
begin
    insert into ProductLog (ProductID, ProductName, DeletedAt, DeletedBy)
    select d.ProductID, d.ProductName, GETDATE(), SUSER_NAME()
    from deleted d;
end;

--12. Stored Procedure: Belirli bir ülkeye ait müşterileri listeleyen bir stored procedure yazınız.
create procedure pro1 
@which_country nvarchar(30)
as
select *
from Customers c
where c.Country = @which_country
go

exec pro1 @which_country = 'Germany'


--13. Left Join Kullanımı: Tüm ürünlerin tedarikçileriyle (suppliers) birlikte listesini yapın. Tedarikçisi olmayan ürünler de listelensin.
select *
 from Products p
 left join Suppliers s on s.SupplierID = p.SupplierID

--14. Fiyat Ortalamasının Üzerindeki Ürünler: Fiyatı ortalama fiyatın üzerinde olan ürünleri listeleyin.
select *
from Products pp
where pp.UnitPrice > (
select avg(p.UnitPrice)
from Products p
)

--15. En Çok Ürün Satan Çalışan: Sipariş detaylarına göre en çok ürün satan çalışan kimdir?
with ToplamUrunSatis as(
select os.EmployeeID
,sum(o.Quantity) as ToplamUrun
from [Order Details] o
inner join Orders os on os.OrderID = o.OrderID
group by os.EmployeeID)

select *
from ToplamUrunSatis t
where t.ToplamUrun = (select max(ToplamUrun) from ToplamUrunSatis)

--16.Stok miktarı 10’un altında olan ürünleri listeleyiniz
select *
from Products p
where p.UnitsInStock < 10

--17.Her müşteri şirketinin yaptığı sipariş sayısını ve toplam harcamasını bulun.
with cost_order_customer as (select c.CompanyName,
        o.OrderID
		,od.unitprice * od.quantity as cost
from Customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join [Order Details] od on od.OrderID = o.OrderID)

select cs.CompanyName
,count(cs.OrderID) as siparis_sayisi
,sum(cs.cost) as toplam_harcama
from cost_order_customer cs
group by cs.CompanyName
order by 2, 3

--18.Hangi ülkede en fazla müşteri var?
select top 1 c.Country
,count(c.CustomerID) as musteri_sayisi
from Customers c
group by c.Country
order by 2 desc

--19.Siparişlerde kaç farklı ürün olduğu bilgisini listeleyin.
select o.OrderID
,count(distinct od.ProductID) as kac_farkli_urun
from Orders o
inner join [Order Details] od on od.OrderID = o.OrderID
group by o.OrderID
order by 2 desc

--20. Her kategoriye göre ortalama ürün fiyatını bulun.
select c.CategoryID
,avg(p.UnitPrice) as ort_fiyat
from Products p
inner join Categories c  on c.CategoryID = p.CategoryID
group by c.CategoryID

--21.Siparişleri ay ay gruplayarak kaç sipariş olduğunu listeleyin.

--22.Her çalışanın ilgilendiği müşteri sayısını listeleyin.

--23.Hiç siparişi olmayan müşterileri listeleyin.

--24.Siparişlerin Nakliye (Freight) Maliyeti Analizi: Nakliye maliyetine göre en pahalı 5 siparişi listeleyin.


