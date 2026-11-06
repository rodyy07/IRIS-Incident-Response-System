
# IRIS - Windows Security Event Collector
# Collects Event ID 4625 from the last 7 days.

$StartTime = (Get-Date).AddDays(-7)
$OutputPath = Join-Path (Get-Location).Path "windows_4625.json"

try {
    $Events = Get-WinEvent -FilterHashtable @{
        LogName   = 'Security'
        Id        = 4625
        StartTime = $StartTime
    } -ErrorAction Stop

    $Results = foreach ($Event in $Events) {
        [xml]$Xml = $Event.ToXml()
        $Data = @{}

        foreach ($Item in $Xml.Event.EventData.Data) {
            $Data[$Item.Name] = $Item.'#text'
        }

        [PSCustomObject]@{
            EventId       = $Event.Id
            RecordId      = $Event.RecordId
            TimeCreated   = $Event.TimeCreated.ToString("o")
            Computer      = $Event.MachineName
            Username      = $Data['TargetUserName']
            Domain        = $Data['TargetDomainName']
            SourceIP      = $Data['IpAddress']
            Workstation   = $Data['WorkstationName']
            LogonType     = $Data['LogonType']
            Status        = $Data['Status']
            SubStatus     = $Data['SubStatus']
            ProcessName   = $Data['ProcessName']
            AuthenticationPackage = $Data['AuthenticationPackageName']
        }
    }

    $Results | ConvertTo-Json -Depth 5 |
        Set-Content -Path $OutputPath -Encoding UTF8

    Write-Host "IRIS Collector completed!" -ForegroundColor Green
    Write-Host "Events collected: $($Results.Count)"
    Write-Host "JSON saved to: $OutputPath"
}
catch {
    if ($_.FullyQualifiedErrorId -like '*NoMatchingEventsFound*') {
        Write-Host "No Event ID 4625 records found in the last 7 days."
    }
    else {
        Write-Host "Collector error: $($_.Exception.Message)" -ForegroundColor Red
    }
}





