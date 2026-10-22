WITH p AS (
 SELECT ProductID,Category,
   SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution
 FROM workspace.northstar_project2.vw_order_finance GROUP BY ProductID,Category
)
SELECT *, DENSE_RANK() OVER (
 PARTITION BY Category ORDER BY Contribution DESC) AS CategoryContributionRank
FROM p ORDER BY Category,CategoryContributionRank,ProductID;
