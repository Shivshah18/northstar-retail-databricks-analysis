-- Replaces only this project table with the supplied source snapshot.
CREATE OR REPLACE TABLE workspace.northstar_project2.customers
USING DELTA AS
SELECT * FROM read_files(
  '/Volumes/YOUR_CATALOG/northstar_project2/source_files/customers.csv',
  format => 'csv',
  header => true,
  mode => 'FAILFAST',
  schema => 'CustomerID STRING, Province STRING'
);
SELECT COUNT(*) AS RowCount FROM workspace.northstar_project2.customers;
