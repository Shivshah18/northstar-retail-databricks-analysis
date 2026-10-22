SELECT Province, SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution
FROM workspace.northstar_project2.vw_order_finance
WHERE OrderDate BETWEEN CAST(:start_date AS DATE) AND CAST(:end_date AS DATE)
  AND (:channel = 'ALL' OR Channel = :channel)
  AND (:province = 'ALL' OR Province = :province)
GROUP BY Province ORDER BY Province;
