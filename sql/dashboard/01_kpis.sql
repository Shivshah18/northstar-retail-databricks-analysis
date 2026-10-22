SELECT
  SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution,
  SUM(SoldQty) AS SoldQty, SUM(ReturnedQty) AS ReturnedQty,
  ROUND(SUM(MerchandiseSales),2) AS MerchandiseSales,
  ROUND(SUM(Refund),2) AS Refund,
  ROUND(SUM(ShipRev),2) AS ShipRev,
  ROUND(SUM(ShipCost),2) AS ShipCost,
  ROUND(SUM(NetCOGS),2) AS NetCOGS,
  ROUND(SUM(MerchandiseSales)/NULLIF(
    SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END),0),2) AS AOV,
  ROUND(100.0*SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END)/NULLIF(
    SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END),0),4) AS ReturnOrderPct,
  ROUND(100.0*SUM(Contribution)/NULLIF(SUM(NetMerchandiseSales),0),4) AS ContributionPct
FROM workspace.northstar_project2.vw_order_finance
WHERE OrderDate BETWEEN CAST(:start_date AS DATE) AND CAST(:end_date AS DATE)
  AND (:channel = 'ALL' OR Channel = :channel)
  AND (:province = 'ALL' OR Province = :province);
