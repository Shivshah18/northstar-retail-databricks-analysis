# Data source and provenance
All CSV records are synthetic and were generated for this independent portfolio with a supplied AI-assisted Python script: optional-python/generate_data.py, seed 42.
No Article, Kaggle, government, real retailer, or customer records are used.
Northstar Furniture is fictional. Province codes and retail categories describe a simulated Canadian setting; they do not make the records real.
Data: 500 customers, 30 products, 10000 one-product orders in 2025, 572 return events, 2000 support tickets. Tickets are not used in the sales report.
Rules: random dates/customer/product links; assigned prices; merchandise cost 55% of price; modeled online shipping revenue 14.99 and cost 35; higher programmed sofa-return probability. These are assumptions, not real business evidence.
CSV files are already supplied. Python generation is optional. This Databricks version uploads four CSV files to a Unity Catalog volume and loads typed Delta tables using read_files. The older SQL Server INSERT loader is not used.
Describe your personal contribution accurately. Do not claim you independently generated the original dataset if you only used the supplied files.
The software documentation URLs are reference sources, not data sources.
