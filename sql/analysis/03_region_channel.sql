SELECT Province, Channel,
  SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution,
  ROUND(SUM(ShipRev),2) AS ShippingRevenue,
  ROUND(SUM(ShipCost),2) AS ShippingCost,
  ROUND(SUM(ShipRev-ShipCost),2) AS ShippingGap
FROM workspace.northstar_project2.vw_order_finance GROUP BY Province,Channel
ORDER BY Province,Channel;
