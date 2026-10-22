-- Replaces only this project table with the supplied source snapshot.
CREATE OR REPLACE TABLE `YOUR_CATALOG`.northstar_project2.products
USING DELTA AS
SELECT * FROM read_files(
  '/Volumes/YOUR_CATALOG/northstar_project2/source_files/products.csv',
  format => 'csv',
  header => true,
  mode => 'FAILFAST',
  schema => 'ProductID STRING, Category STRING, UnitPrice DECIMAL(18,2), UnitCost DECIMAL(18,2)'
);
SELECT COUNT(*) AS RowCount FROM `YOUR_CATALOG`.northstar_project2.products;
