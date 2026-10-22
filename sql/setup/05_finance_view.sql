CREATE OR REPLACE VIEW `YOUR_CATALOG`.northstar_project2.vw_order_finance AS
WITH r AS (
  SELECT OrderID, SUM(ReturnQty) AS ReturnedQty,
    SUM(RefundAmount) AS Refund, MAX(Reason) AS ReturnReason
  FROM `YOUR_CATALOG`.northstar_project2.returns GROUP BY OrderID
), b AS (
  SELECT o.*, c.Province, p.Category,
    CASE WHEN o.Status='Completed' THEN o.Quantity ELSE 0 END AS SoldQty,
    CASE WHEN o.Status='Completed'
      THEN o.Quantity*o.UnitPrice-o.Discount ELSE 0 END AS MerchandiseSales,
    CASE WHEN o.Status='Completed' THEN o.ShippingRevenue ELSE 0 END AS ShipRev,
    CASE WHEN o.Status='Completed' THEN o.ShippingCost ELSE 0 END AS ShipCost,
    COALESCE(r.ReturnedQty,0) AS ReturnedQty,
    COALESCE(r.Refund,0) AS Refund, r.ReturnReason
  FROM `YOUR_CATALOG`.northstar_project2.orders o
  LEFT JOIN r ON r.OrderID=o.OrderID
  LEFT JOIN `YOUR_CATALOG`.northstar_project2.customers c ON c.CustomerID=o.CustomerID
  LEFT JOIN `YOUR_CATALOG`.northstar_project2.products p ON p.ProductID=o.ProductID
)
SELECT *,
  MerchandiseSales-Refund AS NetMerchandiseSales,
  (SoldQty-ReturnedQty)*UnitCost AS NetCOGS,
  MerchandiseSales-Refund+ShipRev
    -(SoldQty-ReturnedQty)*UnitCost-ShipCost AS Contribution
FROM b;
SELECT COUNT(*) AS FinanceRows FROM `YOUR_CATALOG`.northstar_project2.vw_order_finance;
SELECT * FROM `YOUR_CATALOG`.northstar_project2.vw_order_finance ORDER BY OrderID LIMIT 10;
