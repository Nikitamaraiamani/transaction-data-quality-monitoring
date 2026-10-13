
# Transaction Data Quality Checks
# Tool: Windows PowerShell

$transactions = @(Import-Csv ".\transactions.csv")

# Check for data quality issues
$missingAmounts = @($transactions | Where-Object {
    [string]::IsNullOrWhiteSpace($_.Amount)
})

$duplicateIDs = @(
    $transactions |
    Group-Object TransactionID |
    Where-Object { $_.Count -gt 1 }
)

$negativeAmounts = @($transactions | Where-Object {
    $_.Amount -match '^-?\d+(\.\d+)?$' -and
    [decimal]$_.Amount -lt 0
})

$invalidStatuses = @($transactions | Where-Object {
    $_.Status -notin @("Success", "Failed", "Pending")
})

$missingDates = @($transactions | Where-Object {
    [string]::IsNullOrWhiteSpace($_.TransactionDate)
})

$invalidAccounts = @($transactions | Where-Object {
    $_.AccountType -notin @("Savings", "Current", "Credit")
})

# Create the summary report
$report = @(
    [PSCustomObject]@{
        Check = "Total Records"
        IssueCount = $transactions.Count
    }
    [PSCustomObject]@{
        Check = "Missing Amounts"
        IssueCount = $missingAmounts.Count
    }
    [PSCustomObject]@{
        Check = "Duplicate Transaction IDs"
        IssueCount = $duplicateIDs.Count
    }
    [PSCustomObject]@{
        Check = "Negative Amounts"
        IssueCount = $negativeAmounts.Count
    }
    [PSCustomObject]@{
        Check = "Invalid Statuses"
        IssueCount = $invalidStatuses.Count
    }
    [PSCustomObject]@{
        Check = "Missing Dates"
        IssueCount = $missingDates.Count
    }
    [PSCustomObject]@{
        Check = "Invalid Account Types"
        IssueCount = $invalidAccounts.Count
    }
)

# Display and export the report
$report | Format-Table -AutoSize
$report | Export-Csv ".\data_quality_report.csv" -NoTypeInformation

Write-Host "`nData quality report created successfully."
