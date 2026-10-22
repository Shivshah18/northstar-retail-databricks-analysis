SELECT ReturnReason,
  COUNT(*) AS ReturnedOrders, SUM(ReturnedQty) AS ReturnedUnits,
  ROUND(SUM(Refund),2) AS Refund
FROM workspace.northstar_project2.vw_order_finance WHERE ReturnedQty>0
GROUP BY ReturnReason ORDER BY ReturnedOrders DESC;
