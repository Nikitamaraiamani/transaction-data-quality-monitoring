# Transaction Data Quality Monitoring Using PowerShell

## Project Overview
This project uses Windows PowerShell to identify common data-quality issues in a sample transaction dataset and generate a CSV summary report.

## Tools Used
- Windows PowerShell
- CSV files
- Data validation

## Data Quality Checks
- Missing transaction amounts
- Duplicate transaction IDs
- Negative transaction amounts
- Invalid transaction statuses
- Missing transaction dates
- Invalid account types

## Dataset
The dataset contains 50 synthetic transaction records with intentional data-quality issues. It contains no real banking or customer information.

## Project Files
- `transactions.csv` — Sample transaction dataset
- `data_quality_checks.ps1` — PowerShell script for data-quality checks
- `data_quality_report.csv` — Summary report of detected issues


## Outcome
This project demonstrates basic data validation, identification of data-quality issues, and automated CSV report generation using PowerShell.
