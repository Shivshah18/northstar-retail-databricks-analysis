-- Replaces only this project table with the supplied source snapshot.
CREATE OR REPLACE TABLE `YOUR_CATALOG`.northstar_project2.returns
USING DELTA AS
SELECT * FROM read_files(
  '/Volumes/YOUR_CATALOG/northstar_project2/source_files/returns.csv',
  format => 'csv',
  header => true,
  mode => 'FAILFAST',
  schema => 'ReturnID STRING, OrderID STRING, ReturnDate DATE, ReturnQty INT, RefundAmount DECIMAL(18,2), Reason STRING'
);
SELECT COUNT(*) AS RowCount FROM `YOUR_CATALOG`.northstar_project2.returns;
