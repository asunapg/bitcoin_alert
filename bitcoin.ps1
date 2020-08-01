$PlayWav=New-Object System.Media.SoundPlayer
$PlayWav.SoundLocation='you_suffer.wav'

$Response = Invoke-WebRequest -URI "https://api.coindesk.com/v1/bpi/currentprice.json" | ConvertFrom-Json
$StartingRate = $Response.bpi.USD.rate
Write-Host "Starting Amount (USD): $StartingRate"

While (0 -lt 1){
    Start-Sleep -Seconds 120
    $Response = Invoke-WebRequest -URI "https://api.coindesk.com/v1/bpi/currentprice.json" | ConvertFrom-Json
    $CurrentRate = $Response.bpi.USD.rate
    If($StartingRate -gt $CurrentRate){
        $Difference = $StartingRate - $CurrentRate 
        $PlayWav.PlaySync()
       Write-Host "Current Price (USD): $CurrentRate - Down"
    }
    If($StartingRate -lt $CurrentRate){
        $Difference = $StartingRate - $CurrentRate
        $PlayWav.PlaySync()
        Write-Host "Current Price (USD): $CurrentRate - Up"
    }
    If($StartingRate -eq $CurrentRate){
        $PlayWav.PlaySync()
        Write-Host "Current Price(USD): $CurrentRate"
    }
    $StartingRate = $CurrentRate
}