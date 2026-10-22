SELECT 'customers' AS TableName, COUNT(*) AS RowCount FROM workspace.northstar_project2.customers
UNION ALL SELECT 'products', COUNT(*) FROM workspace.northstar_project2.products
UNION ALL SELECT 'orders', COUNT(*) FROM workspace.northstar_project2.orders
UNION ALL SELECT 'returns', COUNT(*) FROM workspace.northstar_project2.returns
UNION ALL SELECT 'finance', COUNT(*) FROM workspace.northstar_project2.vw_order_finance;

-- Each result must be empty. Run these SELECT statements individually.
SELECT CustomerID, COUNT(*) AS N FROM workspace.northstar_project2.customers
GROUP BY CustomerID HAVING COUNT(*)>1 OR CustomerID IS NULL;
SELECT ProductID, COUNT(*) AS N FROM workspace.northstar_project2.products
GROUP BY ProductID HAVING COUNT(*)>1 OR ProductID IS NULL;
SELECT OrderID, COUNT(*) AS N FROM workspace.northstar_project2.orders
GROUP BY OrderID HAVING COUNT(*)>1 OR OrderID IS NULL;
SELECT ReturnID, COUNT(*) AS N FROM workspace.northstar_project2.returns
GROUP BY ReturnID HAVING COUNT(*)>1 OR ReturnID IS NULL;
SELECT o.OrderID FROM workspace.northstar_project2.orders o
LEFT JOIN workspace.northstar_project2.customers c ON c.CustomerID=o.CustomerID
LEFT JOIN workspace.northstar_project2.products p ON p.ProductID=o.ProductID
WHERE c.CustomerID IS NULL OR p.ProductID IS NULL;
SELECT r.ReturnID FROM workspace.northstar_project2.returns r
LEFT JOIN workspace.northstar_project2.orders o ON o.OrderID=r.OrderID
WHERE o.OrderID IS NULL OR o.Status<>'Completed'
 OR r.ReturnDate<o.OrderDate OR r.ReturnDate IS NULL
 OR r.ReturnQty IS NULL OR r.ReturnQty<=0
 OR r.RefundAmount IS NULL OR r.RefundAmount<0;
SELECT OrderID FROM workspace.northstar_project2.vw_order_finance
WHERE ReturnedQty>SoldQty OR Refund>MerchandiseSales
 OR Province IS NULL OR Category IS NULL;
SELECT OrderID FROM workspace.northstar_project2.orders
WHERE OrderDate IS NULL OR OrderDate<DATE '2025-01-01'
 OR OrderDate>DATE '2025-12-31' OR Quantity IS NULL OR Quantity NOT BETWEEN 1 AND 3
 OR UnitPrice IS NULL OR UnitPrice<=0 OR UnitCost IS NULL OR UnitCost<0
 OR Discount IS NULL OR Discount<0 OR Discount>Quantity*UnitPrice
 OR Channel IS NULL OR Channel NOT IN ('ONLINE','STORE')
 OR Status IS NULL OR Status NOT IN ('Completed','Canceled')
 OR ShippingRevenue IS NULL OR ShippingCost IS NULL
 OR (Channel='ONLINE' AND (ShippingRevenue<>14.99 OR ShippingCost<>35))
 OR (Channel='STORE' AND (ShippingRevenue<>0 OR ShippingCost<>0));
SELECT r.ReturnID FROM workspace.northstar_project2.returns r
JOIN workspace.northstar_project2.orders o ON o.OrderID=r.OrderID
WHERE ABS(r.RefundAmount-ROUND(
 (o.Quantity*o.UnitPrice-o.Discount)*r.ReturnQty/o.Quantity,2))>0.01;
SELECT OrderID FROM workspace.northstar_project2.vw_order_finance WHERE Status='Canceled'
 AND (SoldQty<>0 OR MerchandiseSales<>0 OR Refund<>0 OR ShipRev<>0
 OR ShipCost<>0 OR NetCOGS<>0 OR Contribution<>0);
