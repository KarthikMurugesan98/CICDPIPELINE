$authHeaders = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
 }
 $authBody = @{
    'grant_type'    = 'refresh_token'
    'client_id'     = $env:ORCHESTRATOR_APP_ID
    'refresh_token' = $env:ORCHESTRATOR_APP_SECRET
 }
 
 try {
    $authResponse = Invoke-RestMethod -Uri "https://cloud.uipath.com/karthiktecnology/DefaultTenant/identity/connect/token" -Headers $authHeaders -Method Post -Body $authBody
    if ($authResponse -and $authResponse.access_token) {
       Write-Output "::set-output name=accessToken::$($authResponse.access_token)"
    } else {
       throw "Authentication failed. Check your credentials and endpoint URL."
    }
 } catch {
    throw "An error occurred during authentication: $_"
 }
 