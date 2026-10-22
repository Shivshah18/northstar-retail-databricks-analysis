SELECT Category,
  SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution,
  ROUND(100.0*SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END)/NULLIF(
    SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END),0),2) AS ReturnOrderPct
FROM workspace.northstar_project2.vw_order_finance
WHERE OrderDate BETWEEN CAST(:start_date AS DATE) AND CAST(:end_date AS DATE)
  AND (:channel = 'ALL' OR Channel = :channel)
  AND (:province = 'ALL' OR Province = :province)
GROUP BY Category
ORDER BY NetMerchandiseSales DESC;
