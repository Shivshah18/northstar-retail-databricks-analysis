SELECT ReturnReason,
COUNT(*) AS ReturnedOrders, SUM(ReturnedQty) AS ReturnedUnits,
ROUND(SUM(Refund),2) AS Refund
FROM workspace.northstar_project2.vw_order_finance
WHERE OrderDate BETWEEN CAST(:start_date AS DATE) AND CAST(:end_date AS DATE)
  AND (:channel = 'ALL' OR Channel = :channel)
  AND (:province = 'ALL' OR Province = :province)
AND ReturnedQty>0
GROUP BY ReturnReason 
ORDER BY ReturnedOrders DESC;