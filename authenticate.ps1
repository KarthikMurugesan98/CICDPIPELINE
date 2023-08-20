$authHeaders = @{
   'Content-Type' = 'application/json'
}

$authBody = @{
   "grant_type"    = "refresh_token"
   "client_id"     = $env:ORCHESTRATOR_APP_ID
   "refresh_token" = $env:ORCHESTRATOR_APP_SECRET
}

$authResponse = Invoke-RestMethod -Uri "$env:ORCHESTRATOR_URL/identity/connect/token" -Headers $authHeaders -Method Post -Body ($authBody | ConvertTo-Json)
Write-Output "::set-output name=accessToken::$($authResponse.access_token)"
