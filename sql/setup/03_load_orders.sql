-- Replaces only this project table with the supplied source snapshot.
CREATE OR REPLACE TABLE `YOUR_CATALOG`.northstar_project2.orders
USING DELTA AS
SELECT * FROM read_files(
  '/Volumes/YOUR_CATALOG/northstar_project2/source_files/orders.csv',
  format => 'csv',
  header => true,
  mode => 'FAILFAST',
  schema => 'OrderID STRING, OrderDate DATE, CustomerID STRING, ProductID STRING, Channel STRING, Quantity INT, UnitPrice DECIMAL(18,2), UnitCost DECIMAL(18,2), Discount DECIMAL(18,2), ShippingRevenue DECIMAL(18,2), ShippingCost DECIMAL(18,2), Status STRING'
);
SELECT COUNT(*) AS RowCount FROM `YOUR_CATALOG`.northstar_project2.orders;
