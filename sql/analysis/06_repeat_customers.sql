WITH c AS (
 SELECT CustomerID, COUNT(*) AS CompletedOrders
 FROM workspace.northstar_project2.vw_order_finance WHERE Status='Completed'
 GROUP BY CustomerID
)
SELECT COUNT(*) AS PurchasingCustomers,
 SUM(CASE WHEN CompletedOrders>1 THEN 1 ELSE 0 END) AS RepeatCustomers,
 ROUND(100.0*SUM(CASE WHEN CompletedOrders>1 THEN 1 ELSE 0 END)
  /NULLIF(COUNT(*),0),2) AS RepeatCustomerPct
FROM c;
