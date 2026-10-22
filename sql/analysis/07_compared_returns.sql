SELECT Category,
 CASE WHEN Discount>0 THEN 'Discounted' ELSE 'Full price' END AS PriceGroup,
 SUM(CASE WHEN Status='Completed' THEN 1 ELSE 0 END) AS CompletedOrders,
  SUM(CASE WHEN ReturnedQty>0 THEN 1 ELSE 0 END) AS ReturnedOrders,
  ROUND(SUM(NetMerchandiseSales),2) AS NetMerchandiseSales,
  ROUND(SUM(Contribution),2) AS Contribution
FROM workspace.northstar_project2.vw_order_finance WHERE Status='Completed'
GROUP BY Category, CASE WHEN Discount>0 THEN 'Discounted' ELSE 'Full price' END
ORDER BY Category,PriceGroup;
