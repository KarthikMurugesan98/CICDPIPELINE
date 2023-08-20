$authHeaders = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
}

$authBody = @{
    'grant_type'    = 'refresh_token';
    'client_id'     = $env:ORCHESTRATOR_APP_ID;
    'refresh_token' = $env:ORCHESTRATOR_APP_SECRET;
}

$encodedBody = $authBody | ForEach-Object { "$($_.Key)=$($_.Value)" } -join '&'

$authResponse = Invoke-RestMethod -Uri "$env:ORCHESTRATOR_URL/identity/connect/token" -Method Post -Headers $authHeaders -Body $encodedBody

if ($authResponse.access_token) {
    Write-Output "::set-output name=accessToken::$($authResponse.access_token)"
} else {
    throw "Authentication failed. Check your credentials and endpoint URL."
}
