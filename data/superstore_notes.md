# Dataset Notes

## Source
- **Dataset:** Sample Superstore
- **Provider:** Kaggle
- **Uploaded by:** Kancharla Naveen Kumar
- **File included:** SampleSuperstore.csv

## Dataset Details
- **Rows:** 9,994 orders
- **Columns:** 18
- **Time Period:** 2014–2017
- **Geography:** United States only

## Columns
Row ID, Order ID, Order Date, Ship Date, Ship Mode, Customer ID, 
Segment, Country, City, State, Region, Product ID, Category, 
Sub-Category, Product Name, Sales, Quantity, Discount, Profit

## Data Cleaning
- Order Date column contained mixed date formats (DD-MM-YYYY and
  M/DD/YYYY) and was cleaned in Excel
- All dates standardized to ISO format (YYYY-MM-DD) before importing
  into SQLite
- No missing values found across any column