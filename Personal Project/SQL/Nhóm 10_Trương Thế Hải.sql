C1:
Select PurchaseOrderID as OrderID, 
        DueDate as 'Ngày đặt hàng', 
        OrderQty as 'Số lượng SP order',
        RejectedQty as 'Số lượng SP bị từ chối',
        ProductID as 'ID sản phẩm', 
        UnitPrice as 'Giá sản phẩm', 
        ModifiedDate as 'Ngày cập nhật thông tin' 
from Purchasing.PurchaseOrderDetail


C2:
Select B.EmployeeID, 
        count(distinct A.PurchaseOrderID) Tong_SL_DonHang,
	sum(ReceivedQty) Tong_SL_SP_Giao_TC, 
        round(sum(A.LineTotal),0) Tong_GT_mua,
        rank() over (order by sum(A.LineTotal) desc) as rank_column
from Purchasing.PurchaseOrderDetail as A
inner join Purchasing.PurchaseOrderHeader as B
on A.PurchaseOrderID = B.PurchaseOrderID
where Status = 4
group by B.EmployeeID
order by Tong_GT_mua desc


C3:
Select P.BusinessEntityID, FirstName, MiddleName, LastName, StartDate, EndDate, DepartmentID
from HumanResources.EmployeeDepartmentHistory as E
inner join Person.Person as P
on E.BusinessEntityID = P.BusinessEntityID
where EndDate is not null