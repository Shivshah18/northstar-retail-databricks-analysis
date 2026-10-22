WITH m AS (
 SELECT CAST(date_trunc('MONTH',OrderDate) AS DATE) AS MonthStart,
   SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution
 FROM workspace.northstar_project2.vw_order_finance GROUP BY 1
), l AS (
 SELECT *, LAG(NetMerchandiseSales) OVER (ORDER BY MonthStart) AS PreviousMonthSales
 FROM m
)
SELECT *, ROUND(100.0*(NetMerchandiseSales-PreviousMonthSales)
 /NULLIF(PreviousMonthSales,0),2) AS SalesMoMPct
FROM l ORDER BY MonthStart;
