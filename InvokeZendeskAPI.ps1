#Currently the username must be specified like this - "example@domain.com/token" - We should probably add the token part as a string to the end of the email.

function InvokeZendeskAPI
{

    Param
    (
        [string]$InstanceURL,
        [string]$APIEndpoint,
        [string]$Method,
        [string]$Username,
        [string]$Token
    )

    $Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));} 

    $Output = Invoke-RestMethod -Uri ($InstanceURL+$APIEndpoint) -Method $Method -Headers $Headers -ContentType "application/json"
    return $Output
    
}